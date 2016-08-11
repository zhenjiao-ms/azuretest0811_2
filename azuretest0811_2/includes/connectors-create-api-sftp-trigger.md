Let's add a trigger.

1. Enter *sftp* in the search box on the logic apps designer then select the **SFTP - When a file is added or modified**  trigger   
   ![SFTP trigger image 1](./media/connectors-create-api-sftp/trigger-1.png)  
2. The **When a file is added or modified** control opens up  
   ![SFTP trigger image 2](./media/connectors-create-api-sftp/trigger-2.png)  
3. Select the **...** located on the right side of the control. This opens the folder picker control  
   ![SFTP trigger image 3](./media/connectors-create-api-sftp/action-1.png)  
4. Select the **SFTP** to select the root folder as the folder to monitor for new or modified files. Notice the root folder is now displayed in the **Folder** control.  
   ![SFTP trigger image 4](./media/connectors-create-api-sftp/action-2.png)   

At this point, your logic app has been configured with a trigger that will begin a run of the other triggers and actions in the workflow when a file is either modified or created in the specific SFTP folder. 

> [!NOTE]
> For a logic app to be functional, it must contain at least one trigger and one action. Follow the steps in the next section to add an action.  
> 
> 

