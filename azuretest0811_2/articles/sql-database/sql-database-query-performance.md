---
title: Azure SQL Database Query Performance Insight
description: Query performance monitoring identifies the most CPU-consuming queries for an Azure SQL Database.
services: sql-database
documentationcenter: ''
author: stevestein
manager: jhubbard
editor: monicar

ms.service: sql-database
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: data-management
ms.date: 05/05/2016
ms.author: sstein

---
# Azure SQL Database Query Performance Insight
Managing and tuning the performance of relational databases is a challenging task that requires significant expertise and time investment. Query Performance Insight allows you to spend less time troubleshooting database performance by providing the following:​

* Deeper insight into your databases resource (DTU) consumption. 
* The top CPU consuming queries, which can potentially be tuned for improved performance. 
* The ability to drill down into the details of a query.
  ​

## Prerequisites
* Query Performance Insight is only available with Azure SQL Database V12.
* Query Performance Insight requires that [Query Store](https://msdn.microsoft.com/library/dn817826.aspx) is running on your database. The portal will prompt you to turn Query Store on if it is not already running.

## Permissions
The following [role-based access control](../active-directory/role-based-access-control-configure.md) permissions are required to use Query Performance Insight: 

* **Reader**, **Owner**, **Contributor**, **SQL DB Contributor** or **SQL Server Contributor** permissions are required to view the top resource consuming queries and charts. 
* **Owner**, **Contributor**, **SQL DB Contributor** or **SQL Server Contributor** permissions are required to view query text.

## Using Query Performance Insight
Query Performance Insight is easy to use:

* Review the list of top resource-consuming queries. 
* Select an individual query to view its details.
* Open [SQL Database Advisor](sql-database-advisor.md) and check if any recommendations are available.
* Zoom in for detailed information.
  
    ![performance dashboard](./media/sql-database-query-performance/performance.png)

> [!NOTE]
> A couple hours of data needs to be captured by Query Store for SQL Database to provide query performance insight. If the database has no activity or Query Store was not active during a certain time period, the charts will be empty when displaying that time period. You may enable Query Store at any time if it is not running.   
> 
> 

## Review top CPU consuming queries
In the [portal](http://portal.azure.com) do the following:

1. Browse to a SQL database and click **All settings** > **Performance** > **Queries**. 
   
    ![Query Performance Insight](./media/sql-database-query-performance/tile.png)
   
    The top queries view opens and the top CPU consuming queries are listed.
2. Click around the chart for details.<br>The top line shows overall DTU% for the database, while the bars show CPU% consumed by the selected queries during the selected interval (for example, if **Past week** is selected each bar represents 1 day).
   
    ![top queries](./media/sql-database-query-performance/top-queries.png)
   
    The bottom grid represents aggregated information for the visible queries.
   
   * Query ID – unique identifier of query inside database. 
   * CPU per query during observable interval (depends on aggregation function).
   * Duration per query (depends on aggregation function).
   * Total number of executions for a particular query.

    Select or clear individual queries to include or exclude them from the chart. 


1. If your data becomes stale, click the **Refresh** button.
2. Optionally, click **Settings** to customize how CPU consumption data is displayed, or to show a different time period.
   
    ![settings](./media/sql-database-query-performance/settings.png)

## Viewing individual query details
To view query details:

1. Click any query in the list of top queries.
   
    ![details](./media/sql-database-query-performance/details.png)
2. The details view opens and the queries CPU consumption is broken down over time.
3. Click around the chart for details.<br>The top line is overall DTU%, and the bars are CPU% consumed by the selected query.
4. Review the data to see detailed metrics including duration, number of executions, and resource utilization percentage for each interval the query was running.
   
    ![query details](./media/sql-database-query-performance/query-details.png)
5. Optionally, click **Settings** to customize how CPU consumption data is displayed, or to show a different time period.

## Optimizing the Query Store configuration for Query Performance Insight
During your use of Query Performance Insight, you might encounter the following Query Store messages:

* "Query store has reached its capacity and not collecting new data."
* "Query Store for this database is in read-only mode and not collecting performance insights data."
* "Query Store parameters are not optimally set for Query Performance Insight."

These messages usually appear when Query Store is not able to collect new data. To fix this you have couple of options:

* Change the Retention and Capture policy of Query Store
* Increase size of Query Store 
* Clear Query Store

### Recommended retention and capture policy
There are two types of retention policies:

* Size based – if set to AUTO it will clean data automatically when near max size is reached.
* Time based - by default we will set it to 30 days, which means, if Query Store will run out of space, it will delete query information older than 30 days. 

Capture policy could be set to:

* **All** – Captures all queries. This is the default option.
* **Auto** – Infrequent queries and queries with insignificant compile and execution duration are ignored. Thresholds for execution count, compile and runtime duration are internally determined.
* **None** – Query Store stops capturing new queries.

We recommend to set all policies to AUTO and clean policy to 30 days:

    ALTER DATABASE [YourDB] 
    SET QUERY_STORE (SIZE_BASED_CLEANUP_MODE = AUTO);

    ALTER DATABASE [YourDB] 
    SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30));

    ALTER DATABASE [YourDB] 
    SET QUERY_STORE (QUERY_CAPTURE_MODE = AUTO);

Increase size of Query Store. This could be performed by connecting to a database and issuing following query:

    ALTER DATABASE [YourDB]
    SET QUERY_STORE (MAX_STORAGE_SIZE_MB = 1024);

Clear Query Store. Be aware that this will delete all current information in the Query Store:

    ALTER DATABASE [YourDB] SET QUERY_STORE CLEAR;


## Summary
Query Performance Insight helps you understand the impact of your query workload and how it relates to database resource consumption. With this feature, you will learn about the top consuming queries, and easily identify the ones to fix before they become a problem.

## Next steps
For additional recommendations for improving the performance of your SQL database click [SQL Database Advisor](sql-database-advisor.md) on the **Query Performance Insight** blade.

![Performance Advisor](./media/sql-database-query-performance/ia.png)

<!--Image references-->
[1]: ./media/sql-database-query-performance/tile.png
[2]: ./media/sql-database-query-performance/top-queries.png
[3]: ./media/sql-database-query-performance/query-details.png



