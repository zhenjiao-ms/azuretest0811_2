<!--
includes/sql-database-include-connection-string-20-portalshots.md

Latest Freshness check:  2015-09-02 , GeneMi.

## Connection string
-->


### Obtain the connection string from the Azure portal
Use the [Azure portal](https://portal.azure.com/) to obtain the connection string necessary for your client program to interact with Azure SQL Database:

1. Click **BROWSE** > **SQL databases**.
   
    ![Select SQL](./media/sql-database-include-connection-string-20-portalshots/connection-string-select-sql.png)
2. Enter the name of your database into the filter text box near the upper-left of the **SQL databases** blade.
   
    ![Select Database](./media/sql-database-include-connection-string-20-portalshots/connection-string-select-database.PNG)]
3. Click the row for your database.
4. After the blade appears for your database, for visual convenience you can click the standard minimize controls to collapse the blades  you used for browsing and database filtering.
5. On the blade for your database, click **Show database connection strings**.
6. If you intend to use the JDBC connection library, copy the string labeled **JDBC**.
   
    ![Copy the JDBC connection string for your database](./media/sql-database-include-connection-string-20-portalshots/connection-string-jdbc.PNG)
7. Paste the connection string information into your client program code.  You will need to replace the {your_password_here} with your real password.

For more information, see:<br/>[Connection Strings and Configuration Files](https://msdn.microsoft.com/library/ms378428.aspx).

<!-- Image references. -->

[1-select-sql]: ./media/sql-database-include-connection-string-20-portalshots/connection-string-select-sql.png


[2-select-database]: ./media/sql-database-include-connection-string-20-portalshots/connection-string-select-database.PNG

[3-get-connection-string]: ./media/sql-database-include-connection-string-20-portalshots/connection-string-jdbc.PNG


<!--
These three includes/ files are a sequenced set, but you can pick and choose:

includes/sql-database-include-connection-string-20-portalshots.md
includes/sql-database-include-connection-string-30-compare.md
includes/sql-database-include-connection-string-40-config.md
-->
