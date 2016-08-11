The following table lists quotas and limits specific to Azure Event Hubs. For more information about Event Hubs, see [Event Hubs Pricing](https://azure.microsoft.com/pricing/details/event-hubs/). For information about pricing and other quotas for Service Bus, see the [Service Bus Pricing](https://azure.microsoft.com/pricing/details/service-bus/) overview.

| Limit | Scope | Type | Behavior when exceeded | Value |
| --- | --- | --- | --- | --- |
| Number of Event Hubs per namespace |Namespace |Static |Subsequent requests for creation of a new namespace will be rejected. |10 |
| Number of partitions per Event Hub |Entity |Static |- |32 |
| Number of consumer groups per Event Hub |Entity |Static |- |20 |
| Number of AMQP connections per namespace |Namespace |Static |Subsequent requests for additional connections will be rejected and an exception will be received by the calling code. |5,000 |
| Maximum event size |System-wide |Static |- |256KB |
| Number of non-epoch receivers per consumer group |Entity |Static |- |5 |
| Maximum retention period of event data |Entity |Static |- |1-7 days |
| Maximum throughput units |Namespace |Static |Exceeding the throughput unit limit will cause your data to be throttled and generate a **ServerBusyException**. You can request a larger number of throughput units for a Standard tier by filing a support ticket. Additional throughput units are available in blocks of twenty on a committed purchase basis. |20 |

