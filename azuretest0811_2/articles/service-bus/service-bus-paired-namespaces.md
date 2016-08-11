---
title: Service Bus paired namespaces | Microsoft Azure
description: Paired namespace implementation details and cost
services: service-bus
documentationcenter: na
author: sethmanheim
manager: timlt
editor: ''

ms.service: service-bus
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: na
ms.date: 06/27/2016
ms.author: sethm

---
# Paired namespace implementation details and cost implications
The [PairNamespaceAsync](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.pairnamespaceasync.aspx) method, using a [SendAvailabilityPairedNamespaceOptions](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.sendavailabilitypairednamespaceoptions.aspx) instance, performs visible tasks on your behalf. Because there are cost considerations when using the feature, it is useful to understand those tasks so that you expect the behavior when it happens. The API engages the following automatic behavior on your behalf:

* Creation of backlog queues.
* Creation of a [MessageSender](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagesender.aspx) object that talks to queues or topics.
* When a messaging entity becomes unavailable, sends ping messages to the entity in an attempt to detect when that entity becomes available again.
* Optionally creates of a set of “message pumps” that move messages from the backlog queues to the primary queues.
* Coordinates closing/faulting of the primary and secondary [MessagingFactory](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.aspx) instances.

At a high level, the feature works as follows: when the primary entity is healthy, no behavior changes occur. When the [FailoverInterval](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.pairednamespaceoptions.failoverinterval.aspx) duration elapses, and the primary entity sees no successful sends after a non-transient [MessagingException](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingexception.aspx) or a [TimeoutException](https://msdn.microsoft.com/library/azure/system.timeoutexception.aspx), the following behavior occurs:

1. Send operations to the primary entity are disabled and the system pings the primary entity until pings can be successfully delivered.
2. A random backlog queue is selected.
3. [BrokeredMessage](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.aspx) objects are routed to the chosen backlog queue.
4. If a send operation to the chosen backlog queue fails, that queue is pulled from the rotation and a new queue is selected. All senders on the [MessagingFactory](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.aspx) instance learn of the failure.

The following figures depict the sequence. First, the sender sends messages.

![Paired Namespaces](./media/service-bus-paired-namespaces/IC673405.png)

Upon failure to send to the primary queue, the sender begins sending messages to a randomly chosen backlog queue. Simultaneously, it starts a ping task.

![Paired Namespaces](./media/service-bus-paired-namespaces/IC673406.png)

At this point the messages are still in the secondary queue and have not been delivered to the primary queue. Once the primary queue is healthy again, at least one process should be running the syphon. The syphon delivers the messages from all the various backlog queues to the proper destination entities (queues and topics).

![Paired Namespaces](./media/service-bus-paired-namespaces/IC673407.png)

The remainder of this topic discusses the specific details of how these pieces work.

## Creation of backlog queues
The [SendAvailabilityPairedNamespaceOptions](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.sendavailabilitypairednamespaceoptions.aspx) object passed to the [PairNamespaceAsync](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.pairnamespaceasync.aspx) method indicates the number of backlog queues you want to use. Each backlog queue is then created with the following properties explicitly set (all other values are set to the [QueueDescription](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.queuedescription.aspx) defaults):

| Path | [primary namespace]/x-servicebus-transfer/[index] where [index] is a value in [0, BacklogQueueCount) |
| --- | --- |
| MaxSizeInMegabytes |5120 |
| MaxDeliveryCount |int.MaxValue |
| DefaultMessageTimeToLive |TimeSpan.MaxValue |
| AutoDeleteOnIdle |TimeSpan.MaxValue |
| LockDuration |1 minute |
| EnableDeadLetteringOnMessageExpiration |true |
| EnableBatchedOperations |true |

For example, the first backlog queue created for namespace **contoso** is named `contoso/x-servicebus-transfer/0`.

When creating the queues, the code first checks to see if such a queue exists. If the queue does not exist, then the queue is created. The code does not clean up "extra" backlog queues. Specifically, if the application with the primary namespace **contoso** requests five backlog queues but a backlog queue with the path `contoso/x-servicebus-transfer/7` exists, that extra backlog queue is still present but is not used. The system explicitly allows extra backlog queues to exist that would not be used. As the namespace owner, you are responsible for cleaning up any unused/unwanted backlog queues. The reason for this decision is that Service Bus cannot know what purposes exist for all the queues in your namespace. Furthermore, if a queue exists with the given name but does NOT meet the assumed [QueueDescription](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.queuedescription.aspx), then your reasons are your own for changing the default behavior. No guarantees are made for modifications to the backlog queues by your code. Make sure to test your changes thoroughly.

## Custom MessageSender
When sending, all messages go through an internal [MessageSender](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagesender.aspx) object that behaves normally when everything works, and redirects to the backlog queues when things "break." Upon receiving a non-transient failure, a timer starts. After a [TimeSpan](https://msdn.microsoft.com/library/azure/system.timespan.aspx) period consisting of the [FailoverInterval](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.pairednamespaceoptions.failoverinterval.aspx) property value during which no successful messages are sent, the failover is engaged. At this point, the following things happen for each entity:

* A ping task executes every [PingPrimaryInterval](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.sendavailabilitypairednamespaceoptions.pingprimaryinterval.aspx) to check if the entity is available. Once this task succeeds, all client code that uses the entity immediately starts sending new messages to the primary namespace.
* Future requests to send to that same entity from any other senders will result in the [BrokeredMessage](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.aspx) being sent to be modified to sit in the backlog queue. The modification removes some properties from the [BrokeredMessage](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.aspx) object and stores them elsewhere. The following properties are cleared and added under a new alias, allowing Service Bus and the SDK to process messages uniformly:

| Old Property Name | New Property Name |
| --- | --- |
| SessionId |x-ms-sessionid |
| TimeToLive |x-ms-timetolive |
| ScheduledEnqueueTimeUtc |x-ms-path |

The original destination path is also stored within the message as a property named x-ms-path. This design allows messages for many entities to coexist in a single backlog queue. The properties are translated back by the syphon.

The custom [MessageSender](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagesender.aspx) object can encounter issues when messages approach the 256-KB limit and failover is engaged. The custom [MessageSender](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagesender.aspx) object stores messages for all queues and topics together in the backlog queues. This object mixes messages from many primaries together within the backlog queues. To handle load balancing among many clients that do not know each other, the SDK randomly picks one backlog queue for each [QueueClient](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.queueclient.aspx) or [TopicClient](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.topicclient.aspx) you create in code.

## Pings
A ping message is an empty [BrokeredMessage](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.aspx) with its [ContentType](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.contenttype.aspx) property set to application/vnd.ms-servicebus-ping and a [TimeToLive](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.timetolive.aspx) value of 1 second. This ping has one special characteristic in Service Bus: the server never delivers a ping when any caller requests a [BrokeredMessage](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.aspx). Thus, you never have to learn how to receive and ignore these messages. Each entity (unique queue or topic) per [MessagingFactory](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.aspx) instance per client will be pinged when they are considered to be unavailable. By default, this happens once per minute. Ping messages are considered to be regular Service Bus messages, and can result in charges for bandwidth and messages. As soon as the clients detect that the system is available, the messages stop.

## The syphon
At least one executable program in the application should be actively running the syphon. The syphon performs a long poll receive that lasts 15 minutes. When all entities are available and you have 10 backlog queues, the application that hosts the syphon calls the receive operation 40 times per hour, 960 times per day, and 28800 times in 30 days. When the syphon is actively moving messages from the backlog to the primary queue, each message experiences the following charges (standard charges for message size and bandwidth apply in all stages):

1. Send to the backlog.
2. Receive from the backlog.
3. Send to the primary.
4. Receive from the primary.

## Close/fault behavior
Within an application that hosts the syphon, once the primary or secondary [MessagingFactory](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.aspx) faults or is closed without its partner also being faulted/closed and the syphon detects this state, the syphon acts. If the other [MessagingFactory](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.aspx) is not closed within 5 seconds, the syphon will fault the still open [MessagingFactory](https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.aspx).

## Next steps
See [Asynchronous messaging patterns and high availability](service-bus-async-messaging.md) for a detailed discussion of Service Bus asynchronous messaging. 

  [PairNamespaceAsync]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.pairnamespaceasync.aspx
  [SendAvailabilityPairedNamespaceOptions]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.sendavailabilitypairednamespaceoptions.aspx
  [MessageSender]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagesender.aspx
  [MessagingFactory]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingfactory.aspx
  [FailoverInterval]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.pairednamespaceoptions.failoverinterval.aspx
  [MessagingException]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.messagingexception.aspx
  [TimeoutException]: https://msdn.microsoft.com/library/azure/system.timeoutexception.aspx
  [BrokeredMessage]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.aspx
  [QueueDescription]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.queuedescription.aspx
  [TimeSpan]: https://msdn.microsoft.com/library/azure/system.timespan.aspx
  [PingPrimaryInterval]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.sendavailabilitypairednamespaceoptions.pingprimaryinterval.aspx
  [QueueClient]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.queueclient.aspx
  [TopicClient]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.topicclient.aspx
  [ContentType]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.contenttype.aspx
  [TimeToLive]: https://msdn.microsoft.com/library/azure/microsoft.servicebus.messaging.brokeredmessage.timetolive.aspx
  [Asynchronous messaging patterns and high availability]: service-bus-async-messaging.md
  [0]: ./media/service-bus-paired-namespaces/IC673405.png
  [1]: ./media/service-bus-paired-namespaces/IC673406.png
  [2]: ./media/service-bus-paired-namespaces/IC673407.png
