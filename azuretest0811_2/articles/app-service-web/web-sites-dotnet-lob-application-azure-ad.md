---
title: Create a .NET MVC web app in Azure App Service with Azure Active Directory authentication
description: Learn how to create an ASP.NET MVC line-of-business application in Azure App Service that authenticates with Azure Active Directory
services: app-service\web, active-directory
documentationcenter: .net
author: cephalin
manager: wpickett
editor: ''

ms.service: app-service-web
ms.devlang: dotnet
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: web
ms.date: 02/29/2016
ms.author: cephalin

---
# Create a .NET MVC web app in Azure App Service with Azure Active Directory authentication
In this article, you will learn how to create an ASP.NET MVC line-of-business application in [Azure App Service Web Apps](http://go.microsoft.com/fwlink/?LinkId=529714) using [Azure Active Directory](/services/active-directory/) as the identity provider. You will also learn how to use the [Azure Active Directory Graph Client Library](http://blogs.msdn.com/b/aadgraphteam/archive/2014/06/02/azure-active-directory-graph-client-library-1-0-publish.aspx) to query directory data in the application.

The Azure Active Directory tenant that you use can be an Azure-only directory, or it can be directory-synced with your on-premise Active Directory (AD) to create a single sign-on experience for workers that are on-premise or remote.

> [!NOTE]
> For Azure App Service Web Apps you can configure authentication against an Azure Active Directory tenant with a few clicks of a button. For more information, see [Use Active Directory for authentication in Azure App Service](web-sites-authentication-authorization.md).
> 
> 

<a name="bkmk_build"></a>

## What you will build
You will build a simple line-of-business Create-Read-Update-Delete (CRUD) application in App Service Web Apps that tracks work items with the following features:

* Authenticates users against Azure Active Directory
* Implements sign-in and sign-out functionality
* Uses `[Authorize]` to authorize users for different CRUD actions
* Queries Azure Active Directory data using [Azure Active Directory Graph API](http://msdn.microsoft.com/library/azure/hh974476.aspx)
* Uses [Microsoft.Owin](http://www.asp.net/aspnet/overview/owin-and-katana/an-overview-of-project-katana) (instead of Windows Identity Foundation, i.e. WIF), which is the future of ASP.NET and much simpler to set up for authentication and authorization than WIF

<a name="bkmk_need"></a>

## What you will need
[!INCLUDE [free-trial-note](../../includes/free-trial-note.md)]

> [!NOTE]
> If you want to get started with Azure App Service before signing up for an Azure account, go to [Try App Service](http://go.microsoft.com/fwlink/?LinkId=523751), where you can immediately create a short-lived starter web app in App Service. No credit cards required; no commitments.
> 
> 

You need the following to complete this tutorial:

* An Azure Active Directory tenant with users in various groups
* Permissions to create applications on the Azure Active Directory tenant
* Visual Studio 2013 or later
* [Azure SDK 2.8.1](http://go.microsoft.com/fwlink/p/?linkid=323510&clcid=0x409) or later

<a name="bkmk_sample"></a>

## Use sample application for line-of-business template
The sample application in this tutorial, [WebApp-RoleClaims-DotNet](https://github.com/Azure-Samples/active-directory-dotnet-webapp-roleclaims), is created by the Azure Active Directory team and can be used as a template to create new line-of-business applications with ease. It has the following built-in features:

* Uses [OpenID Connect](http://openid.net/connect/) to authenticate with Azure Active Directory
* Contains a sample `TaskTracker` controller that demonstrates how you can authorize different roles for specific actions in an application, including the standard usage of `[Authorize]`. 
* Is a multitenant application with pre-defined roles that you can immediately assign your users and groups. 

<a name="bkmk_run" />

## Run the sample application
1. Clone or download the sample solution at [WebApp-RoleClaims-DotNet](https://github.com/Azure-Samples/active-directory-dotnet-webapp-roleclaims) to your local directory.
2. Follow the instructions at [How To Run The Sample as a Single Tenant App](https://github.com/Azure-Samples/active-directory-dotnet-webapp-roleclaims#how-to-run-the-sample-as-a-single-tenant-app) to set up the Azure Active Directory application and project.
   Be sure to follow all the instructions to convert the application from multi-tenant to single-tenant.
3. In the [Azure classic portal](https://manage.windowsazure.com) view for your Azure Active Directory application you just created, click the **USERS** tab. Then, assign the desired users to the desired roles.
   
   > [!NOTE]
   > If you want to assign roles to groups in addition to users, you must upgrade your Azure Active Directory tenant to [Azure Active Directory Premium](/pricing/details/active-directory/). In your application's classic portal UI, if you see the **USERS** tab instead of the **USERS AND GROUPS tab, you can try Azure Active Directory Premium by going to your Azure Active Directory tenant's **LICENCES** tab. 
   > 
4. Once you're finished configuring the application, type `F5` in Visual Studio to run the ASP.NET application.
5. Once the application loads, click **Sign In** and sign in with a user that has the Admin role in the Azure classic portal. 
6. If you configured the Azure Active Directory application properly and set the corresponding settings in Web.config, you should be redirected to the log in. Simply log in with the account you used to create the Azure Active Directory application in the Azure classic portal, since it's the Azure Active Directory application's default owner. 

<a name="bkmk_deploy"></a>

## Deploy the sample application to App Service Web Apps
Here, you will publish the application to a web app in Azure App Service. There are already instructions at [README.md](https://github.com/Azure-Samples/active-directory-dotnet-webapp-roleclaims/blob/master/README.md) for deploying to App Service Web Apps, but those steps also annul the configuration for your local debug environment. I'll show you how to deploy while preserving the debug configuration.

1. Right-click your project and select **Publish**.
   
    ![](./media/web-sites-dotnet-lob-application-azure-ad/publish-app.png)
2. Select **Microsoft Azure Web Apps**.
3. If you haven't signed in to Azure, click **Add an account** and use the Microsoft account for your Azure subscription to sign in.
4. Once signed in, click **New** to create a new web app in Azure.
5. In **Hosting**, Fill in all required fields. 
   
    ![](./media/web-sites-dotnet-lob-application-azure-ad/4-create-website.png)
6. You will need a database connection for this application to store role mappings, cached tokens, and any application data. In **Create App Service** dialog, click **Services**.  Next to the **SQL Database** click the plus sign to add a new database.
   
    ![](./media/web-sites-dotnet-lob-application-azure-ad/4-create-database.png)
7. In the **Configure SQL Database** dialog, select or create a server, set a name and click **OK**.
   
     ![](./media/web-sites-dotnet-lob-application-azure-ad/4-config-database.png)
8. Click **Create**. Once the web app is created, the **Publish Web** dialog is opened.
9. In **Destination URL**, change **http** to **https**. Copy the entire URL to a text editor. You will use it later. Then, click **Next**.
   
    ![](./media/web-sites-dotnet-lob-application-azure-ad/5-change-to-https.png)
10. Clear the **Enable Organizational Authentication** checkbox.
    
     ![](./media/web-sites-dotnet-lob-application-azure-ad/6-enable-code-first-migrations.png)
11. Expand **RoleClaimContext** and select **Execute Code First Migrations (runs on application start)**. [Code First Migrations](https://msdn.microsoft.com/data/jj591621.aspx) helps update your app's database schema in Azure when you define additional Code First data models later.
12. Instead of clicking **Publish** to go through with the web publish, click **Close**. Click **Yes** to save the changes to the publishing profile.
13. In the [Azure classic portal](https://manage.windowsazure.com), go to your Azure Active Directory tenant and click the **Applications** tab.
14. Click **Add** at the bottom of the page.
15. Click **Add an application my organization is developing**.
16. Select **Web Application And/Or Web API**.
17. Give the application a name and click **Next**.
18. In App Properties, set **Sign-On URL** to the web app URL that you saved earler (e.g. `https://<site-name>.azurewebsites.net/`), and the **APP ID URI** to `https://<aad-tenanet-name>/<app-name>`. Then, click **Complete**.
    
     ![](./media/web-sites-dotnet-lob-application-azure-ad/7-app-properties.png)
19. Once the application is created, update the application manifest the same way the you did earlier from the instructions at [Define your Application Roles](https://github.com/Azure-Samples/active-directory-dotnet-webapp-roleclaims#step-2-define-your-application-roles).
20. In the [Azure classic portal](https://manage.windowsazure.com) view for your Azure Active Directory application you just created, click the **USERS** tab. Then, assign the desired users to the desired roles.
21. Click the **CONFIGURE** tab.
22. Under **Keys**, create a new key by selecting **1 year** in the dropdown.
23. Under **Permissions to other applications**, for the **Azure Active Directory** entry, select **Sign-in and read user profile** and **Read directory data** in the **Delegated Permissions** dropdown.
    
    > [!NOTE]
    > The exact permissions you need here depends on the desired functionality of your application. Some permissions require the **Global Administrator** role to set, but the permissions required by this tutorial only requires the **User** role.
    > 
24. Click **Save**.  
25. Before you navigate away from the saved configuration page, copy the following information into a text editor.
    
    * Client ID
    * Key (if you navigate away from the page, you will not be able to see the key again)
26. In Visual Studio, open **Web.Release.config** in your project. Insert the following XML into the `<configuration>` tag, and replace the value of each key with the information that you saved for your new Azure Active Directory application.  
    
    <pre class="prettyprint">
    &lt;appSettings&gt;
    &lt;add key="ida:ClientId" value="<mark>[e.g. 82692da5-a86f-44c9-9d53-2f88d52b478b]</mark>" xdt:Transform="SetAttributes" xdt:Locator="Match(key)" /&gt;
    &lt;add key="ida:AppKey" value="<mark>[e.g. rZJJ9bHSi/cYnYwmQFxLYDn/6EfnrnIfKoNzv9NKgbo=]</mark>" xdt:Transform="SetAttributes" xdt:Locator="Match(key)" /&gt;
    &lt;add key="ida:PostLogoutRedirectUri" value="<mark>[e.g. https://mylobapp.azurewebsites.net/]</mark>" xdt:Transform="SetAttributes" xdt:Locator="Match(key)" /&gt;
    &lt;/appSettings&gt;</pre>
    
    Make sure that the value of ida:PostLogoutRedirectUri ends with a slash "/".
27. Right-click your project and select **Publish**.
28. Click **Publish** to publish to Azure App Service Web Apps.

When you're done, you have two Azure Active Directory applications configured in the Azure classic portal: one for your debug environment in Visual Studio, and one for the published web app in Azure. During debugging, the app settings in Web.config are used to make your **Debug** configuration work with Azure Active Directory, and when it's published (by default, the **Release** configuration is published), a transformed Web.config is uploaded that incorporates the app setting changes in Web.Release.config.

If you want to attach the published web app to the debugger (you must upload debug symbols of your code in the published web app), you can create a clone of the Debug configuration for Azure debugging, but with its own custom Web.config transform (e.g. Web.AzureDebug.config) that uses the Azure Active Directory settings from Web.Release.config. This allows you to maintain a static configuration across the different environments.

<a name="bkmk_crud"></a>

## Add line-of-business functionality to the sample application
In this part of the tutorial, you will learn how to build out the desired line-of-business functionality based on the sample application. You will create a simple CRUD work items tracker, similar to the TaskTracker controller but using standard CRUD scaffolding and design pattern. You will also use the included Scripts\AadPickerLibrary.js to enrich your application with data from the Azure Active Directory Graph API.  

1. In the Models folder, create a new [Code First](http://www.asp.net/mvc/overview/getting-started/getting-started-with-ef-using-mvc/creating-an-entity-framework-data-model-for-an-asp-net-mvc-application) model called WorkItem.cs, and replace the code with the code below:
   
     using System.ComponentModel.DataAnnotations;
   
     namespace WebApp_RoleClaims_DotNet.Models
     {
   
         public class WorkItem
         {
             [Key]
             public int ItemID { get; set; }
             public string AssignedToID { get; set; }
             public string AssignedToName { get; set; }
             public string Description { get; set; }
             public WorkItemStatus Status { get; set; }
         }
   
         public enum WorkItemStatus
         {
             Open, 
             Investigating, 
             Resolved, 
             Closed
         }
     }
2. Open DAL\RoleClaimContext.cs and add the highlighted code:  
   
   <pre class="prettyprint">
   public class RoleClaimContext : DbContext
   {
     public RoleClaimContext() : base("RoleClaimContext") { }
   
     public DbSet&lt;Task&gt; Tasks { get; set; }
     <mark>public DbSet&lt;WorkItem&gt; WorkItems { get; set; }</mark>
     public DbSet&lt;TokenCacheEntry&gt; TokenCacheEntries { get; set; }
   }</pre>
3. Build the project to make your new model accessible to the scaffolding logic in Visual Studio.
4. Add a new scaffolded item `WorkItemsController` to the Controllers folder. To do this, right-click **Controllers**, point to **Add**, and select **New scaffolded item**. 
5. Select **MVC 5 Controller with views, using Entity Framework** and click **Add**.
6. Select the model that you just created and click **Add**.
   
   ![](./media/web-sites-dotnet-lob-application-azure-ad/8-add-scaffolded-controller.png)
7. Open Controllers\WorkItemsController.cs
8. Add the highlighted [Authorize] decorations to the respective actions below.
   
   <pre class="prettyprint">
   ...
   
   <mark>[Authorize(Roles = "Admin, Observer, Writer, Approver")]</mark>
   public class WorkItemsController : Controller
   {
       ...
   
       <mark>[Authorize(Roles = "Admin, Writer")]</mark>
       public ActionResult Create()
       ...
   
       <mark>[Authorize(Roles = "Admin, Writer")]</mark>
       public async Task&lt;ActionResult&gt; Create([Bind(Include = "ItemID,AssignedToID,AssignedToName,Description,Status")] WorkItem workItem)
       ...
   
       <mark>[Authorize(Roles = "Admin, Writer")]</mark>
       public async Task&lt;ActionResult&gt; Edit(int? id)
       ...
   
       <mark>[Authorize(Roles = "Admin, Writer")]</mark>
       public async Task&lt;ActionResult&gt; Edit([Bind(Include = "ItemID,AssignedToID,AssignedToName,Description,Status")] WorkItem workItem)
       ...
   
       <mark>[Authorize(Roles = "Admin, Writer, Approver")]</mark>
       public async Task&lt;ActionResult&gt; Delete(int? id)
       ...
   
       <mark>[Authorize(Roles = "Admin, Writer, Approver")]</mark>
       public async Task&lt;ActionResult&gt; DeleteConfirmed(int id)
       ...
   }</pre>
   
   Since you take care of role mappings in the Azure classic portal UI, all you need to do is make sure that each action authorizes the right roles.
   
   > [!NOTE]
   > You may have noticed the <code>[ValidateAntiForgeryToken]</code> decoration on some of the actions. Due to the behavior described by [Brock Allen](https://twitter.com/BrockLAllen) at [MVC 4, AntiForgeryToken and Claims](http://brockallen.com/2012/07/08/mvc-4-antiforgerytoken-and-claims/) your HTTP POST may fail anti-forgery token validation because:
   > * Azure Active Directory does not send the http://schemas.microsoft.com/accesscontrolservice/2010/07/claims/identityprovider, which is required by default by the anti-forgery token.
   > * If Azure Active Directory is directory synced with AD FS, the AD FS trust by default does not send the http://schemas.microsoft.com/accesscontrolservice/2010/07/claims/identityprovider claim either, although you can manually configure AD FS to send this claim.
   >   You will take care of this in the next step.
   > 
   > 
9. In App_Start\Startup.Auth.cs, add the following line of code in the `ConfigureAuth` method. Right-click on each naming resolution error to fix it.
   
      AntiForgeryConfig.UniqueClaimTypeIdentifier = ClaimTypes.NameIdentifier;
   
   `ClaimTypes.NameIdentifies` specifies the claim `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`, which Azure Active Directory does supply. Now that you have taken care of the authorization part (seriously, that didn't take long), you can devote your time to the actual functionality of the actions. 
10. In Create() and Edit() add following code to make some variables available to your JavaScript later. Right-click on each naming resolution error to fix it.
    
     ViewData["token"] = AcquireToken(ClaimsPrincipal.Current.FindFirst(Globals.ObjectIdClaimType).Value);
     ViewData["tenant"] = ConfigHelper.Tenant;
11. The `AcquireToken()` method is not defined yet, so define it in the `WorkItemsController` class now. Right-click on each naming resolution error to fix it.
    
     static string AcquireToken(string userObjectId)
     {
    
         ClientCredential cred = new ClientCredential(ConfigHelper.ClientId, ConfigHelper.AppKey);
         Claim tenantIdClaim = ClaimsPrincipal.Current.FindFirst(Globals.TenantIdClaimType);
         AuthenticationContext authContext = new AuthenticationContext(String.Format(CultureInfo.InvariantCulture, ConfigHelper.AadInstance, tenantIdClaim.Value), new TokenDbCache(userObjectId));
         AuthenticationResult result = authContext.AcquireTokenSilent(ConfigHelper.GraphResourceId, cred, new UserIdentifier(userObjectId, UserIdentifierType.UniqueId));
         return result.AccessToken;
     }
12. In Views\WorkItems\Create.cshtml (an automatically scaffolded item), find the `Html.BeginForm` helper method and modify it as follows:  
    
    <pre class="prettyprint">@using (Html.BeginForm(<mark>"Create", "WorkItems", FormMethod.Post, new { id = "main-form" }</mark>))
    {
     @Html.AntiForgeryToken()
    
     &lt;div class="form-horizontal"&gt;
         &lt;h4&gt;WorkItem&lt;/h4&gt;
         &lt;hr /&gt;
         @Html.ValidationSummary(true, "", new { @class = "text-danger" })
    
         &lt;div class="form-group"&gt;
             &lt;div class="col-md-10"&gt;
                 @Html.EditorFor(model =&gt; model.AssignedToID, new { htmlAttributes = new { @class = "form-control"<mark>, @type=&quot;hidden&quot;</mark> } })
                 @Html.ValidationMessageFor(model =&gt; model.AssignedToID, "", new { @class = "text-danger" })
             &lt;/div&gt;
         &lt;/div&gt;
    
         &lt;div class="form-group"&gt;
             @Html.LabelFor(model =&gt; model.AssignedToName, htmlAttributes: new { @class = "control-label col-md-2" })
             &lt;div class="col-md-10"&gt;
                 @Html.EditorFor(model =&gt; model.AssignedToName, new { htmlAttributes = new { @class = "form-control" } })
                 @Html.ValidationMessageFor(model =&gt; model.AssignedToName, "", new { @class = "text-danger" })
             &lt;/div&gt;
         &lt;/div&gt;
    
         &lt;div class="form-group"&gt;
             @Html.LabelFor(model =&gt; model.Description, htmlAttributes: new { @class = "control-label col-md-2" })
             &lt;div class="col-md-10"&gt;
                 @Html.EditorFor(model =&gt; model.Description, new { htmlAttributes = new { @class = "form-control" } })
                 @Html.ValidationMessageFor(model =&gt; model.Description, "", new { @class = "text-danger" })
             &lt;/div&gt;
         &lt;/div&gt;
    
         &lt;div class="form-group"&gt;
             @Html.LabelFor(model =&gt; model.Status, htmlAttributes: new { @class = "control-label col-md-2" })
             &lt;div class="col-md-10"&gt;
                 @Html.EnumDropDownListFor(model =&gt; model.Status, htmlAttributes: new { @class = "form-control" })
                 @Html.ValidationMessageFor(model =&gt; model.Status, "", new { @class = "text-danger" })
             &lt;/div&gt;
         &lt;/div&gt;
    
         &lt;div class="form-group"&gt;
             &lt;div class="col-md-offset-2 col-md-10"&gt;
                 &lt;input type="submit" value="Create" class="btn btn-default" <mark>id="submit-button"</mark> /&gt;
             &lt;/div&gt;
         &lt;/div&gt;
     &lt;/div&gt;
    
     <mark>&lt;script&gt;
             // People/Group Picker Code
             var maxResultsPerPage = 14;
             var input = document.getElementById("AssignedToName");
             var token = "@ViewData["token"]";
             var tenant = "@ViewData["tenant"]";
    
             var picker = new AadPicker(maxResultsPerPage, input, token, tenant);
    
             // Submit the selected user/group to be asssigned.
             $("#submit-button").click({ picker: picker }, function () {
                 if (!picker.Selected())
                     return;
                 $("#main-form").get()[0].elements["AssignedToID"].value = picker.Selected().objectId;
             });
     &lt;/script&gt;</mark>
    
    }</pre>
    
    In the script, the AadPicker object calls [Azure Active Directory Graph API](https://msdn.microsoft.com/Library/Azure/Ad/Graph/api/api-catalog) to search for users and groups that match the input.  
13. Open the [Package Manger Console](http://docs.nuget.org/Consume/Package-Manager-Console) and run **Enable-Migrations –EnableAutomaticMigrations**. Similar to the option you selected when you published the app to Azure, this command helps update your app's database schema in [LocalDB](https://msdn.microsoft.com/library/hh510202.aspx) when you debug it in Visual Studio.
14. Now, either run the app in the Visual Studio debugger or publish again to App Service Web Apps. Log in as the application owner and navigate to `https://<webappname>.azurewebsites.net/WorkItems/Create`. You'll see now that you can pick an Azure Active Directory user or group from the drop down list, or type in something to filter the list.
    
    ![](./media/web-sites-dotnet-lob-application-azure-ad/9-create-workitem.png)
15. Fill out the rest of the form and click **Create**. The ~/WorkItems/Index page now shows the newly created work item. You'll also notice in the screenshot below that I removed the `AssignedToID` column in Views\WorkItems\Index.cshtml. 
    
    ![](./media/web-sites-dotnet-lob-application-azure-ad/10-workitem-index.png)
16. Now, make similar changes to the **Edit** view. In Views\WorkItems\Edit.cshtml, make the changes to the `Html.BeginForm` helper method that are identical to the ones for Views\WorkItems\Create.cshtml in the previous step (replace "Create" with "Edit" in the highlighted code above).

That's it!

Now that you have configured the authorizations and line-of-business functionality for the different actions in the WorkItems controller, you can try to log in as users of different application roles to see how the application responds.

![](./media/web-sites-dotnet-lob-application-azure-ad/11-edit-unauthorized.png)

<a name="bkmk_resources"></a>

## Further resources
* [Protect the Application with SSL and the Authorize Attribute](web-sites-dotnet-deploy-aspnet-mvc-app-membership-oauth-sql-database.md#protect-the-application-with-ssl-and-the-authorize-attribute)
* [Use Active Directory for authentication in Azure App Service](web-sites-authentication-authorization.md)
* [Create a .NET MVC web app in Azure App Service with AD FS authentication](web-sites-dotnet-lob-application-adfs.md)
* [Microsoft Azure Active Directory Samples and Documentation](https://github.com/AzureADSamples)
* [Vittorio Bertocci's blog](http://blogs.msdn.com/b/vbertocci/)
* [Migrate a VS2013 Web Project From WIF to Katana](http://www.cloudidentity.com/blog/2014/09/15/MIGRATE-A-VS2013-WEB-PROJECT-FROM-WIF-TO-KATANA/)
* [Azure's new Hybrid Connections not your father's #hybridCloud](/documentation/videos/new-hybrid-connections-not-your-fathers-hybridcloud/)
* [Similarities between Active Directory and Azure Active Directory](http://technet.microsoft.com/library/dn518177.aspx)
* [Directory Sync with Single Sign-On Scenario](http://technet.microsoft.com/library/dn441213.aspx)
* [Azure Active Directory Supported Token and Claim Types](http://msdn.microsoft.com/library/azure/dn195587.aspx)

[!INCLUDE [app-service-web-whats-changed](../../includes/app-service-web-whats-changed.md)]

[!INCLUDE [app-service-web-try-app-service](../../includes/app-service-web-try-app-service.md)]

