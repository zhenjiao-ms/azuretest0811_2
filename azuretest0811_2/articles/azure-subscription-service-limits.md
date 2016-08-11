---
title: Microsoft Azure Subscription and Service Limits, Quotas, and Constraints
description: Provides a list of common Azure subscription and service limits, quotas, and constraints. This includes information on how to increase limits along with maximum values.
services: ''
documentationcenter: ''
author: rothja
manager: jeffreyg
editor: ''
tags: billing

ms.service: multiple
ms.workload: multiple
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 08/03/2016
ms.author: btardif

---
# Azure subscription and service limits, quotas, and constraints
## Overview
This document specifies some of the most common Microsoft Azure limits. Note that this does not currently cover all Azure services. Over time, these limits will be expanded and updated to cover more of the platform.

> [!NOTE]
> If you want to raise the limit above the **Default Limit**, you can [open an online customer support request at no charge](https://azure.microsoft.com/blog/2014/06/04/azure-limits-quotas-increase-requests/). The limits cannot be raised above the **Maximum Limit** value in the tables below. If there is no **Maximum Limit** column, then the specified resource does not have adjustable limits.
> 
> 

## Limits and the Azure Resource Manager
It is now possible to combine multiple Azure resources in to a single Azure Resource Group. When using Resource Groups, limits that once were global become managed at a regional level with the Azure Resource Manager. For more information about Azure Resource Groups, see [Azure Resource Manager overview](resource-group-overview.md).

In the limits below, a new table has been added to reflect any differences in limits when using the Azure Resource Manager. For example, there is a **Subscription Limits** table and a **Subscription Limits - Azure Resource Manager** table. When a limit applies to both scenarios, it is only shown in the first table. Unless otherwise indicated, limits are global across all regions.

> [!NOTE]
> It is important to emphasize that quotas for resources in Azure Resource Groups are per-region accessible by your subscription, and are not per-subscription, as the service management quotas are. Let's use core quotas as an example. If you need to request a quota increase with support for cores, you need to decide how many cores you want to use in which regions, and then make a specific request for Azure Resource Group core quotas for the amounts and regions that you want. Therefore, if you need to use 30 cores in West Europe to run your application there; you should specifically request 30 cores in West Europe. But you will not have a core quota increase in any other region -- only West Europe will have the 30-core quota.
> <!-- -->
> As a result, you may find it useful to consider deciding what your Azure Resource Group quotas need to be for your workload in any one region, and request that amount in each region into which you are considering deployment. See [troubleshooting deployment issues](resource-manager-common-deployment-errors.md) for more help discovering your current quotas for specific regions.
> 
> 

## Service-specific limits
* [Active Directory](#active-directory-limits)
* [API Management](#api-management-limits)
* [App Service](#app-service-limits)
* [Application Insights](#application-insights-limits)
* [Automation](#automation-limits)
* [Azure Redis Cache](#azure-redis-cache-limits)
* [Azure RemoteApp](#azure-remoteapp-limits)
* [Backup](#backup-limits)
* [Batch](#batch-limits)
* [BizTalk Services](#biztalk-services-limits)
* [CDN](#cdn-limits)
* [Cloud Services](#cloud-services-limits)
* [Data Factory](#data-factory-limits)
* [Data Lake Analytics](#data-lake-analytics-limits)
* [DNS](#dns-limits)
* [DocumentDB](#documentdb-limits)
* [Event Hubs](#event-hubs-limits)
* [IoT Hub](#iot-hub-limits)
* [Key Vault](#key-vault-limits)
* [Media Services](#media-services-limits)
* [Mobile Engagement](#mobile-engagement-limits)
* [Mobile Services](#mobile-services-limits)
* [Multi-Factor Authentication](#multi-factor-authentication)
* [Networking](#networking-limits)
* [Notification Hub Service](#notification-hub-service-limits)
* [Operational Insights](#operational-insights-limits)
* [Resource Group](#resource-group-limits)
* [Scheduler](#scheduler-limits)
* [Search](#search-limits)
* [Service Bus](#service-bus-limits)
* [Site Recovery](#site-recovery-limits)
* [SQL Database](#sql-database-limits)
* [Storage](#storage-limits)
* [StorSimple System](#storsimple-system-limits)
* [Stream Analytics](#stream-analytics-limits)
* [Subscription](#subscription-limits)
* [Traffic Manager](#traffic-manager-limits)
* [Virtual Machines](#virtual-machines-limits)
* [Virtual Machine Scale Sets](#virtual-machine-scale-sets-limits)

### Subscription limits
#### Subscription limits
[!INCLUDE [azure-subscription-limits](../includes/azure-subscription-limits.md)]

#### Subscription limits - Azure Resource Manager
The following limits apply when using the Azure Resource Manager and Azure Resource Groups. Limits that have not changed with the Azure Resource Manager are not listed below. Please refer to the previous table for those limits.

[!INCLUDE [azure-subscription-limits-azure-resource-manager](../includes/azure-subscription-limits-azure-resource-manager.md)]

### Resource Group limits
[!INCLUDE [azure-resource-groups-limits](../includes/azure-resource-groups-limits.md)]

### Virtual Machines limits
#### Virtual Machine limits
[!INCLUDE [azure-virtual-machines-limits](../includes/azure-virtual-machines-limits.md)]

#### Virtual Machines limits - Azure Resource Manager
The following limits apply when using the Azure Resource Manager and Azure Resource Groups. Limits that have not changed with the Azure Resource Manager are not listed below. Please refer to the previous table for those limits.

[!INCLUDE [azure-virtual-machines-limits-azure-resource-manager](../includes/azure-virtual-machines-limits-azure-resource-manager.md)]

### Virtual Machine Scale Sets limits
[!INCLUDE [virtual-machine-scale-sets-limits](../includes/azure-virtual-machine-scale-sets-limits.md)]

### Networking limits
[!INCLUDE [expressroute-limits](../includes/expressroute-limits.md)]

#### Networking limits
[!INCLUDE [azure-virtual-network-limits](../includes/azure-virtual-network-limits.md)]

#### Traffic Manager limits
[!INCLUDE [traffic-manager-limits](../includes/traffic-manager-limits.md)]

#### DNS limits
[!INCLUDE [dns-limits](../includes/dns-limits.md)]

### Storage limits
For additional details on storage account limits, see [Azure Storage Scalability and Performance Targets](storage/storage-scalability-targets.md).

#### Storage Service limits
[!INCLUDE [azure-storage-limits](../includes/azure-storage-limits.md)]

#### Virtual Machine disk limits
[!INCLUDE [azure-storage-limits-vm-disks](../includes/azure-storage-limits-vm-disks.md)]

See [Virtual machine sizes](virtual-machines/virtual-machines-linux-sizes.md) for additional details.

**Standard storage accounts**

[!INCLUDE [azure-storage-limits-vm-disks-standard](../includes/azure-storage-limits-vm-disks-standard.md)]

**Premium storage accounts**

[!INCLUDE [azure-storage-limits-vm-disks-premium](../includes/azure-storage-limits-vm-disks-premium.md)]

#### Storage Resource Provider limits
[!INCLUDE [azure-storage-limits-azure-resource-manager](../includes/azure-storage-limits-azure-resource-manager.md)]

### Cloud Services limits
[!INCLUDE [azure-cloud-services-limits](../includes/azure-cloud-services-limits.md)]

### App Service limits
The following App Service limits include limits for Web Apps, Mobile Apps, API Apps, and Logic Apps.

[!INCLUDE [azure-websites-limits](../includes/azure-websites-limits.md)]

### Scheduler limits
[!INCLUDE [scheduler-limits-table](../includes/scheduler-limits-table.md)]

### Batch limits
[!INCLUDE [azure-batch-limits](../includes/azure-batch-limits.md)]

### BizTalk Services limits
The following table shows the limits for Azure Biztalk Services.

[!INCLUDE [biztalk-services-service-limits](../includes/biztalk-services-service-limits.md)]

### DocumentDB limits
[!INCLUDE [azure-documentdb-limits](../includes/azure-documentdb-limits.md)]

Quotas listed with an asterisk (*) [can be adjusted by contacting Azure support](documentdb/documentdb-increase-limits.md).

### Mobile Engagement limits
[!INCLUDE [azure-mobile-engagement-limits](../includes/azure-mobile-engagement-limits.md)]

### Search limits
Pricing tiers determine the capacity and limits of your search service. Tiers include:

* *Free* multi-tenant service, shared with other Azure subscribers, intended for evaluation and small development projects.
* *Basic* provides dedicated computing resources for production workloads at a smaller scale, with up to 3 replicas for highly available query workloads.
* *Standard (S1, S2, S3, S3 High Density)* is for larger production workloads. Multiple levels  exist within the standard tier so that you can choose a resource configuration for specific scenarios.

**Limits per subscription**

[!INCLUDE [azure-search-limits-per-subscription](../includes/azure-search-limits-per-subscription.md)]

**Limits per search service**

[!INCLUDE [azure-search-limits-per-service](../includes/azure-search-limits-per-service.md)]

For more granular information about other limits, including document size, queries per second, keys, requests, and responses, see [Service limits in Azure Search](search/search-limits-quotas-capacity.md).

### Media Services limits
[!INCLUDE [azure-mediaservices-limits](../includes/azure-mediaservices-limits.md)]

### CDN limits
[!INCLUDE [cdn-limits](../includes/cdn-limits.md)]

### Mobile Services limits
[!INCLUDE [mobile-services-limits](../includes/mobile-services-limits.md)]

### Notification Hub Service limits
[!INCLUDE [notification-hub-limits](../includes/notification-hub-limits.md)]

### Event Hubs limits
[!INCLUDE [azure-servicebus-limits](../includes/event-hubs-limits.md)]

### Service Bus limits
[!INCLUDE [azure-servicebus-limits](../includes/service-bus-quotas-table.md)]

### IoT Hub limits
[!INCLUDE [azure-iothub-limits](../includes/iot-hub-limits.md)]

### Data Factory limits
[!INCLUDE [azure-data-factory-limits](../includes/azure-data-factory-limits.md)]

### Data Lake Analytics Limits
[!INCLUDE [azure-data-lake-analytics-limits](../includes/azure-data-lake-analytics-limits.md)]

### Stream Analytics limits
[!INCLUDE [stream-analytics-limits-table](../includes/stream-analytics-limits-table.md)]

### Active Directory limits
[!INCLUDE [AAD-service-limits](../includes/active-directory-service-limits-include.md)]

### Azure RemoteApp limits
[!INCLUDE [azure-remoteapp-limits](../includes/azure-remoteapp-limits.md)]

### StorSimple System limits
[!INCLUDE [storsimple-limits-table](../includes/storsimple-limits-table.md)]

### Operational Insights limits
[!INCLUDE [operational-insights-limits](../includes/operational-insights-limits.md)]

### Backup limits
[!INCLUDE [azure-backup-limits](../includes/azure-backup-limits.md)]

### Site Recovery limits
[!INCLUDE [site-recovery-limits](../includes/site-recovery-limits.md)]

### Application Insights limits
[!INCLUDE [application-insights-limits](../includes/application-insights-limits.md)]

### API Management limits
[!INCLUDE [api-management-service-limits](../includes/api-management-service-limits.md)]

### Azure Redis Cache limits
[!INCLUDE [redis-cache-service-limits](../includes/redis-cache-service-limits.md)]

### Key Vault limits
[!INCLUDE [key-vault-limits](../includes/key-vault-limits.md)]

### Multi-Factor Authentication
[!INCLUDE [azure-mfa-service-limits](../includes/azure-mfa-service-limits.md)]

### Automation limits
[!INCLUDE [automation-limits](../includes/azure-automation-service-limits.md)]

### SQL Database limits
For SQL Database limits, see [SQL Database Resource Limits](sql-database/sql-database-resource-limits.md).

## See also
[Understanding Azure Limits and Increases](https://azure.microsoft.com/blog/2014/06/04/azure-limits-quotas-increase-requests/)

[Virtual Machine and Cloud Service Sizes for Azure](virtual-machines/virtual-machines-linux-sizes.md)

[Sizes for Cloud Services](cloud-services/cloud-services-sizes-specs.md)

