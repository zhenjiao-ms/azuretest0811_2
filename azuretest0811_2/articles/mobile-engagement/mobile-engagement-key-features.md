---
title: Azure Mobile Engagement - Key features
description: Describes the key features of Azure Mobile Engagement
services: mobile-engagement
documentationcenter: mobile
author: piyushjo
manager: erikre
editor: ''

ms.service: mobile-engagement
ms.workload: mobile
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 04/01/2016
ms.author: piyushjo

---
# Azure Mobile Engagement - Key features
This article gives a high level overview about the key features of the Mobile Engagement platform. 

## **General**
* **Find SDKs for all major platforms** 
  SDKs available for all major platforms - iOS, Android, Universal Windows, Windows Phone Silverlight, Kindle, Cordova. 
  We provide easy to integrate SDKs and helpful documentation to get you started on any platform of your choice. 
* **Separate SaaS portal**
  Allows easy access to the marketing team without the need to go through the Azure management portal. 
* **Availability of open REST APIs** 
  To integrate and automate with CRM/CMS/IT systems using open-platform APIs, we provide open REST APIs and .NET SDK to consume these APIs that can allow you to easily integrate and automate with Mobile Engagement. See [this](mobile-engagement-api-authentication.md) for details. 
* **Power BI connector available** 
  You can also pull out the key analytics charts into a Power BI dashboard. See this [guide](https://powerbi.microsoft.com/en-us/documentation/powerbi-content-pack-azure-mobile/)
* **Assurance of Security & Privacy** 
  Azure Mobile Engagement being part of the Azure family follows all the standard best practices around security & privacy expected for a cloud service.

## **Actionable Analytics**
* **Monitor data in real time**
  You can track real time analytics using our Monitor module which shows details like sessions, events, errors & crashes all in real-time. Take a look at this [article](mobile-engagement-concepts.md) to get an understanding of the basic concepts. 
  
    ![](./media/mobile-engagement-key-features/monitor1.png)
  
    ![](./media/mobile-engagement-key-features/monitor2.png)        
* **View aggregated data**
  You also get a richer view of your aggregated analytics data using our Analytics module which allows you to easily filter your data based on your app version and time periods.
  
    ![](./media/mobile-engagement-key-features/analytics-filter.png)        
* **Get insights into your users and retention pattern**
  
    ![](./media/mobile-engagement-key-features/retention.png)        
* **Get insights into where your users are coming from and how much time are they spending in the screen**
  
    ![](./media/mobile-engagement-key-features/analytics-geomap.png)        
  
    ![](./media/mobile-engagement-key-features/analytics-session-length.png)        
* **Find out which screens are your app users visiting and how can you optimize the user path** 
  This helps them to discover screens and features that you want them to.
  
    ![](./media/mobile-engagement-key-features/analytics-activities.png)        
  
    ![](./media/mobile-engagement-key-features/analytics-userpath.png)        
* **Get insights into which are the most frequent events in your app and get an understanding of your business process based on these events** 
  
    ![](./media/mobile-engagement-key-features/analytics-events.png)    
* **Track common errors and crashes and get insights for your developer team**
  
    ![](./media/mobile-engagement-key-features/analyics-errors.png)        
  
    ![](./media/mobile-engagement-key-features/analyics-errors-details.png)    
* **Understand which devices and networks are your app users accessing your app from, to optimize the app** 
  
    ![](./media/mobile-engagement-key-features/technicals.png)    

## **Targeted & Personalized Push Notifications**
* **Create a segment based on any of the collected data** 
  You can use any of the Event/Session/Activity/Job/Crash/Error/Tags data for this.
  
    ![](./media/mobile-engagement-key-features/segment.png)
  
    ![](./media/mobile-engagement-key-features/segment-creation.png)        
* **Track the history of your created segments day over day**
  
    ![](./media/mobile-engagement-key-features/segment-history.png)    
* **Send targeted notifications**
  targeting commonly used like old/new users etc. or to your custom created segment
  
    ![](./media/mobile-engagement-key-features/segment-push.png)    
* **Send both out-of-app/system & rich HTML based in-app push notifications as appropriate for your scenario**
  
    ![](./media/mobile-engagement-key-features/out-of-app.png)    
  
    ![](./media/mobile-engagement-key-features/in-app-push.png)    
* **Target in-app notifications to show up on a specific screen/activity in the app**
  
    ![](./media/mobile-engagement-key-features/push-in-activity.png)    
* **Specify an "action" when the user clicks on a notification**
  It could be as simple as opening up a webpage or navigating within the app to a specific screen at the click of the notification. 
  
    ![](./media/mobile-engagement-key-features/push-action.png)
* **Send localized notifications**
  so that it appeals to the app users in the language they are most comfortable in. 
  
    ![](./media/mobile-engagement-key-features/push-languages.png)    
* **Specify a start and end time for your campaigns** 
  
    ![](./media/mobile-engagement-key-features/push-timeframe.png)    
* **Easily test your notifications** 
  by registering a test device and sending the test notification to only this device.
  
    ![](./media/mobile-engagement-key-features/push-test.png)    
* **Easily set up an in-app notification to show up as a quick poll/survey**  
  
    ![](./media/mobile-engagement-key-features/push-poll.png)
* **Get push campaign statistics** 
  for your notifications to give you an idea about how successful were your notifications.
  
    ![](./media/mobile-engagement-key-features/push-stats.png)    
* **Easily personalize and give character to your notifications using app-info/tags and emojis** 
  
    ![](./media/mobile-engagement-key-features/push_personalized.png)    
  
    ![](./media/mobile-engagement-key-features/push_emoji.png)    
* **Set Push Limits to prevent spamming users**
  You don’t want to send a lot of pushes to your app users and come across as spamming them. This is where our Push limits feature is useful which allows you to configure push limits at the granularity of a segment. 
  
    ![](./media/mobile-engagement-key-features/push_limits.png)            

<!-- Images -->
[1]: ./media/mobile-engagement-key-features/monitor1.png
[2]: ./media/mobile-engagement-key-features/monitor2.png
[3]: ./media/mobile-engagement-key-features/analytics-filter.png
[4]: ./media/mobile-engagement-key-features/retention.png
[5]: ./media/mobile-engagement-key-features/analytics-geomap.png
[6]: ./media/mobile-engagement-key-features/analytics-session-length.png
[7]: ./media/mobile-engagement-key-features/analytics-activities.png
[8]: ./media/mobile-engagement-key-features/analytics-userpath.png
[9]: ./media/mobile-engagement-key-features/analytics-events.png
[10]: ./media/mobile-engagement-key-features/analyics-errors.png
[11]: ./media/mobile-engagement-key-features/analyics-errors-details.png
[12]: ./media/mobile-engagement-key-features/technicals.png
[13]: ./media/mobile-engagement-key-features/segment.png
[14]: ./media/mobile-engagement-key-features/segment-creation.png
[15]: ./media/mobile-engagement-key-features/segment-history.png
[16]: ./media/mobile-engagement-key-features/segment-push.png
[17]: ./media/mobile-engagement-key-features/out-of-app.png
[18]: ./media/mobile-engagement-key-features/in-app-push.png
[19]: ./media/mobile-engagement-key-features/push-in-activity.png
[20]: ./media/mobile-engagement-key-features/push-action.png
[21]: ./media/mobile-engagement-key-features/push-languages.png
[22]: ./media/mobile-engagement-key-features/push-timeframe.png
[23]: ./media/mobile-engagement-key-features/push-test.png
[24]: ./media/mobile-engagement-key-features/push-poll.png
[25]: ./media/mobile-engagement-key-features/push-stats.png
[26]: ./media/mobile-engagement-key-features/push_personalized.png
[27]: ./media/mobile-engagement-key-features/push_emoji.png
[28]: ./media/mobile-engagement-key-features/push_limits.png









