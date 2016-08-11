---
title: Enable offline sync for your Azure Mobile App (iOS)
description: Learn how to use App Service Mobile Apps to cache and sync offline data in your iOS application
documentationcenter: ios
author: krisragh
manager: dwrede
editor: ''
services: app-service\mobile

ms.service: app-service-mobile
ms.workload: mobile
ms.tgt_pltfrm: mobile-ios
ms.devlang: objective-c
ms.topic: article
ms.date: 08/01/2016
ms.author: krisragh

---
# Enable offline sync for your iOS mobile app
[!INCLUDE [app-service-mobile-selector-offline](../../includes/app-service-mobile-selector-offline.md)]

## Overview
This tutorial covers the offline sync feature of Azure Mobile Apps for iOS. Offline sync allows end-users to interact with a mobile app&mdash;viewing, adding, or modifying data&mdash;even when there is no network connection. Changes are stored in a local database; once the device is back online, these changes are synced with the remote backend.

If this is your first experience with Azure Mobile Apps, you should first complete the tutorial [Create an iOS App](app-service-mobile-ios-get-started.md). If you do not use the downloaded quick start server project, you must add the data access extension packages to your project. For more information about server extension packages, see [Work with the .NET backend server SDK for Azure Mobile Apps](app-service-mobile-dotnet-backend-how-to-use-server-sdk.md).

To learn more about the offline sync feature, see the topic [Offline Data Sync in Azure Mobile Apps](app-service-mobile-offline-data-sync.md).

## <a name="review-sync"></a>Review the client sync code
The client project that you downloaded for the tutorial [Create an iOS App](app-service-mobile-ios-get-started.md) already contains code supporting offline synchronization using a local Core Data-based database. This section is a summary of what is already included in the tutorial code. For a conceptual overview of the feature, see [Offline Data Sync in Azure Mobile Apps](app-service-mobile-offline-data-sync.md).

The offline data sync sync feature of Azure Mobile Apps allows end users to interact with a local database when the network is not accessible. To use these features in your app, you initialize the sync context of `MSClient` and reference a local store. Then reference your table through the `MSSyncTable` interface.

1. In **QSTodoService.m** (Objective-C) or **ToDoTableViewController.swift** (Swift), notice the type of the member `syncTable` is `MSSyncTable`. Offline sync uses this sync table interface instead of `MSTable`. When a sync table is used, all operations go to the local store and are only synchronized with the remote backend with explicit push and pull operations.
   
    To get a reference to a sync table, use the method `syncTableWithName` on `MSClient`. To remove offline sync functionality, use `tableWithName` instead.
2. Before any table operations can be performed, the local store must be initialized. Here is the relevant code. 
   
    **Objective-C**:
   
    In the `QSTodoService.init` method:

            MSCoreDataStore *store = [[MSCoreDataStore alloc] initWithManagedObjectContext:context];
            self.client.syncContext = [[MSSyncContext alloc] initWithDelegate:nil dataSource:store callback:nil];


    **Swift**:

    In the `ToDoTableViewController.viewDidLoad` method:


            let client = MSClient(applicationURLString: "http:// ...") // URI of the Mobile App
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
            self.store = MSCoreDataStore(managedObjectContext: managedObjectContext)
            client.syncContext = MSSyncContext(delegate: nil, dataSource: self.store, callback: nil)


    This creates a local store using the interface `MSCoreDataStore`, which is provided in the Mobile Apps SDK. You can instead a provide a different local store by implementing the `MSSyncContextDataSource` protocol. 

    Also, the first parameter of `MSSyncContext` is used to specify a conflict handler. Since we have passed `nil`, we will get the default conflict handler, which fails on any conflict.

1. Now, let's perform the actual sync operation, and get data from the remote backend.
   
    **Objective-C**:
   
    `syncData` first pushes new changes, then calls `pullData` to get data from the remote backend. In turn, the method `pullData` gets new data that matches a query:

            -(void)syncData:(QSCompletionBlock)completion
            {
                // push all changes in the sync context, then pull new data
                [self.client.syncContext pushWithCompletion:^(NSError *error) {
                    [self logErrorIfNotNil:error];
                    [self pullData:completion];
                }];
            }

            -(void)pullData:(QSCompletionBlock)completion
            {
                MSQuery *query = [self.syncTable query];

                // Pulls data from the remote server into the local table.
                // We're pulling all items and filtering in the view
                // query ID is used for incremental sync
                [self.syncTable pullWithQuery:query queryId:@"allTodoItems" completion:^(NSError *error) {
                    [self logErrorIfNotNil:error];

                    // Let the caller know that we have finished
                    if (completion != nil) {
                        dispatch_async(dispatch_get_main_queue(), completion);
                    }
                }];
            }


      **Swift**:


        func onRefresh(sender: UIRefreshControl!) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true

            self.table!.pullWithQuery(self.table?.query(), queryId: "AllRecords") {
                (error) -> Void in

                UIApplication.sharedApplication().networkActivityIndicatorVisible = false

                if error != nil {
                    // A real application would handle various errors like network conditions,
                    // server conflicts, etc via the MSSyncContextDelegate
                    print("Error: \(error!.description)")

                    // We will just discard our changes and keep the servers copy for simplicity
                    if let opErrors = error!.userInfo[MSErrorPushResultKey] as? Array<MSTableOperationError> {
                        for opError in opErrors {
                            print("Attempted operation to item \(opError.itemId)")
                            if (opError.operation == .Insert || opError.operation == .Delete) {
                                print("Insert/Delete, failed discarding changes")
                                opError.cancelOperationAndDiscardItemWithCompletion(nil)
                            } else {
                                print("Update failed, reverting to server's copy")
                                opError.cancelOperationAndUpdateItem(opError.serverItem!, completion: nil)
                            }
                        }
                    }
                }
                self.refreshControl?.endRefreshing()
            }
        } 


    In the Objective-C version, in `syncData`, we first call `pushWithCompletion` on the sync context. This method is a member of `MSSyncContext` (rather than the sync table itself)  because it will push changes across all tables. Only records that have been modified in some way locally (through CUD operations) will be sent to the server. Then the helper `pullData` is called, which calls `MSSyncTable.pullWithQuery` to retrieve remote data and store in the local database.

    In the Swift version, there is no call to `pushWithCompletion`. This is because the push operation was not strictly necessary. If there are any changes pending in the sync context for the table that is doing a push operation, pull always issues a push first. However, if you have more than one sync table, it is best explicitly call push to ensure that everything is consistent across related tables.

    In both the Objective-C and Swift versions, the method `pullWithQuery` allows you to specify a query to filter the records you wish to retrieve. In this example, the query just retrieves all records in the remote `TodoItem` table.

    The second parameter to `pullWithQuery` is a query ID that is used for *incremental sync*. Incremental sync retrieves only those records modified since the last sync, using the record's `UpdatedAt` timestamp (called `updatedAt` in the local store.) The query ID should be a descriptive string that is unique for each logical query in your app. To opt-out of incremental sync, pass `nil` as the query ID. Note that this can be potentially inefficient, since it will retrieve all records on each pull operation.

1. The Objective-C app syncs when we modify or add data, a user performs the refresh gesture, and on launch. The Swift app syncs when a user performs the refresh gesture and on launch. 

Because the app syncs whenever data is modified (Objective-C) or whenever the app starts (Objective-C & Swift), the app assumes that the user is online. In another section, we will update the app so that users can edit even when they are offline.

## <a name="review-core-data"></a>Review the Core Data model
When using the Core Data offline store, you need to define particular tables and fields in your data model. The sample app already includes a data model with the right format. In this section we will walk through these tables and how they are used.

* Open **QSDataModel.xcdatamodeld**. There are four tables defined--three that are used by the SDK, and one table for the todo items themselves:
      * MS_TableOperations: For tracking the items that need to be synchronized with the server
      * MS_TableOperationErrors: For tracking any errors that happen during offline synchronization
      * MS_TableConfig: For tracking the last updated time for the last sync operation for all pull operations
      * TodoItem: For storing the todo items. The system columns **createdAt**, **updatedAt**, and **version** are optional system properties.

> [!NOTE]
> The Azure Mobile Apps SDK reserves column names that being with "**``**". You should not use this prefix on anything other than system columns, otherwise your column names will be modified when using the remote backend.
> 
> 

* When using the offline sync feature, you must define the system tables as shown below.
  
  ### System Tables
    **MS_TableOperations**
  
    ![](./media/app-service-mobile-ios-get-started-offline-data/defining-core-data-tableoperations-entity.png)
  
  | Attribute | Type |
  | --- | --- |
  | id |Integer 64 |
  | itemId |String |
  | properties |Binary Data |
  | table |String |
  | tableKind |Integer 16 |
  
    <br>**MS_TableOperationErrors**
  
    ![](./media/app-service-mobile-ios-get-started-offline-data/defining-core-data-tableoperationerrors-entity.png)
  
  | Attribute | Type |
  | --- | --- |
  | id |String |
  | operationId |Integer 64 |
  | properties |Binary Data |
  | tableKind |Integer 16 |
  
    <br>**MS_TableConfig**
  
    ![](./media/app-service-mobile-ios-get-started-offline-data/defining-core-data-tableconfig-entity.png)
  
  | Attribute | Type |
  | --- | --- |
  | id |String |
  | key |String |
  | keyType |Integer 64 |
  | table |String |
  | value |String |
  
  ### Data table
    **TodoItem**
  
  | Attribute | Type | Note |
  | --- | --- | --- |
  | id |String, marked required |primary key in remote store |
  | complete |Boolean |todo item field |
  | text |String |todo item field |
  | createdAt |Date |(optional) maps to createdAt system property |
  | updatedAt |Date |(optional) maps to updatedAt system property |
  | version |String |(optional) used to detect conflicts, maps to version |

## <a name="setup-sync"></a>Change the sync behavior of the app
In this section, you will modify the app so that it does not sync on app start, or when inserting and updating items, but only when the refresh gesture button is performed.

**Objective-C**:

1. In **QSTodoListViewController.m**, change the **viewDidLoad** method to remove the call to `[self refresh]` at the end of the method. Now, the data will not be synced with the server on app start, but instead will be the contents of local store.
2. In **QSTodoService.m**, modify the definition of `addItem` so that it doesn't sync after the item is inserted. Remove the `self syncData` block and replace with the following:
   
            if (completion != nil) {
                dispatch_async(dispatch_get_main_queue(), completion);
            }
3. Modify the definition of `completeItem` as above; remove the block for `self syncData` and replace with the following:
   
            if (completion != nil) {
                dispatch_async(dispatch_get_main_queue(), completion);
            }

**Swift**:

1. In `viewDidLoad` in **ToDoTableViewController.swift**, comment out these two lines, to stop syncing on app start. At the time of this article's writing, the Swift Todo app does not update the service when someone adds or completes an item, only on app start.
   
        self.refreshControl?.beginRefreshing()
        self.onRefresh(self.refreshControl)

## <a name="test-app"></a>Test the app
In this section, you will connect to an invalid URL to simulate an offline scenario. When you add data items, they will be held in the local Core Data store, but not synced to the mobile backend.

1. Change the Mobile App URL in **QSTodoService.m** to an invalid URL, and run the app again:
   
    **Objective-C** in QSTodoService.m:
   
            self.client = [MSClient clientWithApplicationURLString:@"https://sitename.azurewebsites.net.fail"];
   
    **Swift** in ToDoTableViewController.swift:
   
        let client = MSClient(applicationURLString: "https://sitename.azurewebsites.net.fail")
2. Add some todo items. Quit the simulator (or forcibly close the app) and restart. Verify that your changes have been persisted.
3. View the contents of the remote TodoItem table:
   
   * For a Node.js backend, go to the [Azure portal](https://portal.azure.com/), and in your Mobile App backend click **Easy Tables** > **TodoItem** to view the contents of the `TodoItem` table.
     
     * For a .NET backend, view the table contents either with a SQL tool such as SQL Server Management Studio, or a REST client such as Fiddler or Postman.
     
     Verify that the new items have *not* been synced to the server:
4. Change the URL back to the correct on in **QSTodoService.m** and rerun the app. Perform the refresh gesture by pulling down the list of items. You will see a progress spinner.
5. View the TodoItem data again. The new and changed TodoItems should now appear.

## Summary
In order to support the offline sync feature, we used the `MSSyncTable` interface and initialized `MSClient.syncContext` with a local store. In this case the local store was a Core Data-based database.

When using a Core Data local store, you must define several tables with the [correct system properties](#review-core-data).

The normal CRUD operations for Azure Mobile Apps work as if the app is still connected but all the operations occur against the local store.

When we wanted to synchronize the local store with the server, we used the `MSSyncTable.pullWithQuery`method.

## Additional Resources
* [Offline Data Sync in Azure Mobile Apps](app-service-mobile-offline-data-sync.md)
* [Cloud Cover: Offline Sync in Azure Mobile Services](http://channel9.msdn.com/Shows/Cloud+Cover/Episode-155-Offline-Storage-with-Donna-Malayeri) \(note: the video is on Mobile Services, but offline sync works in a similar way in Azure Mobile Apps\)

<!-- URLs. -->


[Create an iOS App]: ../app-service-mobile-ios-get-started.md
[Offline Data Sync in Azure Mobile Apps]: ../app-service-mobile-offline-data-sync.md

[defining-core-data-tableoperationerrors-entity]: ./media/app-service-mobile-ios-get-started-offline-data/defining-core-data-tableoperationerrors-entity.png
[defining-core-data-tableoperations-entity]: ./media/app-service-mobile-ios-get-started-offline-data/defining-core-data-tableoperations-entity.png
[defining-core-data-tableconfig-entity]: ./media/app-service-mobile-ios-get-started-offline-data/defining-core-data-tableconfig-entity.png
[defining-core-data-todoitem-entity]: ./media/app-service-mobile-ios-get-started-offline-data/defining-core-data-todoitem-entity.png

[Cloud Cover: Offline Sync in Azure Mobile Services]: http://channel9.msdn.com/Shows/Cloud+Cover/Episode-155-Offline-Storage-with-Donna-Malayeri
[Azure Friday: Offline-enabled apps in Azure Mobile Services]: http://azure.microsoft.com/en-us/documentation/videos/azure-mobile-services-offline-enabled-apps-with-donna-malayeri/
