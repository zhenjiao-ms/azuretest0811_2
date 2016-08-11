To be able to store app data in the new mobile service, you must first create a new table in the associated SQL Database instance.

1. In the [Azure classic portal](https://manage.windowsazure.com/), click **Mobile Services**, and then click the mobile service that you just created.
2. Click the **Data** tab, then click **+Create**.
   
       This displays the **Create new table** dialog.
3. In **Table name** type *TodoItem*, then click the check button. This creates a new storage table **TodoItem** with the default permissions set. This means that anyone with the application key, which is distributed with your app, can access and change data in the table. 
   
   > [!NOTE]
   > The same table name is used in Mobile Services quickstart. However, each table is created in a schema that is specific to a given mobile service. This is to prevent data collisions when multiple mobile services use the same database.
   > 
4. Click the new **TodoItem** table and verify that there are no data rows.
5. Click the **Columns** tab. Verify that the following default columns are automatically created for you: 
   
    <table border="1" cellpadding="10">
     <tr>
     <th>Column Name</th>
     <th>Type</th>
     <th>Index</th>
     </tr>
     <tr>
     <td>id</td>
     <td>string</td>
     <td>Indexed</td>
     </tr>
     <tr>
     <td>**createdAt</td>
     <td>date</td>
     <td>Indexed</td>
     </tr>
     <tr>
     <td>**updatedAt</td>
     <td>date</td>
     <td><font color="transparent">-</font></td>
     </tr>
     <tr>
     <td>__version</td>
     <td>timestamp (MSSQL)</td>
     <td><font color="transparent">-</font></td>
     </tr>     
     </table>     
   
      This is the minimum requirement for a table in Mobile Services. 
   
   > [!NOTE]
   > When dynamic schema is enabled on your mobile service, new columns are created automatically when JSON objects are sent to the mobile service by an insert or update operation.
   > 
   > 

You are now ready to use the new mobile service as data storage for the app.

