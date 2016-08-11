---
title: Using the Office 365 Connector in Logic Apps | Microsoft Azure App Service
description: How to create and configure the Office 365 Connector or API app and use it in a logic app in Azure App Service
services: logic-apps
documentationcenter: .net,nodejs,java
author: anuragdalmia
manager: erikre
editor: ''

ms.service: logic-apps
ms.devlang: multiple
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: integration
ms.date: 03/16/2016
ms.author: sameerch

---
# Get started with the Office 365 Connector and add it to your Logic App
> [!NOTE]
> This version of the article applies to logic apps 2014-12-01-preview schema version. For the 2015-08-01-preview schema version, click [Office 365 Outlook API](../connectors/connectors-create-api-office365-outlook.md) or [Office 365 Users API](../connectors/connectors-create-api-office365-users.md).
> 
> 

Connect to your Office 365 account to send and receive emails, and manage your calendar and contacts. You can perform various actions such as send, receive and get emails, create and delete events in your calendar and create, update, get and delete your contacts.

Logic apps can trigger based on a variety of data sources and offer connectors to get and process data as a part of the flow. You can add the Office 365 connector to your business workflow and process data as part of this workflow within a Logic App. 

**Basic Actions**

* New Mail (Trigger)
* Send Mail
* Reply To Mail
* Send Event
* Add Contact

## Create the O365 Connector API App
A connector can be created within a logic app or be created directly from the Azure Marketplace. To create a connector from the Marketplace:  

1. In the Azure startboard, select **Marketplace**.
2. Search for “Office 365 Connector”, select it, and select **Create**.
3. Configure the Office 365 Connector by providing the details for Hosting Plan, the resource group and selecting the name of the API App:  
   ![](./media/app-service-logic-connector-office365/21-create-new-o365-api-app.png)

## Create a Logic App
Let us create a simple logic app that gets triggered when an email is received (at your sales enquiry email id - say sales@contoso.com). And, it creates an event, adds a contact with the sender's details, sends an email to your personal account and finally sends a reply with an acknowledgment.

1. Sign in to Azure Portal and click on ‘New -> Web + mobile -> Logic App’:  
   ![](./media/app-service-logic-connector-office365/1_New_Logic_App.png)
2. In the ‘Create logic app’ page, provide the required details such as name, app service plan and location:  
   ![](./media/app-service-logic-connector-office365/2_Logic_App_Settings.png)
3. Click on ‘Triggers and Actions’ and the Logic App editor opens:  
   ![](./media/app-service-logic-connector-office365/3_Logic_App_Editor.png)
4. Select the Office 365 trigger from the 'API Apps in this resource group' section in the gallery to add it to the flow:  
   ![](./media/app-service-logic-connector-office365/4_Select_Office365_Gallery.png)
5. Connecting to Office 365 requires you to authorize the Logic App to be able to access your account. Click on ‘Authorize’ to provide Office 365 login credentials:  
   ![](./media/app-service-logic-connector-office365/5_Office365_Authorize.png)
6. You are redirected to Office 365 sign in page and you can authenticate with your Office 365 account credentials:  
   ![](./media/app-service-logic-connector-office365/6_Office365_Login.png)  
   ![](./media/app-service-logic-connector-office365/7_Office365_User_Consent.png)
7. Once the authorization is complete, Office 365 triggers are displayed:  
   ![](./media/app-service-logic-connector-office365/8_Office365_Trigger.png)
8. Select ‘New Email’ trigger and the input parameters are displayed.
9. Change the trigger frequency to 'Minutes' and click ✓:  
   ![](./media/app-service-logic-connector-office365/9_Office365_Trigger_Settings.png)
10. The Office 365 'New Email' trigger is configured and you can see the output parameters also displayed:  
    ![](./media/app-service-logic-connector-office365/10_Office365_Trigger_Configured.png)
11. Select ‘Office 365 Connector’ from the ‘Recently Used’ section in the gallery and a new 'Office 365' action gets added.
12. Select ‘Send Event’ from the list of actions and the input parameters of ‘Send Event’ action are displayed:  
    ![](./media/app-service-logic-connector-office365/11_Office365_Actions_List.png)
13. Specify the event details and click ✓:  
    ![](./media/app-service-logic-connector-office365/12_Office365_Create_Event_Inputs.png)
14. Select ‘Office 365 Connector’ from the ‘Recently Used’ section in the gallery and a new 'Office 365' action gets added.
15. Select ‘Add Contact’ from the list of actions and the input parameters of ‘Add Contact’ action are displayed:  
    ![](./media/app-service-logic-connector-office365/13_Office365_Add_Contact_Inputs.png)
16. Click on '+' next to 'Email Address' field and select the 'From' output field value from the trigger:  
    ![](./media/app-service-logic-connector-office365/14_Office365_Add_Contact_Email_FromTrigger.png)
17. Click on ✓ and the action configuration is complete:  
    ![](./media/app-service-logic-connector-office365/15_Office365_Add_Contacts_Configured.png)
18. Select ‘Office 365 Connector’ from the ‘Recently Used’ section in the gallery and a new 'Office 365' action gets added.
19. Select ‘Send Email’ from the list of actions and the input parameters of ‘Send Email’ action are displayed:  
    ![](./media/app-service-logic-connector-office365/19_Office365_Send_Inputs.png)
20. Provide the details required to send the email. You can construct a message by typing something like below. Once the 'Send Email' action is configured, click on ✓:
    
     Body - @concat('You got a new sales enquiry from',triggers().output.body.From)
    
    ![](./media/app-service-logic-connector-office365/20_Office365_Send_Configured.png)
21. Select ‘Office 365 Connector’ from the ‘Recently Used’ section in the gallery and a new 'Office 365' action gets added.
22. Select ‘Reply To’ from the list of actions and the input parameters of ‘Reply To’ action are displayed:  
    ![](./media/app-service-logic-connector-office365/16_Office365_Reply_To_Inputs.png)
23. Click '+' next to 'From' field and select the value from trigger's output message id and click ✓:  
    ![](./media/app-service-logic-connector-office365/17_Office365_Reply_To_MessageId.png)
24. Click on OK on Logic app editor screen and then click 'Create'. It will take approximately 30 seconds for the creation to complete.
25. Send an email to the account you configured your trigger with and you should see an email in your personal mail account, calendar event and contact in your office mail account. Also, you should get a reply back acknowledging that the sales enquiry will be responded shortly.

## Do more with your Connector
Now that the connector is created, you can add it to a business workflow using a Logic App. See [What are Logic Apps?](app-service-logic-what-are-logic-apps.md).

> [!NOTE]
> If you want to get started with Azure Logic Apps before signing up for an Azure account, go to [Try Logic App](https://tryappservice.azure.com/?appservice=logic), where you can immediately create a short-lived starter logic app in App Service. No credit cards required; no commitments.
> 
> 

View the Swagger REST API reference at [Connectors and API Apps Reference](http://go.microsoft.com/fwlink/p/?LinkId=529766).

You can also review performance statistics and control security to the connector. See [Manage and Monitor your built-in API Apps and Connectors](app-service-logic-monitor-your-connectors.md).

<!--Image references-->
[1]: ./media/app-service-logic-connector-office365/1_New_Logic_App.png
[2]: ./media/app-service-logic-connector-office365/2_Logic_App_Settings.png
[3]: ./media/app-service-logic-connector-office365/3_Logic_App_Editor.png
[4]: ./media/app-service-logic-connector-office365/4_Select_Office365_Gallery.png
[5]: ./media/app-service-logic-connector-office365/5_Office365_Authorize.png
[6]: ./media/app-service-logic-connector-office365/6_Office365_Login.png
[7]: ./media/app-service-logic-connector-office365/7_Office365_User_Consent.png
[8]: ./media/app-service-logic-connector-office365/8_Office365_Trigger.png
[9]: ./media/app-service-logic-connector-office365/9_Office365_Trigger_Settings.png
[10]: ./media/app-service-logic-connector-office365/10_Office365_Trigger_Configured.png
[11]: ./media/app-service-logic-connector-office365/11_Office365_Actions_List.png
[12]: ./media/app-service-logic-connector-office365/12_Office365_Create_Event_Inputs.png
[13]: ./media/app-service-logic-connector-office365/13_Office365_Add_Contact_Inputs.png
[14]: ./media/app-service-logic-connector-office365/14_Office365_Add_Contact_Email_FromTrigger.png
[15]: ./media/app-service-logic-connector-office365/15_Office365_Add_Contacts_Configured.png
[16]: ./media/app-service-logic-connector-office365/16_Office365_Reply_To_Inputs.png
[17]: ./media/app-service-logic-connector-office365/17_Office365_Reply_To_MessageId.png
[18]: ./media/app-service-logic-connector-office365/18_Office365_Reply_To_Configured.png
[19]: ./media/app-service-logic-connector-office365/19_Office365_Send_Inputs.png
[20]: ./media/app-service-logic-connector-office365/20_Office365_Send_Configured.png
[21]: ./media/app-service-logic-connector-office365/21-create-new-o365-api-app.png
