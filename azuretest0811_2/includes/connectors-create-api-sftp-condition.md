1. Select **+ New step** to add the action.  
2. Select the **Add an action** link. This opens the search box where you can search for any action you would like to take. For this example, SharePoint actions are of interest.    
   ![SFTP condition image 1](./media/connectors-create-api-sftp/condition-1.png)    
3. Select **Choose a value** on the left. 
   ![SFTP condition image 2](./media/connectors-create-api-sftp/condition-2.png)    
4. Select **File content** to indicate that you want to evaluate the file contents in the condition.      
   ![SFTP condition image 3](./media/connectors-create-api-sftp/condition-3.png)   
5. Select *contains* from the list of operators.       
   ![SFTP condition image 4](./media/connectors-create-api-sftp/condition-4.png)   
6. Select **Choose a value** on the right and enter *ExtractMeFirst*. In this example, ExtractMeFirst is a value that is expected to be in a file by persons who have access to the SFTP folder to indicate that it is an archive file that should be extracted.  
   ![SFTP condition image 5](./media/connectors-create-api-sftp/condition-5.png)   

