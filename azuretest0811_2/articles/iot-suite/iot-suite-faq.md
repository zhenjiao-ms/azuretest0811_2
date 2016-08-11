---
title: Azure IoT Suite FAQ | Microsoft Azure
description: Frequently asked questions for IoT Suite
services: ''
suite: iot-suite
documentationcenter: ''
author: aguilaaj
manager: timlt
editor: ''

ms.service: iot-suite
ms.devlang: na
ms.topic: get-started-article
ms.tgt_pltfrm: na
ms.workload: na
ms.date: 06/27/2016
ms.author: araguila

---
# Frequently asked questions for IoT Suite
### What's the difference between deleting a resource group in the Azure portal and clicking delete on a preconfigured solution in azureiotsuite.com?
* If you delete the preconfigured solution in [azureiotsuite.com](https://www.azureiotsuite.com/), you delete all the resources that were provisioned when you created the preconfigured solution; if you added additional resources to the resource group, these are also deleted. 
* If you delete the resource group in the [Azure portal](https://portal.azure.com), you only delete the resources in that resource group; you will also need to delete the Azure Active Directory application associated with the preconfigured solution in the [Azure classic portal](https://manage.windowsazure.com).

### How many IoT Hub instances can I provision in a subscription?
Ten. You can create an [Azure support ticket](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to raise this limit, but by default, you can only provision ten IoT Hubs per subscription, as outlined in [Azure subscription limits](https://azure.microsoft.com/documentation/articles/azure-subscription-service-limits/#iot-hub-limits). As a result, since every preconfigured solution provisions a new IoT Hub, you can only provision up to ten preconfigured solutions in a given subscription. 

### How many DocumentDB instances can I provision in a subscription?
Fifty. You can create an [Azure support ticket](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to raise this limit, but by default, you can only provision fifty DocumentDB instances per subscription. 

### How many Free Bing Maps APIs can I provision in a subscription?
Two. You can create only two Internal Transactions Level 1 Bing Maps for Enterprise plans in an Azure subscription. The remote monitoring solution is provisioned by default with the Internal Transactions Level 1 plan. As a result, you can only provision up to two remote monitoring solutions in a subscription with no modifications.

### I have a remote monitoring solution deployment with a static map, how do I add an interactive Bing map?
1. Get your Bing Maps API for Enterprise QueryKey from [Azure portal](https://portal.azure.com): 
   
   1. Navigate to the Resource Group where your Bing Maps API for Enterprise is in the [Azure portal](https://portal.azure.com).
   2. Click All Settings, then Key Management. 
   3. You'll notice two keys: MasterKey and QueryKey. Copy the value for QueryKey.
      
      > [!NOTE]
      > Don't have a Bing Maps API for Enterprise account? Create one in the [Azure portal][lnk-azure-portal] by clicking + New, searching for Bing Maps API for Enterprise and follow prompts to create.
      > 
2. Pull down the latest code from the [Azure-IoT-Remote-Monitoring](https://github.com/Azure/azure-iot-remote-monitoring).
3. Run a local or cloud deployment following commandline deployment guidance in the /docs/ folder in the repository. 
4. After you've run a local or cloud deployment, look in your root folder for the *.user.config file created during deployment. Open this file in a text editor. 
5. Change the following line to include the value you copied fror your QueryKey: 
   
   `<setting name="MapApiQueryKey" value="" />`

### Can I create a preconfigured solution if I have Microsoft Azure for DreamSpark?
At this time, you cannot create a preconfigured solution with a [Microsoft Azure for DreamSpark](https://www.dreamspark.com/Product/Product.aspx?productid=99) account. However, you can create a [free trial account for Azure](https://azure.microsoft.com/free/) in just a couple of minutes that will enable you create a preconfigured solution.

### How do I delete an AAD tenant?
See Eric Golpe's blog post [Walkthrough of Deleting an Azure AD Tenant](http://blogs.msdn.com/b/ericgolpe/archive/2015/04/30/walkthrough-of-deleting-an-azure-ad-tenant.aspx).

## Next steps
You can also explore some of the other features and capabilities of the IoT Suite preconfigured solutions:

* [Predictive maintenance preconfigured solution overview](iot-suite-predictive-overview.md)
* [IoT security from the ground up](securing-iot-ground-up.md)

[lnk-predictive-overview]: iot-suite-predictive-overview.md
[lnk-security-groundup]: securing-iot-ground-up.md

[link-azuresupportticket]: https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade 
[link-azuresublimits]: https://azure.microsoft.com/documentation/articles/azure-subscription-service-limits/#iot-hub-limits
[lnk-azure-portal]: https://portal.azure.com
[lnk-azureiotsuite]: https://www.azureiotsuite.com/
[lnk-classic-portal]: https://manage.windowsazure.com
[lnk-remote-monitoring-github]: https://github.com/Azure/azure-iot-remote-monitoring 
[lnk-dreamspark]: https://www.dreamspark.com/Product/Product.aspx?productid=99 
[lnk-30daytrial]: https://azure.microsoft.com/free/
[lnk-delete-aad-tennant]: http://blogs.msdn.com/b/ericgolpe/archive/2015/04/30/walkthrough-of-deleting-an-azure-ad-tenant.aspx
