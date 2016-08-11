---
title: Azure Networking Analytics solution in Log Analytics | Microsoft Azure
description: You can use the Azure Networking Analytics solution in Log Analytics to review Azure network security group logs and Azure Application Gateway logs.
services: log-analytics
documentationcenter: ''
author: richrundmsft
manager: jochan
editor: ''

ms.service: log-analytics
ms.workload: na
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 07/05/2016
ms.author: richrund

---
# Azure Networking Analytics (Preview) solution in Log Analytics
> [!NOTE]
> This is a [preview solution](log-analytics-add-solutions.md#log-analytics-preview-solutions-and-features).
> 
> 

You can use the Azure Networking Analytics solution in Log Analytics to review Azure Application Gateway logs and Azure network security group logs.

You can enable logging for Azure Application Gateway logs and Azure network security groups. These logs are written to Blob storage where they can then be indexed by Log Analytics for searching and analysis.

The following logs are supported for Application Gateways:

* ApplicationGatewayAccessLog
* ApplicationGatewayPerformanceLog

The following logs are supported for network security groups:

* NetworkSecurityGroupEvent
* NetworkSecurityGroupRuleCounter

## Install and configure the solution
Use the following instructions to install and configure the Azure Networking Analytics solution:

1. Enable diagnostics logging for the resources you want to monitor:
   * [Application Gateway](../application-gateway/application-gateway-diagnostics.md)
   * [Network security group](../virtual-network/virtual-network-nsg-manage-log.md)
2. Configure Log Analytics to read the logs from Blob storage by using the process described in [JSON files in blob storage](log-analytics-azure-storage-json.md).
3. Enable the Azure Networking Analytics solution by using the process described in [Add Log Analytics solutions from the Solutions Gallery](log-analytics-add-solutions.md).  

If you do not enable diagnostic logging for a particular resource type, the dashboard blades for that resource will be blank.

## Review Azure Networking Analytics data collection details
The Azure Networking Analytics solution collects diagnostics logs from Azure Blob storage for Azure Application Gateways and network security groups.
No agent is required for data collection.

The following table shows data collection methods and other details about how data is collected for Azure Networking Analytics.

| Platform | Direct agent | Systems Center Operations Manager (SCOM) agent | Azure Storage | SCOM required? | SCOM agent data sent via management group | Collection frequency |
| --- | --- | --- | --- | --- | --- | --- |
| Azure |![No](./media/log-analytics-azure-networking/oms-bullet-red.png) |![No](./media/log-analytics-azure-networking/oms-bullet-red.png) |![Yes](./media/log-analytics-azure-networking/oms-bullet-green.png) |![No](./media/log-analytics-azure-networking/oms-bullet-red.png) |![No](./media/log-analytics-azure-networking/oms-bullet-red.png) |10 minutes |

## Use Azure Networking Analytics
After you install the solution, you can view the summary of client and server errors for your monitored Application Gateways by using the **Azure Networking Analytics** tile on the **Overview** page in Log Analytics.

![image of Azure Networking Analytics tile](./media/log-analytics-azure-networking/log-analytics-azurenetworking-tile.png)

After you click the **Overview** tile, you can view summaries of your logs and then drill in to details for the following categories:

* Application Gateway Access logs
  * Client and server errors for Application Gateway access logs
  * Requests per hour for each Application Gateway
  * Failed requests per hour for each Application Gateway
  * Errors by user agent for Application Gateways
* Application Gateway performance
  * Host health for Application Gateway
  * Maximum and 95th percentile for Application Gateway failed requests
* Network security group blocked flows
  * Network security group rules with blocked flows
  * MAC addresses with blocked flows
* Network security group allowed flows
  * Network security group rules with allowed flows
  * MAC addresses with allowed flows

![image of Azure Networking Analytics dashboard](./media/log-analytics-azure-networking/log-analytics-azurenetworking01.png)

![image of Azure Networking Analytics dashboard](./media/log-analytics-azure-networking/log-analytics-azurenetworking02.png)

![image of Azure Networking Analytics dashboard](./media/log-analytics-azure-networking/log-analytics-azurenetworking03.png)

![image of Azure Networking Analytics dashboard](./media/log-analytics-azure-networking/log-analytics-azurenetworking04.png)

### To view details for any log summary
1. On the **Overview** page, click the **Azure Networking Analytics** tile.
2. On the **Azure Networking Analytics** dashboard, review the summary information in one of the blades, and then click one to view detailed information about it in the log search page.
   
    On any of the log search pages, you can view results by time, detailed results, and your log search history. You can also filter by facets to narrow the results.

## Next steps
* Use [Log searches in Log Analytics](log-analytics-log-searches.md) to view detailed Azure Networking Analytics data.

