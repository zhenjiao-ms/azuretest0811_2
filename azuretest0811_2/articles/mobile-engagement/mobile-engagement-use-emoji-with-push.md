---
title: Use Emoji emoticons within Azure Mobile Engagement
description: How to use Emoji emoticons within your push notifications
services: mobile-engagement
documentationcenter: mobile
author: piyushjo
manager: dwrede
editor: ''

ms.service: mobile-engagement
ms.workload: mobile
ms.tgt_pltfrm: mobile-windows-phone
ms.devlang: na
ms.topic: article
ms.date: 02/29/2016
ms.author: piyushjo

---
# Use Emoji emoticon within Push Notifications
You can include Emoji emoticons in you push notification in a few easy steps: 

1. First of all you need to find the Emoji you want to send in the message. Please ensure that the Emoji you are selecting will be supported by the target device as device manufactures take some time to add newly approved Emojis to the device platforms. 
2. On **Windows** - you can navigate to this [link](http://apps.timwhitlock.info/emoji/tables/unicode) and copy the 'Native' icon.
   
    ![](./media/mobile-engagement-use-emoji-with-push/Windows_SelectEmoji.png) 
3. On **Mac** - you can find the Emojis in Dictionary application under Edit -> Emoji & Symbols.
   
    ![](./media/mobile-engagement-use-emoji-with-push/Mac_SelectEmoji.png) 
4. Now, go to the **Reach** tab on the the Azure Mobile Engagement portal. Select the type of your push notification (Announcement, polls etc). For this example we choose an announcement push.
5. Specify the different fields of the notification until you reach the text of the notification. This is where you will add your Emoji Emoticon. You can choose to put it in the title, the message, or both. You will need to drag and drop or copy the Emoji that you find from the locations above. 
   
    ![](./media/mobile-engagement-use-emoji-with-push/notification_input.png)
6. Complete the other fields for the notification and save it. 
7. When you run a test or activate the announcement you will see a notification with the emoticon as specified.   
   
    ![](./media/mobile-engagement-use-emoji-with-push/iOS_Emoji.png) ![](./media/mobile-engagement-use-emoji-with-push/Android_Emoji.png) ![](./media/mobile-engagement-use-emoji-with-push/WindowsPhone_Emoji.png)

<!-- Images. -->
[1]: ./media/mobile-engagement-use-emoji-with-push/notification_input.png
[3]: ./media/mobile-engagement-use-emoji-with-push/iOS_Emoji.png
[4]: ./media/mobile-engagement-use-emoji-with-push/Android_Emoji.png
[5]: ./media/mobile-engagement-use-emoji-with-push/WindowsPhone_Emoji.png
[6]: ./media/mobile-engagement-use-emoji-with-push/Mac_SelectEmoji.png
[7]: ./media/mobile-engagement-use-emoji-with-push/Windows_SelectEmoji.png

