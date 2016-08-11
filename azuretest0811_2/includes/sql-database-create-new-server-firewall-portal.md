
<!--
includes/sql-database-create-new-server-firewall-portal.md

Latest Freshness check:  2016-08-01 , rickbyh.

As of circa 2016-04-11, the following topics might include this include:
articles/sql-database/sql-database-get-started-tutorial.md
articles/sql-database/sql-database-configure-firewall-settings

-->
## Create a new Azure SQL server-level firewall
Use the following steps in the Azure portal to create a server-level firewall rule that allows connections from an individual IP address (your client computer) or an entire IP address range to a SQL logical server. 

1. If not currently connected, connect to the [Azure portal](http://portal.azure.com).
2. In the default blade, click **SQL Server**.
   
      ![new server firewall](./media/sql-database-create-new-server-firewall-portal/sql-database-create-new-server-firewall-portal-1.png)
3. In the SQL Server blade, click the SQL server on which to create the firewall rule. 
   
     ![new server firewall](./media/sql-database-create-new-server-firewall-portal/sql-database-create-new-server-firewall-portal-2.png)
4. Review the properties of your server.
   
     ![new server firewall](./media/sql-database-create-new-server-firewall-portal/sql-database-create-new-server-firewall-portal-3.png)
5. In the Settings blade, click **Firewall**.
   
     ![new server firewall](./media/sql-database-create-new-server-firewall-portal/sql-database-create-new-server-firewall-portal-4.png)
   
   > [!NOTE]
   > You can also access the server-level **Firewall settings** blade from toolbar of the Database blade.
   > 
6. Click **Add Client IP** to have Azure create a rule for your client's IP address.
   
      ![new server firewall](./media/sql-database-create-new-server-firewall-portal/sql-database-create-new-server-firewall-portal-5.png)
7. Optionally, click the IP address that was added to edit the firewall address to allow access to a range of IP addresses.
   
      ![new server firewall](./media/sql-database-create-new-server-firewall-portal/sql-database-create-new-server-firewall-portal-6.png)
8. Click **Save** to create the server-level firewall rule.
   
     ![new server firewall](./media/sql-database-create-new-server-firewall-portal/sql-database-create-new-server-firewall-portal-7.png)
   
   > [!IMPORTANT]
   > Your Client IP address may change from time to time, and you may not be able to access your server until you create a new firewall rule. You can check your IP address using [Bing](http://www.bing.com/search?q=my%20ip%20address), and then add a single IP address or a range of IP addresses. See [Manage firewall settings](sql-database-configure-firewall-settings.md#manage-existing-server-level-firewall-rules-through-the-azure-portal) for details.
   > 
   > 
   > 

