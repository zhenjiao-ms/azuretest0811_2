---
title: Get Started with Event Hubs in C and C# | Microsoft Azure
description: Follow this tutorial to get started using Azure Event Hubs; sending events in C and receiving hem in C# using the EventProcessorHost.
services: event-hubs
documentationcenter: ''
author: fsautomata
manager: timlt
editor: ''

ms.service: event-hubs
ms.workload: na
ms.tgt_pltfrm: c
ms.devlang: csharp
ms.topic: article
ms.date: 05/13/2016
ms.author: sethm

---
# Get started with Event Hubs
[!INCLUDE [service-bus-selector-get-started](../../includes/service-bus-selector-get-started.md)]

## Introduction
Event Hubs is a highly scalable ingestion system that can intake millions of events per second, enabling an application to process and analyze the massive amounts of data produced by your connected devices and applications. Once collected into Event Hubs, you can transform and store data using any real-time analytics provider or storage cluster.

For more information, please see [Event Hubs Overview](event-hubs-overview.md).

In this tutorial, you will learn how to ingest messages into an Event Hub using a console application in C, and to retrieve them in parallel using the C# [Event Processor Host](https://www.nuget.org/packages/Microsoft.Azure.ServiceBus.EventProcessorHost) library.

In order to complete this tutorial you will need the following:

* A C development environment. For this tutorial, we will assume the gcc stack on an [Azure Linux VM](../virtual-machines/virtual-machines-linux-quick-create-cli.md) with Ubuntu 14.04. Instructions for other environments will be provided in external links.
* Microsoft Visual Studio Express for Windows
* An active Azure account. <br/>If you don't have an account, you can create a free trial account in just a couple of minutes. For details, see <a href="http://azure.microsoft.com/pricing/free-trial/?WT.mc_id=A0E0E5C02&amp;returnurl=http%3A%2F%2Fazure.microsoft.com%2Fen-us%2Fdevelop%2Fmobile%2Ftutorials%2Fget-started%2F" target="_blank">Azure Free Trial</a>.

[!INCLUDE [event-hubs-create-event-hub](../../includes/event-hubs-create-event-hub.md)]

[!INCLUDE [service-bus-event-hubs-get-started-send-c](../../includes/service-bus-event-hubs-get-started-send-c.md)]

[!INCLUDE [service-bus-event-hubs-get-started-receive-ephcs](../../includes/service-bus-event-hubs-get-started-receive-ephcs.md)]

## Run the applications
Now you are ready to run the applications.

1. Run the **Receiver** project from within Visual Studio, then wait for it to start the receivers for all the partitions.
   
   ![](./media/event-hubs-c-ephcs-getstarted/run-csharp-ephcs1.png)
2. Run the **Sender** program, and see the events appear in the receiver window.
   
   ![](./media/event-hubs-c-ephcs-getstarted/receive-eph-c.png)

## Next steps
Now that you've built a working application that creates an Event Hub and sends and receives data, you can move on to the following scenarios:

* A complete [sample application that uses Event Hubs](https://code.msdn.microsoft.com/Service-Bus-Event-Hub-286fd097).
* The [Scale out Event Processing with Event Hubs](https://code.msdn.microsoft.com/Service-Bus-Event-Hub-45f43fc3) sample.
* A [queued messaging solution](../service-bus/service-bus-dotnet-multi-tier-app-using-service-bus-queues.md) using Service Bus queues.
* [Event Hubs overview](event-hubs-overview.md)

<!-- Images. -->
[21]: ./media/event-hubs-c-ephcs-getstarted/run-csharp-ephcs1.png
[24]: ./media/event-hubs-c-ephcs-getstarted/receive-eph-c.png

<!-- Links -->
[Azure classic portal]: https://manage.windowsazure.com/
[Event Processor Host]: https://www.nuget.org/packages/Microsoft.Azure.ServiceBus.EventProcessorHost
[Event Hubs overview]: event-hubs-overview.md
[sample application that uses Event Hubs]: https://code.msdn.microsoft.com/Service-Bus-Event-Hub-286fd097
[Scale out Event Processing with Event Hubs]: https://code.msdn.microsoft.com/Service-Bus-Event-Hub-45f43fc3
[queued messaging solution]: ../service-bus/service-bus-dotnet-multi-tier-app-using-service-bus-queues.md
