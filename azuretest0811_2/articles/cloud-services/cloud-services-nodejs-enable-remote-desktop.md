---
title: Enable remote desktop for cloud services (Node.js)
description: Learn how to enable remote-desktop access for the virtual machines hosting your Azure Node.js application.
services: cloud-services
documentationcenter: nodejs
author: rmcmurray
manager: wpickett
editor: ''

ms.service: cloud-services
ms.workload: tbd
ms.tgt_pltfrm: na
ms.devlang: nodejs
ms.topic: article
ms.date: 06/24/2016
ms.author: robmcm

---
# Enabling Remote Desktop in Azure
Remote Desktop enables you to access the desktop of a role instance
running in Azure. You can use a remote desktop connection to
configure the virtual machine or troubleshoot problems with your
application.

> [!NOTE]
> This article applies to Node.js applications hosted as an Azure Cloud Service.
> 
> 

## Prerequisites
* Install and configure [Azure Powershell](../powershell-install-configure.md).
* Deploy a Node.js app to an Azure Cloud Service. For more information, see [Build and deploy a Node.js application to an Azure Cloud Service](cloud-services-nodejs-develop-deploy-app.md).

## Step 1: Use Azure PowerShell to configure the service for Remote Desktop access
To use Remote Desktop, you need to update the Azure service definition and
configuration with a username, password, and certificate. 

Perform the following steps from a computer that contains the source files for your app.

1. Run **Windows PowerShell** as Administrator. (From the **Start Menu** or **Start Screen**, search for **Windows PowerShell**.)
2. Navigate to the directory that contains the service definition (.csdef) and
   service configuration (.cscfg) files.
3. Enter the following PowerShell cmdlet:
   
        Enable-AzureServiceProjectRemoteDesktop
4. At the prompt, enter a user name and password.
   
    ![enable-azureserviceprojectremotedesktop](./media/cloud-services-nodejs-enable-remote-desktop/enable-rdp.png)
5. Enter the following PowerShell cmdlet to publish the changes:
   
       Publish-AzureServiceProject
   
   ![publish-azureserviceproject](./media/cloud-services-nodejs-enable-remote-desktop/publish-rdp.png)

## Step 2: Connect to the role instance
After you publish the update service definition, you can connect to
the role instance.

1. In the [Azure classic portal](http://manage.windowsazure.com), select **Cloud Services** and then select your service.
   
   ![Azure classic portal](./media/cloud-services-nodejs-enable-remote-desktop/cloud-services-remote.png)
2. Click **Instances**, and then click **Production** or **Staging** to see the instances for your service. Select an instance and then click **Connect** at the bottom of the page.
   
   ![The instances page](./media/cloud-services-nodejs-enable-remote-desktop/cloud-service-instance.png)
3. When you click **Connect**, the web browser prompts you to save an
   .rdp file. Open this file. (For example, if you're using Internet Explorer, click **Open**.)
   
   ![prompt to open or save the .rdp file](./media/cloud-services-nodejs-enable-remote-desktop/rdp-open.png)
4. When the file is opened, the following security prompt appears:
   
   ![Windows security prompt](./media/cloud-services-nodejs-enable-remote-desktop/remote-desktop-12.png)
5. Click **Connect**, and a security prompt will appear for entering
   credentials to access the instance. Enter the password you created
   in [Step 1][Step 1: Configure the service for Remote Desktop access using Azure PowerShell], and then click **OK**.
   
   ![username/password prompt](./media/cloud-services-nodejs-enable-remote-desktop/remote-desktop-13.png)

When the connection is made, Remote Desktop Connection displays the
desktop of the instance in Azure. 

![Remote desktop session](./media/cloud-services-nodejs-enable-remote-desktop/remote-desktop-14.png)

## Step 3: Configure the service to disable Remote Desktop access
When you no longer require remote desktop connections to the role
instances in the cloud, disable remote desktop access using [Azure PowerShell].

1. Enter the following PowerShell cmdlet:
   
       Disable-AzureServiceProjectRemoteDesktop
2. Enter the following PowerShell cmdlet to publish the changes:
   
       Publish-AzureServiceProject

## Additional Resources
* [Remotely Accessing Role Instances in Azure](http://msdn.microsoft.com/library/windowsazure/hh124107.aspx) 
* [Using Remote Desktop with Azure Roles](http://msdn.microsoft.com/library/windowsazure/gg443832.aspx)
* [Node.js Developer Center](/develop/nodejs/)
  
  [Azure PowerShell]: http://go.microsoft.com/?linkid=9790229&clcid=0x409

[Azure classic portal]: http://manage.windowsazure.com
[publish-project]: ./media/cloud-services-nodejs-enable-remote-desktop/publish-rdp.png
[enable-rdp]: ./media/cloud-services-nodejs-enable-remote-desktop/enable-rdp.png
[cloud-services]: ./media/cloud-services-nodejs-enable-remote-desktop/cloud-services-remote.png
[3]: ./media/cloud-services-nodejs-enable-remote-desktop/cloud-service-instance.png
[4]: ./media/cloud-services-nodejs-enable-remote-desktop/rdp-open.png
[5]: ./media/cloud-services-nodejs-enable-remote-desktop/remote-desktop-12.png
[6]: ./media/cloud-services-nodejs-enable-remote-desktop/remote-desktop-13.png
[7]: ./media/cloud-services-nodejs-enable-remote-desktop/remote-desktop-14.png

[Remotely Accessing Role Instances in Azure]: http://msdn.microsoft.com/library/windowsazure/hh124107.aspx
[Using Remote Desktop with Azure Roles]: http://msdn.microsoft.com/library/windowsazure/gg443832.aspx
