---
title: Common cloud service management tasks | Microsoft Azure
description: Learn how to manage cloud services in the Azure portal. These examples use the Azure portal.
services: cloud-services
documentationcenter: ''
author: Thraka
manager: timlt
editor: ''

ms.service: cloud-services
ms.workload: tbd
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 08/02/2016
ms.author: adegeo

---
# How to Manage Cloud Services
> [!div class="op_single_selector"]
> * [Azure portal](cloud-services-how-to-manage-portal.md)
> * [Azure classic portal](cloud-services-how-to-manage.md)
> 
> 

Your cloud service is managed in the **Cloud Services (classic)** area of the Azure portal. This article describes some common actions you would take while managing your cloud services. Which includes updating, deleting, scaling, and promoting a staged deployment to production.

More information about how to scale your cloud service is available [here](cloud-services-how-to-scale-portal.md).

## How to: Update a cloud service role or deployment
If you need to update the application code for your cloud service, use **Update** on the cloud service blade. You can update a single role or all roles. To update, you can upload a new service package or service configuration file.

1. In the [Azure portal](https://portal.azure.com), select the cloud service you want to update. This step opens the cloud service instance blade.
2. In the blade, click the **Update** button.
   
    ![Update Button](./media/cloud-services-how-to-manage-portal/update-button.png)
3. Update the deployment with a new service package file (.cspkg) and service configuration file (.cscfg).
   
    ![UpdateDeployment](./media/cloud-services-how-to-manage-portal/update-blade.png)
4. **Optionally** update the deployment label and the storage account. 
5. If any roles have only one role instance, select the **Deploy even if one or more roles contain a single instance** to enable the upgrade to proceed. 
   
    Azure can only guarantee 99.95 percent service availability during a cloud service update if each role has at least two role instances (virtual machines). With two role instances, one virtual machine will process client requests while the other is updated.
6. Check **Start deployment** to have the update applied after the upload of the package has finished.
7. Click **OK** to begin updating the service.

## How to: Swap deployments to promote a staged deployment to production
When you decide to deploy a new release of a cloud service, stage and test your new release in your cloud service staging environment. Use **Swap** to switch the URLs by which the two deployments are addressed and promote a new release to production. 

You can swap deployments from the **Cloud Services** page or the dashboard.

1. In the [Azure portal](https://portal.azure.com), select the cloud service you want to update. This step opens the cloud service instance blade.
2. In the blade, click the **Swap** button.
   
    ![Cloud Services Swap](./media/cloud-services-how-to-manage-portal/swap-button.png)
3. The following confirmation prompt opens.
   
    ![Cloud Services Swap](./media/cloud-services-how-to-manage-portal/swap-prompt.png)
4. After you verify the deployment information, click **OK** to swap the deployments.
   
    The deployment swap happens quickly because the only thing that changes is the virtual IP addresses (VIPs) for the deployments.
   
    To save compute costs, you can delete the staging deployment after you verify that your production deployment is working as expected.

## How to: Link a resource to a cloud service
The Azure portal does not link resources together like the current Azure classic portal does. Instead, deploy additional resources to the same resource group being used by the Cloud Service.

## How to: Delete deployments and a cloud service
Before you can delete a cloud service, you must delete each existing deployment.

To save compute costs, you can delete the staging deployment after you verify that your production deployment is working as expected. You are billed for compute costs for deployed role instances that are stopped.

Use the following procedure to delete a deployment or your cloud service. 

1. In the [Azure portal](https://portal.azure.com), select the cloud service you want to delete. This step opens the cloud service instance blade.
2. In the blade, click the **Delete** button.
   
    ![Cloud Services Swap](./media/cloud-services-how-to-manage-portal/delete-button.png)
3. You can delete the entire cloud service by checking **Cloud service and its deployments** or choose either the **Production deployment** or the **Staging deployment**.
   
    ![Cloud Services Swap](./media/cloud-services-how-to-manage-portal/delete-blade.png) 
4. Click the **Delete** button at the bottom.
5. To delete the cloud service, click **Delete cloud service**. Then, at the confirmation prompt, click **Yes**.

> [!NOTE]
> When a cloud service is deleted, and verbose monitoring is configured, you must delete the data manually from your storage account. For information about where to find the metrics tables, see [this](cloud-services-how-to-monitor.md) article.
> 
> 

[Azure portal]: https://portal.azure.com

## Next steps
* [General configuration of your cloud service](cloud-services-how-to-configure-portal.md).
* Learn how to [deploy a cloud service](cloud-services-how-to-create-deploy-portal.md).
* Configure a [custom domain name](cloud-services-custom-domain-name-portal.md).
* Configure [ssl certificates](cloud-services-configure-ssl-certificate-portal.md).

