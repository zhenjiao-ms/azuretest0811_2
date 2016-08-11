---
title: Enable Azure AD Application Proxy | Microsoft Azure
description: Turn on Application Proxy in the Azure classic portal, and install the Connectors for the reverse proxy.
services: active-directory
documentationcenter: ''
author: kgremban
manager: femila
editor: ''

ms.service: active-directory
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: get-started-article
ms.date: 07/19/2016
ms.author: kgremban

---
# Enable Application Proxy in the Azure portal
This article walks you through the steps to enable Microsoft Azure AD Application Proxy for your cloud directory in Azure AD.

If you're unfamiliar with what Application Proxy can help you do, learn more about [How to provide secure remote access to on-premises applications](active-directory-application-proxy-get-started.md).

## Application Proxy prerequisites
Before you can enable and use Application Proxy services, you need to have:

* A [Microsoft Azure AD basic or premium subscription](active-directory-editions.md) and an Azure AD directory for which you are a global administrator.
* A server running Windows Server 2012 R2, or Windows 8.1 or higher, on which you can install the Application Proxy Connector. The server sends requests to the Application Proxy services in the cloud, and it needs an HTTP or HTTPS connection to the applications that you are publishing.
  
  * For single sign-on to your published applications, this machine should be domain-joined in the same AD domain as the applications that you are publishing.
* If there is a firewall in the path, make sure that it's open so that the Connector can make HTTPS (TCP) requests to the Application Proxy. The Connector uses these ports together with subdomains that are part of the high-level domains msappproxy.net and servicebus.windows.net. Make sure to open the following ports to **outbound** traffic:
  
  | Port Number | Description |
  | --- | --- |
  | 80 |Enable outbound HTTP traffic for security validation. |
  | 443 |Enable user authentication against Azure AD (required only for the Connector registration process) |
  | 10100–10120 |Enable LOB HTTP responses sent back to the proxy |
  | 9352, 5671 |Enable communication between the Connector toward the Azure service for incoming requests. |
  | 9350 |Optional, to enable better performance for incoming requests |
  | 8080 |Enable the Connector bootstrap sequence and Connector automatic update |
  | 9090 |Enable Connector registration (required only for the Connector registration process) |
  | 9091 |Enable Connector trust certificate automatic renewal |
  
    If your firewall enforces traffic according to originating users, open these ports for traffic coming from Windows services running as a Network Service. Also, make sure to enable port 8080 for NT Authority\System.
* If your organization uses proxy servers to connect to the internet, please take a look at the blog post [Working with existing on-premises proxy servers](https://blogs.technet.microsoft.com/applicationproxyblog/2016/03/07/working-with-existing-on-prem-proxy-servers-configuration-considerations-for-your-connectors/) for details on how to configure them.

## Step 1: Enable Application Proxy in Azure AD
1. Sign in as an administrator in the [Azure classic portal](https://manage.windowsazure.com/).
2. Go to Active Directory and select the directory in which you want to enable Application Proxy.
   
    ![Active Directory - icon](./media/active-directory-application-proxy-enable/ad_icon.png)
3. Select **Configure** from the directory page, and scroll down to **Application Proxy**.
4. Toggle **Enable Application Proxy Services for this Directory** to **Enabled**.
   
    ![Enable Application Proxy](./media/active-directory-application-proxy-enable/app_proxy_enable.png)
5. Select **Download now**. This takes you to the **Azure AD Application Proxy Connector Download**. Read and accept the license terms and click **Download** to save the Windows Installer file (.exe) for the connector.

## Step 2: Install and register the Connector
1. Run **AADApplicationProxyConnectorInstaller.exe** on the server you prepared according to the prerequisites.
2. Follow the instructions in the wizard to install.
3. During installation, you will are prompted to register the connector with the Application Proxy of your Azure AD tenant.
   
   * Provide your Azure AD global administrator credentials. Your global administrator tenant may be different from your Microsoft Azure credentials.
   * Make sure the admin who registers the connector is in the same directory where you enabled the Application Proxy service. For example, if the tenant domain is contoso.com, the admin should be admin@contoso.com or any other alias on that domain.
   * If **IE Enhanced Security Configuration** is set to **On** on the server where you are installing the connector, the registration screen might be blocked. Follow the instructions in the error message to allow access. Make sure that Internet Explorer Enhanced Security is off.
   * If connector registration does not succeed, see [Troubleshoot Application Proxy](active-directory-application-proxy-troubleshoot.md).  
4. When the installation completes, two new services are added to your server:
   
   * **Microsoft AAD Application Proxy Connector** enables connectivity
     
     * **Microsoft AAD Application Proxy Connector Updater** is an automated update service, which periodically checks for new versions of the connector and updates the connector as needed.
     
     ![App Proxy Connector services - screenshot](./media/active-directory-application-proxy-enable/app_proxy_services.png)
5. Click **Finish** in the installation window.

For high availability purposes, you should deploy at least two connectors. To deploy more connectors, repeat steps 2 and 3, above. Each connector must be registered separately.

If you want to uninstall the Connector, uninstall both the Connector service and the Updater service. Restart your computer to fully remove the service.

## Next steps
You are now ready to [Publish applications with Application Proxy](active-directory-application-proxy-publish.md).

If you have applications that are on separate networks or different locations, you can use connector groups to organize the different connectors into logical units. Learn more about [Working with Application Proxy connectors](active-directory-application-proxy-connectors.md).

