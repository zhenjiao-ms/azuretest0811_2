---
title: Add the OneDrive connector in your Logic Apps | Microsoft Azure
description: Overview of the OneDrive connector with REST API parameters
services: logic-apps
documentationcenter: ''
author: MandiOhlinger
manager: erikre
editor: ''
tags: connectors

ms.service: logic-apps
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: integration
ms.date: 07/26/2016
ms.author: mandia

---
# Get started with the OneDrive connector
Connect to OneDrive to manage your files, including upload, get, delete files, and more. 

With OneDrive, you: 

* Build your workflow by storing files in OneDrive, or update existing files in OneDrive. 
* Use triggers to start your workflow when a file is created or updated within your OneDrive.
* Use actions to create a file, delete a file, and more. For example, when a new Office 365 email is received with an attachment (a trigger), create a new file in OneDrive (an action).

This topic shows you how to use the OneDrive connector in a logic app, and also lists the triggers and actions.

> [!NOTE]
> This version of the article applies to Logic Apps general availability (GA). 
> 
> 

To learn more about Logic Apps, see [What are logic apps](../app-service-logic/app-service-logic-what-are-logic-apps.md) and [create a logic app](../app-service-logic/app-service-logic-create-a-logic-app.md).

## Connect to OneDrive
Before your logic app can access any service, you first create a *connection* to the service. A connection provides connectivity between a logic app and another service. For example, to connect to OneDrive, you first need a OneDrive *connection*. To create a connection, enter the credentials you normally use to access the service you wish to connect to. So, with OneDrive, enter the credentials to your OneDrive account  to create the connection.

### Create the connection
> [!INCLUDE [Steps to create a connection to OneDrive](../../includes/connectors-create-api-onedrive.md)]
> 
> 

## Use a trigger
A trigger is an event that can be used to start the workflow defined in a logic app. Triggers "poll" the service at an interval and frequency that you want. [Learn more about triggers](../app-service-logic/app-service-logic-what-are-logic-apps.md#logic-app-concepts).

1. In the logic app, type "onedrive" to get a list of the triggers:  
   
    ![](./media/connectors-create-api-onedrive/onedrive-1.png)
2. Select **When a file is modified**. If a connection already exists, then select the Show Picker button to select a folder.
   
    ![](./media/connectors-create-api-onedrive/sample-folder.png)
   
    If you are prompted to sign in, then enter the sign in details to create the connection. [Create the connection](connectors-create-api-onedrive.md#create-the-connection) in this topic lists the steps. 
   
   > [!NOTE]
   > In this example, the logic app runs when a file in the folder you choose is updated. To see the results of this trigger, add another action that sends you an email. For example, add the Office 365 Outlook *Send an email* action that emails you when a file is updated. 
   > 
3. Select the **Edit** button and set the **Frequency** and **Interval** values. For example, if you want the trigger to poll every 15 minutes, then set the **Frequency** to **Minute**, and set the **Interval** to **15**. 
   
    ![](./media/connectors-create-api-onedrive/trigger-properties.png)
4. **Save** your changes (top left corner of the toolbar). Your logic app is saved and may be automatically enabled.

## Use an action
An action is an operation carried out by the workflow defined in a logic app. [Learn more about actions](../app-service-logic/app-service-logic-what-are-logic-apps.md#logic-app-concepts).

1. Select the plus sign. You see several choices: **Add an action**, **Add a condition**, or one of the **More** options.
   
    ![](./media/connectors-create-api-onedrive/add-action.png)
2. Choose **Add an action**.
3. In the text box, type “onedrive” to get a list of all the available actions.
   
    ![](./media/connectors-create-api-onedrive/onedrive-actions.png) 
4. In our example, choose **OneDrive - Create file**. If a connection already exists, then select the **Folder Path** to put the file, enter the **File Name**, and choose the **File Content** you want:  
   
    ![](./media/connectors-create-api-onedrive/sample-action.png)
   
    If you are prompted for the connection information, then enter the details to create the connection. [Create the connection](connectors-create-api-onedrive.md#create-the-connection) in this topic describes these properties. 
   
   > [!NOTE]
   > In this example, we create a new file in a OneDrive folder. You can use output from another trigger to create the OneDrive file. For example, add the Office 365 Outlook *When a new email arrives* trigger. Then add the OneDrive *Create file* action that uses the Attachments and Content-Type fields within a ForEach to create the new file in OneDrive. 
   > 
   > ![](./media/connectors-create-api-onedrive/foreach-action.png)
   > 
5. **Save** your changes (top left corner of the toolbar). Your logic app is saved and may be automatically enabled.

## Technical Details
## Triggers
| Trigger | Description |
| --- | --- |
| [When a file is created](connectors-create-api-onedrive.md#when-a-file-is-created) |This operation triggers a flow when a new file is created in a folder. |
| [When a file is modified](connectors-create-api-onedrive.md#when-a-file-is-modified) |This operation triggers a flow when a file is modified in a folder. |

## Actions
| Action | Description |
| --- | --- |
| [Get file metadata](connectors-create-api-onedrive.md#get-file-metadata) |This operation gets the metadata for a file. |
| [Update file](connectors-create-api-onedrive.md#update-file) |This operation updates a file. |
| [Delete file](connectors-create-api-onedrive.md#delete-file) |This operation deletes a file. |
| [Get file metadata using path](connectors-create-api-onedrive.md#get-file-metadata-using-path) |This operation gets the metadata of a file using the path. |
| [Get file content using path](connectors-create-api-onedrive.md#get-file-content-using-path) |This operation gets the content of a file using the path. |
| [Get file content](connectors-create-api-onedrive.md#get-file-content) |This operation gets the content of a file. |
| [Create file](connectors-create-api-onedrive.md#create-file) |This operation creates a file. |
| [Copy file](connectors-create-api-onedrive.md#copy-file) |This operation copies a file to OneDrive. |
| [List files in folder](connectors-create-api-onedrive.md#list-files-in-folder) |This operation gets the list of files and subfolders in a folder. |
| [List files in root folder](connectors-create-api-onedrive.md#list-files-in-root-folder) |This operation gets the list of files and subfolders in the root folder. |
| [Extract archive to folder](connectors-create-api-onedrive.md#extract-archive-to-folder) |This operation extracts an archive file into a folder (example: .zip). |

### Action details
In this section, see the specific details about each action, including any required or optional input properties, and any corresponding output associated with the connector.

#### Get file metadata
This operation gets the metadata for a file. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| id* |File |Select a file |

An asterisk (*) means the property is required.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

#### Update file
This operation updates a file. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| id* |File |Select a file |
| body* |File content |Content of the file |

An asterisk (*) means the property is required.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

#### Delete file
This operation deletes a file. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| id* |File |Select a file |

An asterisk (*) means the property is required.

##### Output Details
None.

#### Get file metadata using path
This operation gets the metadata of a file using the path. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| path* |File path |Select a file |

An asterisk (*) means the property is required.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

#### Get file content using path
This operation gets the content of a file using the path. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| path* |File path |Select a file |

An asterisk (*) means the property is required.

##### Output Details
None.

#### Get file content
This operation gets the content of a file. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| id* |File |Select a file |

An asterisk (*) means the property is required.

##### Output Details
None.

#### Create file
This operation creates a file. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| folderPath* |Folder path |Select a folder |
| name* |File name |Name of the file |
| body* |File content |Content of the file |

An asterisk (*) means the property is required.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

#### Copy file
This operation copies a file to OneDrive. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| source* |Source url |Url to source file |
| destination* |Destination file path |Destination file path, including target filename |
| overwrite |Overwrite? |Overwrites the destination file if set to 'true' |

An asterisk (*) means the property is required.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

#### When a file is created
This operation triggers a flow when a new file is created in a folder. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| folderId* |Folder |Select a folder |

An asterisk (*) means the property is required.

##### Output Details
None.

#### When a file is modified
This operation triggers a flow when a file is modified in a folder. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| folderId* |Folder |Select a folder |

An asterisk (*) means the property is required.

##### Output Details
None.

#### List files in folder
This operation gets the list of files and subfolders in a folder.

| Property Name | Display Name | Description |
| --- | --- | --- |
| id* |Folder |Select a folder |

An asterisk (*) means the property is required.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string | |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

#### List files in root folder
This operation gets the list of files and subfolders in the root folder. 

There are no parameters for this call.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

#### Extract archive to folder
This operation extracts an archive file into a folder (example: .zip). 

| Property Name | Display Name | Description |
| --- | --- | --- |
| source* |Source archive file path |Path to the archive file |
| destination* |Destination folder path |Path to extract the archive contents |
| overwrite |Overwrite? |Overwrites the destination files if set to 'true' |

An asterisk (*) means the property is required.

##### Output Details
BlobMetadata

| Property Name | Data Type |
| --- | --- |
| Id |string |
| Name |string |
| DisplayName |string |
| Path |string |
| LastModified |string |
| Size |integer |
| MediaType |string |
| IsFolder |boolean |
| ETag |string |
| FileLocator |string |

## HTTP responses
The following table outlines the responses to the actions and triggers, and the response descriptions:  

| Name | Description |
| --- | --- |
| 200 |OK |
| 202 |Accepted |
| 400 |Bad Request |
| 401 |Unauthorized |
| 403 |Forbidden |
| 404 |Not Found |
| 500 |Internal Server Error. Unknown error occurred |
| default |Operation Failed. |

## Next Steps
[Create a logic app](../app-service-logic/app-service-logic-create-a-logic-app.md). Explore the other available connectors in Logic Apps at our [APIs list](apis-list.md).

