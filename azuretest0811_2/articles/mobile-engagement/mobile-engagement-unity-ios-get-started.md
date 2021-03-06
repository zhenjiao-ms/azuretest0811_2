---
title: Get Started with Azure Mobile Engagement for Unity iOS deployment
description: Learn how to use Azure Mobile Engagement with Analytics and Push Notifications for Unity apps deploying to iOS devices.
services: mobile-engagement
documentationcenter: unity
author: piyushjo
manager: ''
editor: ''

ms.service: mobile-engagement
ms.workload: mobile
ms.tgt_pltfrm: mobile-unity-ios
ms.devlang: dotnet
ms.topic: hero-article
ms.date: 03/25/2016
ms.author: piyushjo

---
# Get Started with Azure Mobile Engagement for Unity iOS deployment
[!INCLUDE [Hero tutorial switcher](../../includes/mobile-engagement-hero-tutorial-switcher.md)]

This topic shows you how to use Azure Mobile Engagement to understand your app usage and how to send push notifications to segmented users of a Unity application when deploying to an iOS device.
This tutorial uses the classic Unity Roll a Ball tutorial as the starting point. You should follow the steps in this [tutorial](mobile-engagement-unity-roll-a-ball.md) before proceeding with the Mobile Engagement integration we showcase in the tutorial below. 

This tutorial requires the following:

* [Unity Editor](http://unity3d.com/get-unity)
* [Mobile Engagement Unity SDK](https://aka.ms/azmeunitysdk)
* XCode Editor

> [!NOTE]
> To complete this tutorial, you must have an active Azure account. If you don't have an account, you can create a free trial account in just a couple of minutes. For details, see [Azure Free Trial](https://azure.microsoft.com/pricing/free-trial/?WT.mc_id=A0E0E5C02&amp;returnurl=http%3A%2F%2Fazure.microsoft.com%2Fen-us%2Fdocumentation%2Farticles%2Fmobile-engagement-unity-ios-get-started).
> 
> 

## <a id="setup-azme"></a>Setup Mobile Engagement for your iOS app
[!INCLUDE [Create Mobile Engagement App in Portal](../../includes/mobile-engagement-create-app-in-portal.md)]

## <a id="connecting-app"></a>Connect your app to the Mobile Engagement backend
### Import the Unity package
1. Download the [Mobile Engagement Unity package](https://aka.ms/azmeunitysdk) and save it to your local machine. 
2. Go to **Assets -> Import Package -> Custom Package** and select the package you downloaded in the above step. 
   
    ![](./media/mobile-engagement-unity-ios-get-started/70.png) 
3. Make sure all files are selected and click **Import** button. 
   
    ![](./media/mobile-engagement-unity-ios-get-started/71.png) 
4. Once Import is successful, you will see the imported SDK files in your project.  
   
    ![](./media/mobile-engagement-unity-ios-get-started/72.png) 

### Update the EngagementConfiguration
1. Open up the **EngagementConfiguration** script file from the SDK folder and update the **IOS\_CONNECTION\_STRING** with the connection string you obtained earlier from the Azure portal.  
   
    ![](./media/mobile-engagement-unity-ios-get-started/73.png)
2. Save the file. 

### Configure the app for basic tracking
1. Open up the **PlayerController** script attached to the Player object for editing. 
2. Add the following using statement:
   
        using Microsoft.Azure.Engagement.Unity;
3. Add the following to the `Start()` method
   
        EngagementAgent.Initialize();
        EngagementAgent.StartActivity("Home");

### Deploy and run the app
1. Connect an iOS device to your machine. 
2. Open up **File -> Build Settings** 
   
    ![](./media/mobile-engagement-unity-ios-get-started/40.png)
3. Select **iOS** and then click on **Switch Platform**
   
    ![](./media/mobile-engagement-unity-ios-get-started/41.png)
   
    ![](./media/mobile-engagement-unity-ios-get-started/42.png)
4. Click on **Player settings** and provide a valid Bundle Identifier. 
   
    ![](./media/mobile-engagement-unity-ios-get-started/53.png)
5. Finally click on **Build And Run**
   
    ![](./media/mobile-engagement-unity-ios-get-started/54.png)
6. You may be asked to provide a folder name to store the iOS package. 
   
    ![](./media/mobile-engagement-unity-ios-get-started/43.png)
7. If everything goes fine, then the project will be compiled and you should open it up on your XCode application. 
8. Make sure that the **Bundle identifier** is correct in the project.  
   
    ![](./media/mobile-engagement-unity-ios-get-started/75.png)
9. Now run the app in XCode so that the package is deployed to your connected device and you should see your Unity game on your phone! 

## <a id="monitor"></a>Connect app with real-time monitoring
[!INCLUDE [Connect app with real-time monitoring](../../includes/mobile-engagement-connect-app-with-monitor.md)]

## <a id="integrate-push"></a>Enable push notifications and in-app messaging
Mobile Engagement allows you to interact with your users and REACH with push notifications and in-app messaging in the context of campaigns. This module is called REACH in the Mobile Engagement portal.
You don't have to do any additional configuration in your app to receive notifications and it is already setup for it.

[!INCLUDE [mobile-engagement-ios-send-push-push](../../includes/mobile-engagement-ios-send-push.md)]

<!-- Images. -->
[40]: ./media/mobile-engagement-unity-ios-get-started/40.png
[41]: ./media/mobile-engagement-unity-ios-get-started/41.png
[42]: ./media/mobile-engagement-unity-ios-get-started/42.png
[43]: ./media/mobile-engagement-unity-ios-get-started/43.png
[53]: ./media/mobile-engagement-unity-ios-get-started/53.png
[54]: ./media/mobile-engagement-unity-ios-get-started/54.png
[70]: ./media/mobile-engagement-unity-ios-get-started/70.png
[71]: ./media/mobile-engagement-unity-ios-get-started/71.png
[72]: ./media/mobile-engagement-unity-ios-get-started/72.png
[73]: ./media/mobile-engagement-unity-ios-get-started/73.png
[74]: ./media/mobile-engagement-unity-ios-get-started/74.png
[75]: ./media/mobile-engagement-unity-ios-get-started/75.png