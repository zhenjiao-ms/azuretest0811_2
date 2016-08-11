---
title: Import and Export data in Azure Redis Cache | Microsoft Azure
description: Learn how to import and export data to and from blob storage with your premium Azure Redis Cache instances
services: redis-cache
documentationcenter: ''
author: steved0x
manager: douge
editor: ''

ms.service: cache
ms.workload: tbd
ms.tgt_pltfrm: cache-redis
ms.devlang: na
ms.topic: article
ms.date: 07/13/2016
ms.author: sdanie

---
# Import and Export data in Azure Redis Cache
Import/Export is an Azure Redis Cache data management operation which allows you to import data into Azure Redis Cache or export data from Azure Redis Cache by importing and exporting a Redis Cache Database (RDB) snapshot from a premium cache to a page blob in an Azure Storage Account. This enables you to migrate between different Azure Redis Cache instances or populate the cache with data before use.

This article provides a guide for importing and exporting data with Azure Redis Cache and provides the answers to commonly asked questions.

> [!IMPORTANT]
> Import/Export is in preview and is only available for [premium tier](cache-premium-tier-intro.md) caches.
> 
> 

## Import
Import can be used to bring Redis compatible RDB file(s) from any Redis server running in any cloud or environment, including Redis running on Linux, Windows, or any cloud provider such as Amazon Web Services and others. Importing data is an easy way to create a cache with pre-populated data. During the import process Azure Redis Cache loads the RDB files from Azure storage into memory and then inserts the keys into the cache.

> [!NOTE]
> Before beginning the import operation, ensure that your Redis Database (RDB) file or files are uploaded into page blobs in Azure storage, in the same region and subscription as your Azure Redis Cache instance. For more information, see [Get started with Azure Blob storage](../storage/storage-dotnet-how-to-use-blobs.md). If you exported your RDB file using the [Azure Redis Cache Export](#export) feature your RDB file is already stored in a page blob and is ready for importing.
> 
> 

1. To import one or more exported cache blobs, [browse to your cache](cache-configure.md#configure-redis-cache-settings) in the Azure portal and click **Import data** from the **Settings** blade of your cache instance.
   
    ![Import data](./media/cache-how-to-import-export-data/cache-import-data.png)
2. Click **Choose Blob(s)** and select the storage account that contains the data to import.
   
    ![Choose storage account](./media/cache-how-to-import-export-data/cache-import-choose-storage-account.png)
3. Click the container that contains the data to import.
   
    ![Choose container](./media/cache-how-to-import-export-data/cache-import-choose-container.png)
4. Select one or more blobs to import by clicking the area to the left of the blob name, and then click **Select**.
   
    ![Choose blobs](./media/cache-how-to-import-export-data/cache-import-choose-blobs.png)
5. Click **Import** to begin the import process.
   
   > [!IMPORTANT]
   > The cache is not accessible by cache clients during the import process, and any existing data in the cache is deleted.
   > 
   > 
   
    ![Import](./media/cache-how-to-import-export-data/cache-import-blobs.png)
   
    You can monitor the progress of the import operation by following the notifications from the Azure Portal or by viewing the events in the [audit log](cache-configure.md#support-amp-troubleshooting-settings).
   
    ![Import progress](./media/cache-how-to-import-export-data/cache-import-data-import-complete.png) 

## Export
Export allows you to export the data stored in Azure Redis Cache to Redis compatible RDB file(s). You can use this feature to move data from one Azure Redis Cache instance to another or to another Redis server. During the export process a temporary file is created on the VM that hosts the Azure Redis Cache server instance, and the file is uploaded to the designated storage account. When the export operation completes with either a status of success or failure, the temporary file is deleted.

1. To export the current contents of the cache to storage, [browse to your cache](cache-configure.md#configure-redis-cache-settings) in the Azure portal and click **Export data** from the **Settings** blade of your cache instance.
   
    ![Choose storage container](./media/cache-how-to-import-export-data/cache-export-data-choose-storage-container.png)
2. Click **Choose Storage Container** and select the desired storage account. The storage account must be in the same subscription and region as your cache.
   
   > [!IMPORTANT]
   > Import/Export works with page blobs, which are supported by both classic and ARM storage accounts, but are not supported by [Blob storage accounts](../storage/storage-blob-storage-tiers.md#blob-storage-accounts) at this time.
   > 
   > 
   
    ![Storage account](./media/cache-how-to-import-export-data/cache-export-data-choose-account.png)
3. Choose the desired blob container and click **Select**. To use new a container, click **Add Container** to add it first and then select it from the list.
   
    ![Choose storage container](./media/cache-how-to-import-export-data/cache-export-data-container.png)
4. Type a **Blob name prefix** and click **Export** to start the export process. The blob name prefix is used to prefix the names of files generated by this export operation.
   
    ![Export](./media/cache-how-to-import-export-data/cache-export-data.png)
   
    You can monitor the progress of the export operation by following the notifications from the Azure Portal or by viewing the events in the [audit log](cache-configure.md#support-amp-troubleshooting-settings).
   
    ![](./media/cache-how-to-import-export-data/cache-export-data-export-complete.png)
   
    Note that caches remain available for use during the export process.

## Import/Export FAQ
This section contains frequently asked questions about the Import/Export feature.

* [What pricing tiers can use Import/Export?](#what-pricing-tiers-can-use-importexport)
* [Can I import data from any Redis server?](#can-i-import-data-from-any-redis-server)
* [Will my cache be available during an Import/Export operation?](#will-my-cache-be-available-during-an-importexport-operation)
* [Can I use Import/Export with Redis cluster?](#can-i-use-importexport-with-redis-cluster)
* [How does Import/Export work with a custom databases setting?](#how-does-importexport-work-with-a-custom-databases-setting)
* [How is Import/Export different from Redis persistence?](#how-is-importexport-different-from-redis-persistence)
* [Can I automate Import/Export using PowerShell, CLI, or other management clients?](#can-i-automate-importexport-using-powershell-cli-or-other-management-clients)
* [I received a timeout error during my Import/Export operation. What does it mean?](#i-received-a-timeout-error-during-my-importexport-operation.-what-does-it-mean)
* [I got an error when exporting my data to Azure Blob Storage. What happened?](#i-got-an-error-when-exporting-my-data-to-azure-blob-storage.-what-happened)

### What pricing tiers can use Import/Export?
Import/Export is available only in the premium pricing tier.

### Can I import data from any Redis server?
Yes, in addition to importing data exported from Azure Redis Cache instances, you can import RDB files from any Redis server running in any cloud or environment, such as Linux, Windows, or cloud providers such as Amazon Web Services. To do this, upload the RDB file from the desired Redis server into a page blob in an Azure Storage Account, and then import it into your premium Azure Redis Cache instance. For example you may want to export the data from your production cache and import it into a cache used as part of a staging environment for testing or migration. 

### Will my cache be available during an Import/Export operation?
* **Export** - Caches remain available and you can continue to use your cache during an export operation.
* **Import** - Caches become unavailable when an import operation starts, and become available for use when the import operation completes.

### Can I use Import/Export with Redis cluster?
Yes, and you can import/export between a clustered cache and a non-clustered cache. Since Redis cluster [only supports database 0](cache-how-to-premium-clustering.md#do-i-need-to-make-any-changes-to-my-client-application-to-use-clustering), any data in databases other than 0 won't be imported. When clustered cache data is imported, the keys are redistributed among the shards of the cluster. 

### How does Import/Export work with a custom databases setting?
Some pricing tiers have different [databases limits](cache-configure.md#databases), so there are some considerations when importing if you configured a custom value for the `databases` setting during cache creation.

* When importing to a pricing tier with a lower `databases` limit than the tier from which you exported:
  * If you are using the default number of `databases` which is 16 for all pricing tiers, no data is lost.
  * If you are using a custom number of `databases` that falls within the limits for the tier to which you are importing, no data is lost.
  * If your exported data contained data in a database that exceeds the limits of the new tier, the data from those higher databases is not imported.

### How is Import/Export different from Redis persistence?
Azure Redis Cache persistence allows you to persist data stored in Redis to Azure Storage. When persistence is configured, Azure Redis Cache persists a snapshot of the Redis cache in a Redis binary format to disk based on a configurable backup frequency. If a catastrophic event occurs that disables both the primary and replica cache, the cache data is restored automatically using the most recent snapshot. For more information, see [How to configure data persistence for a Premium Azure Redis Cache](cache-how-to-premium-persistence.md).

Import/ Export allows you to bring data into or export from Azure Redis Cache. It does not configure backup and restore using Redis persistence.

### Can I automate Import/Export using PowerShell, CLI, or other management clients?
Yes, for PowerShell instructions see [To import a Redis cache](cache-howto-manage-redis-cache-powershell.md#to-import-a-redis-cache) and [To export a Redis cache](cache-howto-manage-redis-cache-powershell.md#to-export-a-redis-cache).

### I received a timeout error during my Import/Export operation. What does it mean?
If you remain on the **Import data** or **Export data** blade for longer than 15 minutes before initiating the operation, you will receive an error similar to the following.

    The request to import data into cache 'contoso55' failed with status 'error' and error 'One of the SAS URIs provided could not be used for the following reason: The SAS token end time (se) must be at least 1 hour from now and the start time (st), if given, must be at least 15 minutes in the past.

To resolve this, initiate the import or export operation before 15 minutes has elapsed.

### I got an error when exporting my data to Azure Blob Storage. What happened?
Import/Export works only with RDB files stored as page blobs. Other blob types are not supported at this time, including blob storage accounts with hot and cool tiers.

<!-- IMAGES -->
[cache-settings-import-export-menu]: ./media/cache-how-to-import-export-data/cache-settings-import-export-menu.png
[cache-export-data-choose-account]: ./media/cache-how-to-import-export-data/cache-export-data-choose-account.png
[cache-export-data-choose-storage-container]: ./media/cache-how-to-import-export-data/cache-export-data-choose-storage-container.png
[cache-export-data-container]: ./media/cache-how-to-import-export-data/cache-export-data-container.png
[cache-export-data-export-complete]: ./media/cache-how-to-import-export-data/cache-export-data-export-complete.png
[cache-export-data]: ./media/cache-how-to-import-export-data/cache-export-data.png
[cache-import-data]: ./media/cache-how-to-import-export-data/cache-import-data.png
[cache-import-choose-storage-account]: ./media/cache-how-to-import-export-data/cache-import-choose-storage-account.png
[cache-import-choose-container]: ./media/cache-how-to-import-export-data/cache-import-choose-container.png
[cache-import-choose-blobs]: ./media/cache-how-to-import-export-data/cache-import-choose-blobs.png
[cache-import-blobs]: ./media/cache-how-to-import-export-data/cache-import-blobs.png
[cache-import-data-import-complete]: ./media/cache-how-to-import-export-data/cache-import-data-import-complete.png








