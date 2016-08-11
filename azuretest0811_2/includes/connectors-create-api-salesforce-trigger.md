In this walk-through, you will learn how to use the **Salesforce - When an object is created** trigger to initiate a logic app workflow when a new lead is created in your Salesforce.

> [!NOTE]
> You will get prompted to sign into your Salesforce account if you have not already created a *connection* to Salesforce.  
> 
> 

1. Enter *salesforce* in the search box on the logic apps designer then select the **Salesforce - When an object is created**  trigger.  
   ![Salesforce trigger image 1](./media/connectors-create-api-salesforce/trigger-1.png)   
2. The **When an object is created** control is displayed.  
   ![Salesforce trigger image 2](./media/connectors-create-api-salesforce/trigger-2.png)   
3. Select the **Object Type** then select *Lead* from the list of objects. In this step you are indicating that you are creating a trigger that will notify your logic app whenever a new lead is created in Salesforce.   
   ![Salesforce trigger image 3](./media/connectors-create-api-salesforce/trigger-3.png)   
4. That's it. You've created the trigger. However, you need to create at least one action in order to make this a valid logic app.    
   ![Salesforce trigger image 4](./media/connectors-create-api-salesforce/trigger-4.png)   

At this point, your logic app has been configured with a trigger that will begin a run of the other triggers and actions in the workflow when a new item is created in your Salesforce.  

