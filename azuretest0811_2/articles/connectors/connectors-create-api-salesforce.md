---
title: Learn to use the Salesforce Connector in your logic apps| Microsoft Azure
description: Create logic apps with Azure App service. The Salesforce Connector provides an API to work with Salesforce objects.
services: logic-apps
documentationcenter: .net,nodejs,java
author: msftman
manager: erikre
editor: ''
tags: connectors

ms.service: logic-apps
ms.devlang: multiple
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: integration
ms.date: 07/22/2016
ms.author: deonhe

---
# Get started with the Salesforce connector
The Salesforce Connector provides an API to work with Salesforce objects.

To use [any connector](apis-list.md), you first need to create a logic app. You can get started by [creating a logic app now](../app-service-logic/app-service-logic-create-a-logic-app.md).

## Connect to Salesforce connector
Before your logic app can access any service, you first need to create a *connection* to the service. A [connection](connectors-overview.md) provides connectivity between a logic app and another service.  

### Create a connection to Salesforce connector
> [!INCLUDE [Steps to create a connection to Salesforce Connector](../../includes/connectors-create-api-salesforce.md)]
> 
> 

## Use a Salesforce connector trigger
A trigger is an event that can be used to start the workflow defined in a logic app. [Learn more about triggers](../app-service-logic/app-service-logic-what-are-logic-apps.md#logic-app-concepts).

> [!INCLUDE [Steps to create a Salesforce trigger](../../includes/connectors-create-api-salesforce-trigger.md)]
> 
> 

## Add a condition
> [!INCLUDE [Steps to create a Salesforce condition](../../includes/connectors-create-api-salesforce-condition.md)]
> 
> 

## Use a Salesforce connector action
An action is an operation carried out by the workflow defined in a logic app. [Learn more about actions](../app-service-logic/app-service-logic-what-are-logic-apps.md#logic-app-concepts).

> [!INCLUDE [Steps to create a Salesforce action](../../includes/connectors-create-api-salesforce-action.md)]
> 
> 

## Technical details
Here are the details about the triggers, actions and responses that this connection supports:

## Salesforce connector triggers
Salesforce Connector has the following trigger(s):  

| Trigger | Description |
| --- | --- |
| [When an object is created](connectors-create-api-salesforceconnector.md#when-an-object-is-created) |This operation triggers a flow when an object is created. |
| [When an object is modified](connectors-create-api-salesforceconnector.md#when-an-object-is-modified) |This operation triggers a flow when an object is modified. |

## Salesforce connector actions
Salesforce Connector has the following actions:

| Action | Description |
| --- | --- |
| [Get objects](connectors-create-api-salesforceconnector.md#get-objects) |Thie operation gets objects of a certain object type like 'Lead'. |
| [Create object](connectors-create-api-salesforceconnector.md#create-object) |This operation creates an object. |
| [Get object](connectors-create-api-salesforceconnector.md#get-object) |This operation gets an object. |
| [Delete object](connectors-create-api-salesforceconnector.md#delete-object) |This operation deletes an object. |
| [Update object](connectors-create-api-salesforceconnector.md#update-object) |This operation updates an object. |
| [Get object types](connectors-create-api-salesforceconnector.md#get-object-types) |This operation lists the available object types. |

### Action details
Here are the details for the actions and triggers for this connector, along with their responses:

### Get objects
Thie operation gets objects of a certain object type like 'Lead'. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| table* |Object type |Salesforce object type like 'Lead' |
| $filter |Filter Query |An ODATA filter query to restrict the number of entries |
| $orderby |Order By |An ODATA orderBy query for specifying the order of entries |
| $skip |Skip Count |Number of entries to skip (default = 0) |
| $top |Maximum Get Count |Maximum number of entries to retrieve (default = 256) |

An * indicates that a property is required

#### Output details
ItemsList

| Property Name | Data Type |
| --- | --- |
| value |array |

### Create object
This operation creates an object. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| table* |Object type |Object type like 'Lead' |
| item* |Object |Object to create |

An * indicates that a property is required

#### Output details
Item

| Property Name | Data Type |
| --- | --- |
| ItemInternalId |string |

### Get object
This operation gets an object. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| table* |Object type |Salesforce object type like 'Lead' |
| id* |Object id |Identifier of object to get |

An * indicates that a property is required

#### Output details
Item

| Property Name | Data Type |
| --- | --- |
| ItemInternalId |string |

### Delete object
This operation deletes an object. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| table* |Object type |Object type like 'Lead' |
| id* |Object id |Identifier of object to delete |

An * indicates that a property is required

### Update object
This operation updates an object. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| table* |Object type |Object type like 'Lead' |
| id* |Object id |Identifier of object to update |
| item* |Object |Object with changed properties |

An * indicates that a property is required

#### Output details
Item

| Property Name | Data Type |
| --- | --- |
| ItemInternalId |string |

### When an object is created
This operation triggers a flow when an object is created. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| table* |Object type |Object type like 'Lead' |
| $filter |Filter Query |An ODATA filter query to restrict the number of entries |
| $orderby |Order By |An ODATA orderBy query for specifying the order of entries |
| $skip |Skip Count |Number of entries to skip (default = 0) |
| $top |Maximum Get Count |Maximum number of entries to retrieve (default = 256) |

An * indicates that a property is required

#### Output details
ItemsList

| Property Name | Data Type |
| --- | --- |
| value |array |

### When an object is modified
This operation triggers a flow when an object is modified. 

| Property Name | Display Name | Description |
| --- | --- | --- |
| table* |Object type |Object type like 'Lead' |
| $filter |Filter Query |An ODATA filter query to restrict the number of entries |
| $orderby |Order By |An ODATA orderBy query for specifying the order of entries |
| $skip |Skip Count |Number of entries to skip (default = 0) |
| $top |Maximum Get Count |Maximum number of entries to retrieve (default = 256) |

An * indicates that a property is required

#### Output details
ItemsList

| Property Name | Data Type |
| --- | --- |
| value |array |

### Get object types
This operation lists the available object types. 

There are no parameters for this call

#### Output details
TablesList

| Property Name | Data Type |
| --- | --- |
| value |array |

## HTTP responses
The actions and triggers above can return one or more of the following HTTP status codes: 

| Name | Description |
| --- | --- |
| 200 |OK |
| 202 |Accepted |
| 400 |Bad Request |
| 401 |Unauthorized |
| 403 |Forbidden |
| 404 |Not Found |
| 500 |Internal Server Error. Unknown error occurred. |
| default |Operation Failed. |

## Next steps
[Create a logic app](../app-service-logic/app-service-logic-create-a-logic-app.md)

