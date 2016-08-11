---
title: Monitor usage and statistics in an Azure Search service | Microsoft Azure | Hosted cloud search service
description: Track resource consumption and index size for Azure Search, a hosted cloud search service on Microsoft Azure.
services: search
documentationcenter: ''
author: HeidiSteen
manager: paulettm
editor: ''
tags: azure-portal

ms.service: search
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: required
ms.date: 05/17/2016
ms.author: heidist

---
# Monitor usage and statistics in an Azure Search service
Tracking the growth of indexes and document size can help you proactively adjust capacity before hitting the upper limit you've established for your service. 

To monitor resource usage, counts and statistics for your service are easily viewed in the [Azure Portal](https://portal.azure.com), but you can also obtain the information programmatically if you are building a custom service administration tool. This article covers the steps for both techniques.

You can also use the new search traffic analytics feature for insights into activity at the index level. Visit [Search Traffic Analytics for Azure Search](search-traffic-analytics.md) to get started.

## View counts and metrics in the portal
1. Sign in to the [Azure Portal](https://portal.azure.com). 
2. Open the service dashboard of your Azure Search service. Tiles for the service can be found on the Home page, or you can browse to the service from Browse on the JumpBar. See [Create a service](search-create-service-portal.md) for step-by-step instructions.

The Usage section includes a meter that tells you what portion of available resources are currently in use.

  ![](./media/search-monitor-usage/AzureSearch-Monitor1.PNG)

Recall that the shared service has a maximum of one replica and partition each. Additionally, it can only support 10,000 documents in total or 50 MB of data, whichever comes first.

## Get index statistics using the REST API
Both the Azure Search REST API and the .NET SDK provide programmatic access to service metrics.  If you are using [indexers](https://msdn.microsoft.com/library/azure/dn946891.aspx) to load an index from Azure SQL Database or DocumentDB, an additional API is available to get the numbers you require. 

* [Get Index Statistics](https://msdn.microsoft.com/library/azure/dn798942.aspx)
* [Count Documents](https://msdn.microsoft.com/library/azure/dn798924.aspx)
* [Get Indexer Status](https://msdn.microsoft.com/library/azure/dn946884.aspx)

## Next steps
Review [Limits and capacity](search-limits-quotas-capacity.md) to determine the combination of partitions and replicas you'll need if existing capacity is insufficient. 

Visit [Manage your Search service on Microsoft Azure](search-manage.md) for more information on service administration.

<!--Image references-->
[1]: ./media/search-monitor-usage/AzureSearch-Monitor1.PNG




