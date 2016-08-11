---
title: Authenticate with Mobile Engagement REST APIs - manual setup
description: Describes how to manually setup authentication for Mobile Engagement REST APIs
services: mobile-engagement
documentationcenter: mobile
author: piyushjo
manager: erikre
editor: ''

ms.service: mobile-engagement
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: mobile-multiple
ms.workload: mobile
ms.date: 05/03/2016
ms.author: piyushjo

---
# Authenticate with Mobile Engagement REST APIs - manual setup
This is an appendix documentation to [Authenticate with Mobile Engagement REST APIs](mobile-engagement-api-authentication.md). Make sure you read it first to get the context. 
This describes an alternate way to do the One-time setup for setting up your authentication for the Mobile Engagement REST APIs using the Azure Portal. 

> [!NOTE]
> The instructions below are based on this [Active Directory guide](../resource-group-create-service-principal-portal.md) and customized for what is required for authentication for Mobile Engagement APIs. So refer to it if you want to understand the steps below in detail. 
> 
> 

1. Login to your Azure Account through the [classic portal](https://manage.windowsazure.com/).
2. Select **Active Directory** from the left pane.
   
     ![select Active Directory](./media/mobile-engagement-api-authentication-manual/active-directory.png)
3. Choose the **Default Active Directory** in your Azure portal. 
   
     ![choose directory](./media/mobile-engagement-api-authentication-manual/active-directory-details.png)
   
   > [!IMPORTANT]
   > This approach works only when you are working in the default Active Directory of your account and will not work if you are doing this in an Active Directory that you have created in your account. 
   > 
4. To view the applications in your directory, click on **Applications**.
   
     ![view applications](./media/mobile-engagement-api-authentication-manual/view-applications.png)
5. Click on **ADD**. 
   
     ![add application](./media/mobile-engagement-api-authentication-manual/add-icon.png)
6. Click on **Add an application my organization is developing**
   
     ![new application](./media/mobile-engagement-api-authentication-manual/what-do-you-want-to-do.png)
7. Fill in name of the application and select the type of application as **WEB APPLICATION AND/OR WEB API** and click the next button.
   
     ![name application](./media/mobile-engagement-api-authentication-manual/tell-us-about-your-application.png)
8. You can provide any dummy URLs for **SIGN-ON URL** and **APP ID URI**. They are not used for our scenario and the URLs themselves are not validated.  
   
     ![application properties](./media/mobile-engagement-api-authentication-manual/app-properties.png)
9. At the end of this, you will have an AAD app with the name you provided previously like the following. This is your **AD\_APP\_NAME** and make a note of it.  
   
     ![app name](./media/mobile-engagement-api-authentication-manual/aad-app.png)
10. Click on the app name and click on **Configure**.
    
      ![configure app](./media/mobile-engagement-api-authentication-manual/configure-menu.png)
11. Make a note of the CLIENT ID that will be used as **CLIENT\_ID** for your API calls. 
    
     ![configure app](./media/mobile-engagement-api-authentication-manual/client-id.png)
12. Scroll down to the **Keys** section and add a key with preferably 2 years (expiry) duration and click **Save**. 
    
     ![configure app](./media/mobile-engagement-api-authentication-manual/client_secret.png)
13. Immediately copy the value which is shown for the key as it is only shown now and is not stored so will not be displayed ever again. If you lose it then you will have to generate a new key. This will be the **CLIENT_SECRET** for your API calls. 
    
     ![configure app](./media/mobile-engagement-api-authentication-manual/keys.png)
    
    > [!IMPORTANT]
    > This key will expire at the end of the duration that you specified so make sure to renew it when the time comes otherwise your API authentication will not work anymore. You can also delete and recreate this key if you think that it has been compromised.
    > 
14. Click on **VIEW ENDPOINTS** button now which will open up the **App Endpoints** dialog box. 
    
    ![](./media/mobile-engagement-api-authentication-manual/view-endpoints.png)
15. From the App Endpoints dialog box, copy the **OAUTH 2.0 TOKEN ENDPOINT**. 
    
    ![](./media/mobile-engagement-api-authentication-manual/app-endpoints.png)
16. This endpoint will be in the following form where the GUID in the URL is your **TENANT_ID** so make a note of it: 
    
        https://login.microsoftonline.com/<GUID>/oauth2/token
17. Now we will proceed to configure the permissions on this app. For this you will have to open up the [Azure portal](https://portal.azure.com). 
18. Click on **Resource Groups** and find the **Mobile Engagement** resource group.  
    
    ![](./media/mobile-engagement-api-authentication-manual/resource-groups.png)
19. Click the **Mobile Engagement** resource group and navigate to the **Settings** blade here. 
    
    ![](./media/mobile-engagement-api-authentication-manual/resource-groups-settings.png)
20. Click on **Users** in the Settings blade and then click on **Add** to add a user. 
    
    ![](./media/mobile-engagement-api-authentication-manual/add-users.png)
21. Click on **Select a role**
    
    ![](./media/mobile-engagement-api-authentication-manual/add-role.png)
22. Click on **Owner**
    
    ![](./media/mobile-engagement-api-authentication-manual/select-role.png)
23. Search for the name of your application **AD\_APP\_NAME** in the Search box. You will not see this by default here. Once you find it, select it and click on **Select** at the bottom of the blade. 
    
    ![](./media/mobile-engagement-api-authentication-manual/add-user-select.png)
24. On the **Add Access** blade, it will show up as **1 user, 0 groups**. Click **OK** on this blade to confirm the change. 
    
    ![](./media/mobile-engagement-api-authentication-manual/add-access-final.png)

You have now completed the required AAD configuration and you are all set to call the APIs. 

<!-- Images -->
[1]: ./media/mobile-engagement-api-authentication-manual/active-directory.png
[2]: ./media/mobile-engagement-api-authentication-manual/active-directory-details.png
[3]: ./media/mobile-engagement-api-authentication-manual/view-applications.png
[4]: ./media/mobile-engagement-api-authentication-manual/add-icon.png
[5]: ./media/mobile-engagement-api-authentication-manual/what-do-you-want-to-do.png
[6]: ./media/mobile-engagement-api-authentication-manual/tell-us-about-your-application.png
[7]: ./media/mobile-engagement-api-authentication-manual/app-properties.png
[8]: ./media/mobile-engagement-api-authentication-manual/aad-app.png
[9]: ./media/mobile-engagement-api-authentication-manual/configure-menu.png
[10]: ./media/mobile-engagement-api-authentication-manual/client-id.png
[11]: ./media/mobile-engagement-api-authentication-manual/client_secret.png
[12]: ./media/mobile-engagement-api-authentication-manual/keys.png
[13]: ./media/mobile-engagement-api-authentication-manual/view-endpoints.png
[14]: ./media/mobile-engagement-api-authentication-manual/app-endpoints.png
[15]: ./media/mobile-engagement-api-authentication-manual/resource-groups.png
[16]: ./media/mobile-engagement-api-authentication-manual/resource-groups-settings.png
[17]: ./media/mobile-engagement-api-authentication-manual/add-users.png
[18]: ./media/mobile-engagement-api-authentication-manual/add-role.png
[19]: ./media/mobile-engagement-api-authentication-manual/select-role.png
[20]: ./media/mobile-engagement-api-authentication-manual/add-user-select.png
[21]: ./media/mobile-engagement-api-authentication-manual/add-access-final.png



