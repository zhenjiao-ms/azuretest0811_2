---
title: Logic Apps pricing model | Microsoft Azure
description: Details about how pricing works in Logic Apps
author: kevinlam1
manager: dwrede
editor: ''
services: logic-apps
documentationcenter: ''

ms.service: logic-apps
ms.workload: na
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 07/27/2016
ms.author: klam

---
# Logic Apps pricing model
Azure Logic Apps allows you to scale and execute integration workflows in the cloud.  Below are details on the billing and pricing plans for Logic Apps.

## Consumption pricing
Newly created Logic Apps use a consumption plan. With the Logic Apps consumption pricing model, you only pay for what you use.  Logic Apps are not throttled when using a consumption plan.
All actions executed in a run of a logic app instance are metered.

### What are action executions?
Every step in a logic app definition is an action.  This includes triggers, control flow steps like conditions, scopes, for each loops, do until loops, calls to connectors and calls to native actions.
Triggers are just special actions that are designed to instantiate a new instance of a logic app when a particular event occurs.  There are a number of different behaviors for triggers which could affect how the logic app is metered.

* **Polling trigger** – this trigger continually polls an endpoint until it receives a message that satisfies the criteria for creating a new instance of a logic app.  The polling interval can be configured in the trigger in the Logic Apps designer.  Each polling request, even if it doesn’t create a new instance of a logic app, will count as an action execution.
* **Webhook trigger** – this trigger waits for a client to send it a request on a particular endpoint.  Each request sent to the webhook endpoint counts as an action execution. The Request and the HTTP Webhook trigger are both webhook triggers.
* **Recurrence trigger** – this trigger will create a new instance of the logic app based on the recurrence interval configured in the trigger.  For example, a recurrence trigger can be configured to run every 3 days or even every minute.

Trigger executions can be seen in the Logic Apps resource blade in the Trigger History part.

All actions that were executed, whether they were successful or failed are metered as an action execution.  Actions that were skipped due to a condition not being met or actions that didn’t execute because the logic app terminated before completion are not counted as action executions.

Actions executed within loops are counted per iteration of the loop.  For example, a single action in a for each loop iterating through a list of 10 items will be counted as the count of items in the list (10) multiplied by the number of actions in the loop (1) plus one for the initiation of the loop which, in this example, would be (10 * 1) + 1 = 11 action executions.

Logic Apps that are disabled cannot have new instances instantiated and therefore during the time that they are disabled will not get charged.  Be mindful that after disabling a logic app it may take a little time for the instances to quiesce before being completely disabled.

## App Service plans
App Service Plans are no longer required to create a Logic App.  You can also reference an App Service Plan with an existing logic app.  Logic apps previously created with an App Service Plan will continue to behave as before where, depending on the plan chosen, will get throttled after a number of daily executions are exceeded and will not be billed using the action execution meter.

App Service Plans and their daily allowed action executions:

|  | Free/Shared/Basic | Standard | Premium |
| --- | --- | --- | --- |
| Action executions per day |200 |10,000 |50,000 |

### Convert from Consumption to App Service Plan pricing
To reference an App Service Plan for a consumption Logic App, you can simply [run the below PowerShell script](https://github.com/logicappsio/ConsumptionToAppServicePlan).  Make sure you first have the [Azure PowerShell tools](https://github.com/Azure/azure-powershell) installed.

``` powershell
Param(
    [string] $AppService_RG = '<app-service-resource-group>',
    [string] $AppService_Name = '<app-service-name>',
    [string] $LogicApp_RG = '<logic-app-resource-group>',
    [string] $LogicApp_Name = '<logic-app-name>',
    [string] $subscriptionId = '<azure-subscription-id>'
)

Login-AzureRmAccount 
$subscription = Get-AzureRmSubscription -SubscriptionId $subscriptionId
$appserviceplan = Get-AzureRmResource -ResourceType "Microsoft.Web/serverFarms" -ResourceGroupName $AppService_RG -ResourceName $AppService_Name
$logicapp = Get-AzureRmResource -ResourceType "Microsoft.Logic/workflows" -ResourceGroupName $LogicApp_RG -ResourceName $LogicApp_Name

$sku = @{
    "name" = $appservicePlan.Sku.tier;
    "plan" = @{
      "id" = $appserviceplan.ResourceId;
      "type" = "Microsoft.Web/ServerFarms";
      "name" = $appserviceplan.Name  
    }
}

$updatedProperties = $logicapp.Properties | Add-Member @{sku = $sku;} -PassThru

$updatedLA = Set-AzureRmResource -ResourceId $logicapp.ResourceId -Properties $updatedProperties -ApiVersion 2015-08-01-preview
```

### Convert from App Service Plan pricing to Consumption
To change a Logic App that has an App Service Plan associated with it to a consumption model remove the reference to the App Service Plan in the Logic App definition.  This can be done with a call to a PowerShell cmdlet:

`Set-AzureRmLogicApp -ResourceGroupName ‘rgname’ -Name ‘wfname’ –UseConsumptionModel -Force`

## Pricing
For pricing details please see [Logic Apps Pricing](https://azure.microsoft.com/pricing/details/logic-apps/).

## Next steps
* [An overview of Logic Apps](app-service-logic-what-are-logic-apps.md)
* [Create your first logic app](app-service-logic-create-a-logic-app.md)

[pricing]: https://azure.microsoft.com/pricing/details/logic-apps/
[whatis]: app-service-logic-what-are-logic-apps.md
[create]: app-service-logic-create-a-logic-app.md

