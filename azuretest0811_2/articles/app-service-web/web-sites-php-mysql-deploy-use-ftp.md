---
title: Create a PHP-MySQL web app in Azure App Service and deploy using FTP
description: A tutorial that demonstrates how to create a PHP web app that stores data in MySQL and use FTP deployment to Azure.
services: app-service\web
documentationcenter: php
author: rmcmurray
manager: wpickett
editor: ''

ms.service: app-service-web
ms.workload: web
ms.tgt_pltfrm: na
ms.devlang: PHP
ms.topic: article
ms.date: 06/24/2016
ms.author: robmcm

---
# Create a PHP-MySQL web app in Azure App Service and deploy using FTP
This tutorial shows you how to create a PHP-MySQL web app and how to deploy it using FTP. This tutorial assumes you have [PHP](http://www.php.net/manual/en/install.php), [MySQL](http://dev.mysql.com/doc/refman/5.6/en/installing.html), a web server, and an FTP client installed on your computer. The instructions in this tutorial can be followed on any operating system, including Windows, Mac, and  Linux. Upon completing this guide, you will have a PHP/MySQL web app running in Azure.

You will learn:

* How to create a web app and a MySQL database using the Azure Portal. Because PHP is enabled in Web Apps by default, nothing special is required to run your PHP code.
* How to publish your application to Azure using FTP.

By following this tutorial, you will build a simple registration web app in PHP. The application will be hosted in a Web App. A screenshot of the completed application is below:

![Azure PHP Web Site](./media/web-sites-php-mysql-deploy-use-ftp/running_app_2.png)

> [!NOTE]
> If you want to get started with Azure App Service before signing up for an account, go to [Try App Service](http://go.microsoft.com/fwlink/?LinkId=523751), where you can immediately create a short-lived starter web app in App Service. No credit cards required, no commitments. 
> 
> 

## Create a web app and set up FTP publishing
Follow these steps to create a web app and a MySQL database:

1. Login to the [Azure Portal](https://portal.azure.com).
2. Click the **+ New** icon on the top left of the Azure Portal.
   
    ![Create New Azure Web Site](./media/web-sites-php-mysql-deploy-use-ftp/new_website2.png)
3. In the search type **Web app + MySQL** and click on **Web app + MySQL**.
   
    ![Custom Create a new Web Site](./media/web-sites-php-mysql-deploy-use-ftp/create_web_mysql.png)
4. Click **Create**. Enter a unique app service name, a valid name for the resource group and a new service plan.
   
    ![Set resource group name](./media/web-sites-php-mysql-deploy-use-ftp/set_group.png)
5. Enter values for your new database, including agreeing to the legal terms.
   
    ![Create new MySQL database](./media/web-sites-php-mysql-deploy-use-ftp/create_db.png)
6. When the web app has been created, you will see the new app service blade.
7. Click on **Settings** > **Deployment credentials**. 
   
    ![Set deployment credentials](./media/web-sites-php-mysql-deploy-use-ftp/set_credentials.png)
8. To enable FTP publishing, you must provide a user name and password. Save the credentials and make a note of the user name and password you create.
   
    ![Create publishing credentials](./media/web-sites-php-mysql-deploy-use-ftp/save_credentials.png)

## Build and test your app locally
The Registration application is a simple PHP application that allows you to register for an event by providing your name and email address. Information about previous registrants is displayed in a table. Registration information is stored in a MySQL database. The app consists of two files:

* **index.php**: Displays a form for registration and a table containing registrant information.
* **createtable.php**: Creates the MySQL table for the application. This file will only be used once.

To build and run the app locally, follow the steps below. Note that these steps assume you have PHP, MySQL, and a web server set up on your local machine, and that you have enabled the [PDO extension for MySQL](http://www.php.net/manual/en/ref.pdo-mysql.php).

1. Create a MySQL database called `registration`. You can do this from the MySQL command prompt with this command:
   
        mysql> create database registration;
2. In your web server's root directory, create a folder called `registration` and create two files in it - one called `createtable.php` and one called `index.php`.
3. Open the `createtable.php` file in a text editor or IDE and add the code below. This code will be used to create the `registration_tbl` table in the `registration` database.
   
        <?php
        // DB connection info
        $host = "localhost";
        $user = "user name";
        $pwd = "password";
        $db = "registration";
        try{
            $conn = new PDO( "mysql:host=$host;dbname=$db", $user, $pwd);
            $conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
            $sql = "CREATE TABLE registration_tbl(
                        id INT NOT NULL AUTO_INCREMENT, 
                        PRIMARY KEY(id),
                        name VARCHAR(30),
                        email VARCHAR(30),
                        date DATE)";
            $conn->query($sql);
        }
        catch(Exception $e){
            die(print_r($e));
        }
        echo "<h3>Table created.</h3>";
        ?>
   
   > [!NOTE]
   > You will need to update the values for <code>$user</code> and <code>$pwd</code> with your local MySQL user name and password.
   > 
4. Open a web browser and browse to [http://localhost/registration/createtable.php](http://localhost/tasklist/createtable.php). This will create the `registration_tbl` table in the database.
5. Open the **index.php** file in a text editor or IDE and add the basic HTML and CSS code for the page (the PHP code will be added in later steps).
   
        <html>
        <head>
        <Title>Registration Form</Title>
        <style type="text/css">
            body { background-color: #fff; border-top: solid 10px #000;
                color: #333; font-size: .85em; margin: 20; padding: 20;
                font-family: "Segoe UI", Verdana, Helvetica, Sans-Serif;
            }
            h1, h2, h3,{ color: #000; margin-bottom: 0; padding-bottom: 0; }
            h1 { font-size: 2em; }
            h2 { font-size: 1.75em; }
            h3 { font-size: 1.2em; }
            table { margin-top: 0.75em; }
            th { font-size: 1.2em; text-align: left; border: none; padding-left: 0; }
            td { padding: 0.25em 2em 0.25em 0em; border: 0 none; }
        </style>
        </head>
        <body>
        <h1>Register here!</h1>
        <p>Fill in your name and email address, then click <strong>Submit</strong> to register.</p>
        <form method="post" action="index.php" enctype="multipart/form-data" >
              Name  <input type="text" name="name" id="name"/></br>
              Email <input type="text" name="email" id="email"/></br>
              <input type="submit" name="submit" value="Submit" />
        </form>
        <?php
   
        ?>
        </body>
        </html>
6. Within the PHP tags, add PHP code for connecting to the database.
   
        // DB connection info
        $host = "localhost";
        $user = "user name";
        $pwd = "password";
        $db = "registration";
        // Connect to database.
        try {
            $conn = new PDO( "mysql:host=$host;dbname=$db", $user, $pwd);
            $conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
        }
        catch(Exception $e){
            die(var_dump($e));
        }
   
   > [!NOTE]
   > Again, you will need to update the values for <code>$user</code> and <code>$pwd</code> with your local MySQL user name and password.
   > 
7. Following the database connection code, add code for inserting registration information into the database.
   
        if(!empty($_POST)) {
        try {
            $name = $_POST['name'];
            $email = $_POST['email'];
            $date = date("Y-m-d");
            // Insert data
            $sql_insert = "INSERT INTO registration_tbl (name, email, date) 
                           VALUES (?,?,?)";
            $stmt = $conn->prepare($sql_insert);
            $stmt->bindValue(1, $name);
            $stmt->bindValue(2, $email);
            $stmt->bindValue(3, $date);
            $stmt->execute();
        }
        catch(Exception $e) {
            die(var_dump($e));
        }
        echo "<h3>Your're registered!</h3>";
        }
8. Finally, following the code above, add code for retrieving data from the database.
   
        $sql_select = "SELECT * FROM registration_tbl";
        $stmt = $conn->query($sql_select);
        $registrants = $stmt->fetchAll(); 
        if(count($registrants) > 0) {
            echo "<h2>People who are registered:</h2>";
            echo "<table>";
            echo "<tr><th>Name</th>";
            echo "<th>Email</th>";
            echo "<th>Date</th></tr>";
            foreach($registrants as $registrant) {
                echo "<tr><td>".$registrant['name']."</td>";
                echo "<td>".$registrant['email']."</td>";
                echo "<td>".$registrant['date']."</td></tr>";
            }
             echo "</table>";
        } else {
            echo "<h3>No one is currently registered.</h3>";
        }

You can now browse to [http://localhost/registration/index.php](http://localhost/tasklist/index.php) to test the app.

## Get MySQL and FTP connection information
To connect to the MySQL database that is running in Web Apps, your will need the connection information. To get MySQL connection information, follow these steps:

1. From the app service web app blade click on the resource group link:
   
    ![Select Resource Group](./media/web-sites-php-mysql-deploy-use-ftp/select_resourcegroup.png)
2. From your resource group, click the database:
   
    ![Select database](./media/web-sites-php-mysql-deploy-use-ftp/select_database.png)
3. From the database summary, select **Settings** > **Properties**.
   
    ![Select properties](./media/web-sites-php-mysql-deploy-use-ftp/select_properties.png)
4. Make note of the values for `Database`, `Host`, `User Id`, and `Password`.
   
    ![Note properties](./media/web-sites-php-mysql-deploy-use-ftp/note-properties.png)
5. From your web app, click the **Download publish profile** link at the bottom right corner of the page:
   
    ![Download publish profile](./media/web-sites-php-mysql-deploy-use-ftp/download_publish_profile_3.png)
6. Open the `.publishsettings` file in an XML editor. 
7. Find the `<publishProfile >` element with `publishMethod="FTP"` that looks similar to this:
   
        <publishProfile publishMethod="FTP" publishUrl="ftp://[mysite].azurewebsites.net/site/wwwroot" ftpPassiveMode="True" userName="[username]" userPWD="[password]" destinationAppUrl="http://[name].antdf0.antares-test.windows-int.net" 
            ...
        </publishProfile>

Make note of the `publishUrl`, `userName`, and `userPWD` attributes.

## Publish your app
After you have tested your app locally, you can publish it to your web app using FTP. However, you first need to update the database connection information in the application. Using the database connection information you obtained earlier (in the **Get MySQL and FTP connection information** section), update the following information in **both** the `createdatabase.php` and `index.php` files with the appropriate values:

    // DB connection info
    $host = "value of Data Source";
    $user = "value of User Id";
    $pwd = "value of Password";
    $db = "value of Database";

Now you are ready to publish your app using FTP.

1. Open your FTP client of choice.
2. Enter the *host name portion* from the `publishUrl` attribute you noted above into your FTP client.
3. Enter the `userName` and `userPWD` attributes you noted above unchanged into your FTP client.
4. Establish a connection.

After you have connected you will be able to upload and download files as needed. Be sure that you are uploading files to the root directory, which is `/site/wwwroot`.

After uploading both `index.php` and `createtable.php`, browse to **http://[site name].azurewebsites.net/createtable.php** to create the MySQL table for the application, then browse to **http://[site name].azurewebsites.net/index.php** to begin using the application.

## Next steps
For more information, see the [PHP Developer Center](/develop/php/).

[install-php]: http://www.php.net/manual/en/install.php
[install-mysql]: http://dev.mysql.com/doc/refman/5.6/en/installing.html
[pdo-mysql]: http://www.php.net/manual/en/ref.pdo-mysql.php
[localhost-createtable]: http://localhost/tasklist/createtable.php
[localhost-index]: http://localhost/tasklist/index.php
[running-app]: ./media/web-sites-php-mysql-deploy-use-ftp/running_app_2.png
[new-website]: ./media/web-sites-php-mysql-deploy-use-ftp/new_website2.png
[custom-create]: ./media/web-sites-php-mysql-deploy-use-ftp/create_web_mysql.png
[website-details]: ./media/web-sites-php-web-site-mysql-deploy-use-ftp/website_details.jpg
[new-mysql-db]: ./media/web-sites-php-mysql-deploy-use-ftp/create_db.png
[go-to-webapp]: ./media/web-sites-php-mysql-deploy-use-ftp/select_webapp.png
[set-deployment-credentials]: ./media/web-sites-php-mysql-deploy-use-ftp/set_credentials.png
[portal-ftp-username-password]: ./media/web-sites-php-mysql-deploy-use-ftp/save_credentials.png
[resource-group]: ./media/web-sites-php-mysql-deploy-use-ftp/set_group.png
[new-web-app]: ./media/web-sites-php-mysql-deploy-use-ftp/create_wa.png
[select-database]: ./media/web-sites-php-mysql-deploy-use-ftp/select_database.png
[select-resourcegroup]: ./media/web-sites-php-mysql-deploy-use-ftp/select_resourcegroup.png
[select-properties]: ./media/web-sites-php-mysql-deploy-use-ftp/select_properties.png
[note-properties]: ./media/web-sites-php-mysql-deploy-use-ftp/note-properties.png

[connection-string-info]: ./media/web-sites-php-web-site-mysql-deploy-use-ftp/connection_string_info.png
[management-portal]: https://portal.azure.com
[download-publish-profile]: ./media/web-sites-php-mysql-deploy-use-ftp/download_publish_profile_3.png

