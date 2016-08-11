---
title: Data types for tables in SQL Data Warehouse | Microsoft Azure
description: Getting started with data types for Azure SQL Data Warehouse tables.
services: sql-data-warehouse
documentationcenter: NA
author: jrowlandjones
manager: barbkess
editor: ''

ms.service: sql-data-warehouse
ms.devlang: NA
ms.topic: article
ms.tgt_pltfrm: NA
ms.workload: data-services
ms.date: 06/29/2016
ms.author: jrj;barbkess;sonyama

---
# Data types for tables in SQL Data Warehouse
> [!div class="op_single_selector"]
> * [Overview](sql-data-warehouse-tables-overview.md)
> * [Data Types](sql-data-warehouse-tables-data-types.md)
> * [Distribute](sql-data-warehouse-tables-distribute.md)
> * [Index](sql-data-warehouse-tables-index.md)
> * [Partition](sql-data-warehouse-tables-partition.md)
> * [Statistics](sql-data-warehouse-tables-statistics.md)
> * [Temporary](sql-data-warehouse-tables-temporary.md)
> 
> 

SQL Data Warehouse supports the most commonly used data types.  Below is a list of the data types supported by SQL Data Warehouse.  For additional details on data type support, see [create table](https://msdn.microsoft.com/library/mt203953.aspx).

| **Supported Data Types** |  |  |
| --- | --- | --- |
|  | | |

[bigint](https://msdn.microsoft.com/library/ms187745.aspx)|[decimal](https://msdn.microsoft.com/library/ms187746.aspx)|[smallint](https://msdn.microsoft.com/library/ms187745.aspx)|
[binary](https://msdn.microsoft.com/library/ms188362.aspx)|[float](https://msdn.microsoft.com/library/ms173773.aspx)|[smallmoney](https://msdn.microsoft.com/library/ms179882.aspx)|
[bit](https://msdn.microsoft.com/library/ms177603.aspx)|[int](https://msdn.microsoft.com/library/ms187745.aspx)|[sysname](https://msdn.microsoft.com/library/ms186939.aspx)|
[char](https://msdn.microsoft.com/library/ms176089.aspx)|[money](https://msdn.microsoft.com/library/ms179882.aspx)|[time](https://msdn.microsoft.com/library/bb677243.aspx)|
[date](https://msdn.microsoft.com/library/bb630352.aspx)|[nchar](https://msdn.microsoft.com/library/ms186939.aspx)|[tinyint](https://msdn.microsoft.com/library/ms187745.aspx)|
[datetime](https://msdn.microsoft.com/library/ms187819.aspx)|[nvarchar](https://msdn.microsoft.com/library/ms186939.aspx)|[uniqueidentifier](https://msdn.microsoft.com/library/ms187942.aspx)|
[datetime2](https://msdn.microsoft.com/library/bb677335.aspx)|[real](https://msdn.microsoft.com/library/ms173773.aspx)|[varbinary](https://msdn.microsoft.com/library/ms188362.aspx)|
[datetimeoffset](https://msdn.microsoft.com/library/bb630289.aspx)|[smalldatetime](https://msdn.microsoft.com/library/ms182418.aspx)|[varchar](https://msdn.microsoft.com/library/ms186939.aspx)|

## Data type best practices
 When defining your column types, using the smallest data type which will support your data will improve query performance. This is especially important for CHAR and VARCHAR columns. If the longest value in a column is 25 characters, then define your column as VARCHAR(25). Avoid defining all character columns to a large default length. In addition, define columns as VARCHAR when that is all that is needed rather than use [NVARCHAR](https://msdn.microsoft.com/library/ms186939.aspx).  Use NVARCHAR(4000) or VARCHAR(8000) when possible instead of NVARCHAR(MAX) or VARCHAR(MAX).

## Polybase limitation
If you are using Polybase to load your tables, define your tables so that the maximum possible row size, including the full length of variable length columns, does not exceed 32,767 bytes.  While you can define a row with variable length data that can exceed this width and load rows with BCP, you will not be able to use Polybase to load this data.  Polybase support for wide rows will be added soon.

## Unsupported data types
If you are migrating your database from another SQL platform like Azure SQL Database, as you migrate, you may encounter some data types that are not supported on SQL Data Warehouse.  Below are unsupported data types as well as some alternatives you can use in place of unsupported data types.

| Data Type | Workaround |
| --- | --- |
| [geometry](https://msdn.microsoft.com/library/cc280487.aspx) |[varbinary](https://msdn.microsoft.com/library/ms188362.aspx) |
| [geography](https://msdn.microsoft.com/library/cc280766.aspx) |[varbinary](https://msdn.microsoft.com/library/ms188362.aspx) |
| [hierarchyid](https://msdn.microsoft.com/library/bb677290.aspx) |[nvarchar](https://msdn.microsoft.com/library/ms186939.aspx)(4000) |
| [image](https://msdn.microsoft.com/library/ms187993.aspx) |[varbinary](https://msdn.microsoft.com/library/ms188362.aspx) |
| [text](https://msdn.microsoft.com/library/ms187993.aspx) |[varchar](https://msdn.microsoft.com/library/ms186939.aspx) |
| [ntext](https://msdn.microsoft.com/library/ms187993.aspx) |[nvarchar](https://msdn.microsoft.com/library/ms186939.aspx) |
| [sql_variant](https://msdn.microsoft.com/library/ms173829.aspx) |Split column into several strongly typed columns. |
| [table](https://msdn.microsoft.com/library/ms175010.aspx) |Convert to temporary tables. |
| [timestamp](https://msdn.microsoft.com/library/ms182776.aspx) |Rework code to use [datetime2](https://msdn.microsoft.com/library/bb677335.aspx) and `CURRENT_TIMESTAMP` function.  Only constants are supported as defaults, therefore current_timestamp cannot be defined as a default constraint. If you need to migrate row version values from a timestamp typed column then use [BINARY](https://msdn.microsoft.com/library/ms188362.aspx)(8) or [VARBINARY](https://msdn.microsoft.com/library/ms188362.aspx)(8) for NOT NULL or NULL row version values. |
| [xml](https://msdn.microsoft.com/library/ms187339.aspx) |[varchar](https://msdn.microsoft.com/library/ms186939.aspx) |
| [user defined types](https://msdn.microsoft.com/library/ms131694.aspx) |convert back to their native types where possible |
| default values |default values support literals and constants only.  Non-deterministic expressions or functions, such as `GETDATE()` or `CURRENT_TIMESTAMP`, are not supported. |

The below SQL can be run on your current SQL database to identify columns which are not be supported by Azure SQL Data Warehouse:

```sql
SELECT  t.[name], c.[name], c.[system_type_id], c.[user_type_id], y.[is_user_defined], y.[name]
FROM sys.tables  t
JOIN sys.columns c on t.[object_id]    = c.[object_id]
JOIN sys.types   y on c.[user_type_id] = y.[user_type_id]
WHERE y.[name] IN ('geography','geometry','hierarchyid','image','text','ntext','sql_variant','timestamp','xml')
 AND  y.[is_user_defined] = 1;
```

## Next steps
To learn more, see the articles on [Table Overview](sql-data-warehouse-tables-overview.md), [Distributing a Table](sql-data-warehouse-tables-distribute.md), [Indexing a Table](sql-data-warehouse-tables-index.md),  [Partitioning a Table](sql-data-warehouse-tables-partition.md), [Maintaining Table Statistics](sql-data-warehouse-tables-statistics.md) and [Temporary Tables](sql-data-warehouse-tables-temporary.md).  For more about best practices, see [SQL Data Warehouse Best Practices](sql-data-warehouse-best-practices.md).

<!--Image references-->

<!--Article references-->
[Overview]: ./sql-data-warehouse-tables-overview.md
[Data Types]: ./sql-data-warehouse-tables-data-types.md
[Distribute]: ./sql-data-warehouse-tables-distribute.md
[Index]: ./sql-data-warehouse-tables-index.md
[Partition]: ./sql-data-warehouse-tables-partition.md
[Statistics]: ./sql-data-warehouse-tables-statistics.md
[Temporary]: ./sql-data-warehouse-tables-temporary.md
[SQL Data Warehouse Best Practices]: ./sql-data-warehouse-best-practices.md

<!--MSDN references-->

<!--Other Web references-->
[create table]: https://msdn.microsoft.com/library/mt203953.aspx
[bigint]: https://msdn.microsoft.com/library/ms187745.aspx
[binary]: https://msdn.microsoft.com/library/ms188362.aspx
[bit]: https://msdn.microsoft.com/library/ms177603.aspx
[char]: https://msdn.microsoft.com/library/ms176089.aspx
[date]: https://msdn.microsoft.com/library/bb630352.aspx
[datetime]: https://msdn.microsoft.com/library/ms187819.aspx
[datetime2]: https://msdn.microsoft.com/library/bb677335.aspx
[datetimeoffset]: https://msdn.microsoft.com/library/bb630289.aspx
[decimal]: https://msdn.microsoft.com/library/ms187746.aspx
[float]: https://msdn.microsoft.com/library/ms173773.aspx
[geometry]: https://msdn.microsoft.com/library/cc280487.aspx
[geography]: https://msdn.microsoft.com/library/cc280766.aspx
[hierarchyid]: https://msdn.microsoft.com/library/bb677290.aspx
[int]: https://msdn.microsoft.com/library/ms187745.aspx
[money]: https://msdn.microsoft.com/library/ms179882.aspx
[nchar]: https://msdn.microsoft.com/library/ms186939.aspx
[nvarchar]: https://msdn.microsoft.com/library/ms186939.aspx
[ntext,text,image]: https://msdn.microsoft.com/library/ms187993.aspx
[real]: https://msdn.microsoft.com/library/ms173773.aspx
[smalldatetime]: https://msdn.microsoft.com/library/ms182418.aspx
[smallint]: https://msdn.microsoft.com/library/ms187745.aspx
[smallmoney]: https://msdn.microsoft.com/library/ms179882.aspx
[sql_variant]: https://msdn.microsoft.com/library/ms173829.aspx
[sysname]: https://msdn.microsoft.com/library/ms186939.aspx
[table]: https://msdn.microsoft.com/library/ms175010.aspx
[time]: https://msdn.microsoft.com/library/bb677243.aspx
[timestamp]: https://msdn.microsoft.com/library/ms182776.aspx
[tinyint]: https://msdn.microsoft.com/library/ms187745.aspx
[uniqueidentifier]: https://msdn.microsoft.com/library/ms187942.aspx
[varbinary]: https://msdn.microsoft.com/library/ms188362.aspx
[varchar]: https://msdn.microsoft.com/library/ms186939.aspx
[xml]: https://msdn.microsoft.com/library/ms187339.aspx
[user defined types]: https://msdn.microsoft.com/library/ms131694.aspx
