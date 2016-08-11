---
title: Manage a SQL Database with SSMS | Microsoft Azure
description: Learn how to use SQL Server Management Studio to manage SQL Database servers and databases.
services: sql-database
documentationcenter: .net
author: stevestein
manager: jhubbard
editor: tysonn

ms.service: sql-database
ms.workload: data-management
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/09/2016
ms.author: sstein

---
# Managing Azure SQL Database using SQL Server Management Studio
> [!div class="op_single_selector"]
> * [Azure Portal](sql-database-manage-portal.md)
> * [SSMS](sql-database-manage-azure-ssms.md)
> * [PowerShell](sql-database-command-line-tools.md)
> 
> 

You can use SQL Server Management Studio (SSMS) to administer Azure SQL Database logical servers and databases. This topic walks you through common tasks with SSMS. You should already have a logical server and database created in Azure SQL Database before you begin. See [Create your first Azure SQL Database](sql-database-get-started.md) and the article on how to [Connect and Query using SSMS](sql-database-connect-query-ssms.md) for information about how to connect and then run a simple SELECT query.

It's recommended that you use the latest version of SSMS whenever you work with Azure SQL Database. 

> [!IMPORTANT]
> You must use the latest version of SQL Server Management Studio (SSMS) to remain synchronized with updates to Microsoft Azure and SQL Database. An older version of SSMS will not work successfully with SQL Database so visit [Download SQL Server Management Studio](https://msdn.microsoft.com/library/mt238290.aspx) to get it.
> 
> 

## Create and manage Azure SQL databases
While connected to the **master** database, you can create new
databases on the server and modify or drop existing databases. The steps
below describe how to accomplish several common database management
tasks through Management Studio. To perform these tasks, make sure you are connected to the
**master** database with the server-level principal login that you
created when you set up your server.

To open a query window in Management Studio, open the Databases folder, expand the **System Databases** folder, right-click on **master**, and then click **New Query**.

* Use the **CREATE DATABASE** statement to create a new database. For
  more information, see [CREATE DATABASE (SQL Database)](https://msdn.microsoft.com/library/dn268335.aspx). The statement below creates a new database named **myTestDB** and specifies that it is a Standard S0 Edition database with a default maximum size of 250GB.
  
      CREATE DATABASE myTestDB
      (EDITION='Standard',
       SERVICE_OBJECTIVE='S0');

Click **Execute** to run the query.

* Use the **ALTER DATABASE** statement to modify an existing database,
  for example if you want to change the name and edition
  of the database. For more information, see [ALTER DATABASE (SQL Database)](https://msdn.microsoft.com/library/ms174269.aspx). The
  statement below modifies the database you created in the previous
  step to change edition to Standard S1.
  
      ALTER DATABASE myTestDB
      MODIFY
      (SERVICE_OBJECTIVE='S1');
* Use **the DROP DATABASE** Statement to delete an existing database.
  For more information, see [DROP DATABASE (SQL Database)](https://msdn.microsoft.com/library/ms178613.aspx). The statement below deletes the **myTestDB** database, but don't drop it now because you will use it create logins in the next step.
  
      DROP DATABASE myTestBase;
* The master database has the **sys.databases** view that you can use
  to view details about all databases. To view all existing databases,
  execute the following statement:
  
      SELECT * FROM sys.databases;
* In SQL Database, the **USE** statement is not supported for switching
  between databases. Instead, you need to establish a connection
  directly to the target database.

> [!NOTE]
> Many of the Transact-SQL statements that create or modify a database must be run within their own batch and cannot be grouped with other Transact-SQL statements. For more information, see the statement-specific information available from the links listed above.
> 
> 

## Create and manage logins
The **master** database keeps track of logins and which logins have
permission to create databases or other logins. Manage logins by
connecting to the **master** database with the server-level principal
login that you created when you set up your server. You can use the
**CREATE LOGIN**, **ALTER LOGIN**, or **DROP LOGIN** statements to
execute queries against the master database that will manage logins
across the entire server. For more information, see [Managing Databases and Logins in SQL Database](http://msdn.microsoft.com/library/azure/ee336235.aspx). 

* Use the **CREATE LOGIN** statement to create a new server-level
  login. For more information, see [CREATE LOGIN (SQL Database)](https://msdn.microsoft.com/library/ms189751.aspx). The statement below creates a new login
  called **login1**. Replace **password1** with the password of your
  choice.
  
      CREATE LOGIN login1 WITH password='password1';
* Use the **CREATE USER** statement to grant database-level
  permissions. All logins must be created in the **master** database,
  but for a login to connect to a different database, you
  must grant it database-level permissions using the **CREATE USER**
  statement on that database. For more information, see [CREATE USER (SQL Database)](https://msdn.microsoft.com/library/ms173463.aspx). 
* To give login1
  permissions to a database called **myTestDB**, complete the following
  steps:
  
  1. To refresh Object Explorer to view the **myTestDB** database that you just created, right-click the server name in Object Explorer and then click **Refresh**.  
     
     If you closed the connection, you can reconnect by selecting **Connect Object Explorer** on the File menu.
  2. Right-click **myTestDB** database and select **New Query**.
  3. Execute the following statement against the myTestDB database to
     create a database user named **login1User** that corresponds to
     the server-level login **login1**.
     
         CREATE USER login1User FROM LOGIN login1;
* Use the **sp\_addrolemember** stored procedure to give the user
  account the appropriate level of permissions on the database. For
  more information, see [sp_addrolemember (Transact-SQL)](http://msdn.microsoft.com/library/ms187750.aspx). The statement below gives **login1User**
  read-only permissions to the database by adding **login1User** to
  the **db\_datareader** role.
  
      exec sp_addrolemember 'db_datareader', 'login1User';    
* Use the **ALTER LOGIN** statement to modify an existing login, for
  example if you want to change the password for the login. For
  more information, see [ALTER LOGIN (SQL Database)](https://msdn.microsoft.com/library/ms189828.aspx). The **ALTER LOGIN** statement should be run against the **master** database. Switch back to the query window that is connected to that database. 
  
  The statement below modifies the **login1** login to reset the password.
  Replace **newPassword** with the password of your choice, and
  **oldPassword** with the current password for the login.
  
      ALTER LOGIN login1
      WITH PASSWORD = 'newPassword'
      OLD_PASSWORD = 'oldPassword';
* Use **the DROP LOGIN** statement to delete an existing login.
  Deleting a login at the server level also deletes any associated
  database user accounts. For more information,
  see [DROP DATABASE (SQL Database)](https://msdn.microsoft.com/library/ms178613.aspx). The **DROP LOGIN**
  statement should be run against the **master** database. The
  statement below deletes the **login1** login.
  
      DROP LOGIN login1;
* The master database has the **sys.sql\_logins** view that you can
  use to view logins. To view all existing logins, execute the
  following statement:
  
      SELECT * FROM sys.sql_logins;

## Monitor SQL Database using Dynamic Management Views</h2>
SQL Database supports several dynamic management views that you
can use to monitor an individual database. Below are a few examples of
the type of monitor data you can retrieve through these views. For
complete details and more usage examples, see [Monitoring SQL Database using Dynamic Management Views](https://msdn.microsoft.com/library/azure/ff394114.aspx).

* Querying a dynamic management view requires **VIEW DATABASE STATE**
  permissions. To grant the **VIEW DATABASE STATE** permission to a
  specific database user, connect to the database you want to manage
  with your server-level principle login and execute the following
  statement against the database:
  
      GRANT VIEW DATABASE STATE TO login1User;
* Calculate database size using the **sys.dm\_db\_partition\_stats**
  view. The **sys.dm\_db\_partition\_stats** view returns page and
  row-count information for every partition in the database, which you
  can use to calculate the database size. The following query returns
  the size of your database in megabytes:
  
      SELECT SUM(reserved_page_count)*8.0/1024
      FROM sys.dm_db_partition_stats;   
* Use the **sys.dm\_exec\_connections** and **sys.dm\_exec\_sessions**
  views to retrieve information about current user connections and
  internal tasks associated with the database. The following query
  returns information about the current connection:
  
      SELECT
          e.connection_id,
          s.session_id,
          s.login_name,
          s.last_request_end_time,
          s.cpu_time
      FROM
          sys.dm_exec_sessions s
          INNER JOIN sys.dm_exec_connections e
            ON s.session_id = e.session_id;
* Use the **sys.dm\_exec\_query\_stats** view to retrieve aggregate
  performance statistics for cached query plans. The following query
  returns information about the top five queries ranked by average CPU
  time.
  
      SELECT TOP 5 query_stats.query_hash AS "Query Hash",
          SUM(query_stats.total_worker_time), SUM(query_stats.execution_count) AS "Avg CPU Time",
          MIN(query_stats.statement_text) AS "Statement Text"
      FROM
          (SELECT QS.*,
          SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,
          ((CASE statement_end_offset
              WHEN -1 THEN DATALENGTH(ST.text)
              ELSE QS.statement_end_offset END
                  - QS.statement_start_offset)/2) + 1) AS statement_text
           FROM sys.dm_exec_query_stats AS QS
           CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) as ST) as query_stats
      GROUP BY query_stats.query_hash
      ORDER BY 2 DESC;

