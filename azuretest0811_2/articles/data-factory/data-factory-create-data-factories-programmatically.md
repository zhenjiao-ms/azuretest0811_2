---
title: Create, monitor, and manage Azure data factories by using Data Factory SDK | Microsoft Azure
description: Learn how to programmatically create, monitor, and manage Azure data factories by using Data Factory SDK.
services: data-factory
documentationcenter: ''
author: spelluru
manager: jhubbard
editor: monicar

ms.service: data-factory
ms.workload: data-services
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 07/28/2016
ms.author: spelluru

---
# Create, monitor, and manage Azure data factories using Data Factory .NET SDK
## Overview
You can create, monitor, and manage Azure data factories programmatically using Data Factory .NET SDK. This article contains a walkthrough that you can follow to create a sample .NET console application that creates and monitors a data factory. See [Data Factory Class Library Reference](http://go.microsoft.com/fwlink/?LinkID=521877) for details about Data Factory .NET SDK. 

## Prerequisites
* Visual Studio 2012 or 2013 or 2015
* Download and install [Azure .NET SDK](http://azure.microsoft.com/downloads/)
* Download and install NuGet packages for Azure Data Factory. Instructions are in the walkthrough.

## Walkthrough
1. Using Visual Studio 2012 or 2013, create a C# .NET console application.
    <ol type="a">
        <li>Launch <b>Visual Studio 2012</b> or <b>Visual Studio 2013</b>.</li>
        <li>Click <b>File</b>, point to <b>New</b>, and click <b>Project</b>.</li> 
        <li>Expand <b>Templates</b>, and select <b>Visual C#</b>. In this walkthrough, you use C#, but you can use any .NET language.</li> 
        <li>Select <b>Console Application</b> from the list of project types on the right.</li>
        <li>Enter <b>DataFactoryAPITestApp</b> for the <b>Name</b>.</li> 
        <li>Select <b>C:\ADFGetStarted</b> for the <b>Location</b>.</li>
        <li>Click <b>OK</b> to create the project.</li>
    </ol>
2. Click <b>Tools</b>, point to <b>NuGet Package Manager</b>, and click <b>Package Manager Console</b>.
3. In the <b>Package Manager Console</b>, execute the following commands one-by-one.</b>. 
   
     Install-Package Microsoft.Azure.Management.DataFactories
     Install-Package Microsoft.IdentityModel.Clients.ActiveDirectory -Version 2.19.208020213
4. Add the following **appSetttings** section to the **App.config** file. These are used by the helper method: **GetAuthorizationHeader**. 
   
    Replace values for **AdfClientId**, **RedirectUri**, **SubscriptionId** and **ActiveDirectoryTenantId** with your own values. 
   
    You can get subscription ID and tenant ID values by running **Get-AzureAccount -Format-List** from Azure PowerShell (you may need to login first by using Add-AzureAccount) after you login using Login-AzureRmAccount. 
   
    You can get the CLIENT ID and redirect URI for your AD application from the Azure portal.      
   
        <appSettings>
            <add key="ActiveDirectoryEndpoint" value="https://login.windows.net/" />
            <add key="ResourceManagerEndpoint" value="https://management.azure.com/" />
            <add key="WindowsManagementUri" value="https://management.core.windows.net/" />
   
            <!-- Replace the following values with your own -->
            <add key="AdfClientId" value="Your AD application ID" />
            <add key="RedirectUri" value="Your AD application's redirect URI" />
            <add key="SubscriptionId" value="your subscription ID" />
            <add key="ActiveDirectoryTenantId" value="your tenant ID" />
        </appSettings>
5. Add the following **using** statements to the source file (Program.cs) in the project.
   
        using System.Threading;
        using System.Configuration;
        using System.Collections.ObjectModel;
   
        using Microsoft.Azure.Management.DataFactories;
        using Microsoft.Azure.Management.DataFactories.Models;
        using Microsoft.Azure.Management.DataFactories.Common.Models;
   
        using Microsoft.IdentityModel.Clients.ActiveDirectory;
        using Microsoft.Azure;
6. Add the following code that creates an instance of  **DataPipelineManagementClient** class to the **Main** method. You will use this object to create a data factory, a linked service, input and output datasets, and a pipeline. You will also this object to monitor slices of a dataset at runtime.    
   
        // create data factory management client
        string resourceGroupName = "resourcegroupname";
        string dataFactoryName = "APITutorialFactorySP";
   
        TokenCloudCredentials aadTokenCredentials =
            new TokenCloudCredentials(
                ConfigurationManager.AppSettings["SubscriptionId"],
                GetAuthorizationHeader());
   
        Uri resourceManagerUri = new Uri(ConfigurationManager.AppSettings["ResourceManagerEndpoint"]);
   
        DataFactoryManagementClient client = new DataFactoryManagementClient(aadTokenCredentials, resourceManagerUri);
   
   > [!NOTE]
   > Replace the **resourcegroupname** with the name of your Azure resource group. You can create a resource group using the [New-AzureResourceGroup](https://msdn.microsoft.com/library/Dn654594.aspx) cmdlet.
   > 
7. Add the following code that creates a **data factory** to the **Main** method.
   
        // create a data factory
        Console.WriteLine("Creating a data factory");
        client.DataFactories.CreateOrUpdate(resourceGroupName,
            new DataFactoryCreateOrUpdateParameters()
            {
                DataFactory = new DataFactory()
                {
                    Name = dataFactoryName,
                    Location = "westus",
                    Properties = new DataFactoryProperties() { }
                }
            }
        );
8. Add the following code that creates a **linked service** to the **Main** method. 
   
   > [!NOTE]
   > Use **account name** and **account key** of your Azure storage account for the **ConnectionString**. 
   > 
   > 
   
        // create a linked service
        Console.WriteLine("Creating a linked service");
        client.LinkedServices.CreateOrUpdate(resourceGroupName, dataFactoryName,
            new LinkedServiceCreateOrUpdateParameters()
            {
                LinkedService = new LinkedService()
                {
                    Name = "LinkedService-AzureStorage",
                    Properties = new LinkedServiceProperties
                    (
                        new AzureStorageLinkedService("DefaultEndpointsProtocol=https;AccountName=<account name>;AccountKey=<account key>")
                    )
                }
            }
        );
9. Add the following code that creates **input and output datasets** to the **Main** method. 
   
    Note that the **FolderPath** for the input blob is set to **adftutorial/** where **adftutorial** is the  name of the container in your blob storage. If this container does not exist in your Azure blob storage, create a container with this name: **adftutorial** and upload a text file to the container.
   
    Note that the FolderPath for the output blob is set to: **adftutorial/apifactoryoutput/{Slice}** where **Slice** is dynamically calculated based on the value of **SliceStart** (start date-time of each slice.)  

        // create input and output datasets
        Console.WriteLine("Creating input and output datasets");
        string Dataset_Source = "DatasetBlobSource";
        string Dataset_Destination = "DatasetBlobDestination";

        client.Datasets.CreateOrUpdate(resourceGroupName, dataFactoryName,
            new DatasetCreateOrUpdateParameters()
            {
                Dataset = new Dataset()
                {
                    Name = Dataset_Source,
                    Properties = new DatasetProperties()
                    {
                        LinkedServiceName = "LinkedService-AzureStorage",
                        TypeProperties = new AzureBlobDataset()
                        {
                            FolderPath = "adftutorial/",
                            FileName = "emp.txt"
                        },
                        External = true,
                        Availability = new Availability()
                        {
                            Frequency = SchedulePeriod.Hour,
                            Interval = 1,
                        },

                        Policy = new Policy()
                        {
                            Validation = new ValidationPolicy()
                            {
                                MinimumRows = 1
                            }
                        }
                    }
                }
            });

        client.Datasets.CreateOrUpdate(resourceGroupName, dataFactoryName,
            new DatasetCreateOrUpdateParameters()
            {
                Dataset = new Dataset()
                {
                    Name = Dataset_Destination,
                    Properties = new DatasetProperties()
                    {

                        LinkedServiceName = "LinkedService-AzureStorage",
                        TypeProperties = new AzureBlobDataset()
                        {
                            FolderPath = "adftutorial/apifactoryoutput/{Slice}",
                            PartitionedBy = new Collection<Partition>()
                            {
                                new Partition()
                                {
                                    Name = "Slice",
                                    Value = new DateTimePartitionValue()
                                    {
                                        Date = "SliceStart",
                                        Format = "yyyyMMdd-HH"
                                    }
                                }
                            }
                        },

                        Availability = new Availability()
                        {
                            Frequency = SchedulePeriod.Hour,
                            Interval = 1,
                        },
                    }
                }
            });

1. Add the following code that **creates and activates a pipeline** to the **Main** method. This pipeline has a **CopyActivity** that takes **BlobSource** as a source and **BlobSink** as a sink.

The Copy Activity performs the data movement in Azure Data Factory and the activity is powered by a globally available service that can copy data between various data stores in a secure, reliable, and scalable way. See [Data Movement Activities](data-factory-data-movement-activities.md) article for details about the Copy Activity. 

            // create a pipeline
        Console.WriteLine("Creating a pipeline");
        DateTime PipelineActivePeriodStartTime = new DateTime(2014, 8, 9, 0, 0, 0, 0, DateTimeKind.Utc);
        DateTime PipelineActivePeriodEndTime = PipelineActivePeriodStartTime.AddMinutes(60);
        string PipelineName = "PipelineBlobSample";

        client.Pipelines.CreateOrUpdate(resourceGroupName, dataFactoryName,
            new PipelineCreateOrUpdateParameters()
            {
                Pipeline = new Pipeline()
                {
                    Name = PipelineName,
                    Properties = new PipelineProperties()
                    {
                        Description = "Demo Pipeline for data transfer between blobs",

                        // Initial value for pipeline's active period. With this, you won't need to set slice status
                        Start = PipelineActivePeriodStartTime,
                        End = PipelineActivePeriodEndTime,

                        Activities = new List<Activity>()
                        {                                
                            new Activity()
                            {   
                                Name = "BlobToBlob",
                                Inputs = new List<ActivityInput>()
                                {
                                    new ActivityInput() {
                                        Name = Dataset_Source
                                    }
                                },
                                Outputs = new List<ActivityOutput>()
                                {
                                    new ActivityOutput()
                                    {
                                        Name = Dataset_Destination
                                    }
                                },
                                TypeProperties = new CopyActivity()
                                {
                                    Source = new BlobSource(),
                                    Sink = new BlobSink()
                                    {
                                        WriteBatchSize = 10000,
                                        WriteBatchTimeout = TimeSpan.FromMinutes(10)
                                    }
                                }
                            }

                        },
                    }
                }
            });



1. Add the following helper method used by the **Main** method to the **Program** class. This method pops a dialog box that that lets you provide **user name** and **password** that you use to login to Azure Portal. 
   
       public static string GetAuthorizationHeader()
       {
           AuthenticationResult result = null;
           var thread = new Thread(() =>
           {
               try
               {
                   var context = new AuthenticationContext(ConfigurationManager.AppSettings["ActiveDirectoryEndpoint"] + ConfigurationManager.AppSettings["ActiveDirectoryTenantId"]);
   
                   result = context.AcquireToken(
                       resource: ConfigurationManager.AppSettings["WindowsManagementUri"],
                       clientId: ConfigurationManager.AppSettings["AdfClientId"],
                       redirectUri: new Uri(ConfigurationManager.AppSettings["RedirectUri"]),
                       promptBehavior: PromptBehavior.Always);
               }
               catch (Exception threadEx)
               {
                   Console.WriteLine(threadEx.Message);
               }
           });
   
           thread.SetApartmentState(ApartmentState.STA);
           thread.Name = "AcquireTokenThread";
           thread.Start();
           thread.Join();
   
           if (result != null)
           {
               return result.AccessToken;
           }
   
           throw new InvalidOperationException("Failed to acquire token");
       }  
2. Add the following code to the **Main** method to get the status of a data slice of the output dataset. There is only slice expected in this sample.   
   
       // Pulling status within a timeout threshold
       DateTime start = DateTime.Now;
       bool done = false;
   
       while (DateTime.Now - start < TimeSpan.FromMinutes(5) && !done)
       {
           Console.WriteLine("Pulling the slice status");
           // wait before the next status check
           Thread.Sleep(1000 * 12);
   
           var datalistResponse = client.DataSlices.List(resourceGroupName, dataFactoryName, Dataset_Destination,
               new DataSliceListParameters()
               {
                   DataSliceRangeStartTime = PipelineActivePeriodStartTime.ConvertToISO8601DateTimeString(),
                   DataSliceRangeEndTime = PipelineActivePeriodEndTime.ConvertToISO8601DateTimeString()
               });
   
           foreach (DataSlice slice in datalistResponse.DataSlices)
           {
               if (slice.State == DataSliceState.Failed || slice.State == DataSliceState.Ready)
               {
                   Console.WriteLine("Slice execution is done with status: {0}", slice.State);
                   done = true;
                   break;
               }
               else
               {
                   Console.WriteLine("Slice status is: {0}", slice.State);
               }
           }
       }
3. **(optional)** Add the following code to get run details for a data slice slice to the **Main** method.
   
       Console.WriteLine("Getting run details of a data slice");
   
       // give it a few minutes for the output slice to be ready
       Console.WriteLine("\nGive it a few minutes for the output slice to be ready and press any key.");
       Console.ReadKey();
   
       var datasliceRunListResponse = client.DataSliceRuns.List(
               resourceGroupName,
               dataFactoryName,
               Dataset_Destination,
               new DataSliceRunListParameters()
               {
                   DataSliceStartTime = PipelineActivePeriodStartTime.ConvertToISO8601DateTimeString()
               }
           );
   
       foreach (DataSliceRun run in datasliceRunListResponse.DataSliceRuns)
       {
           Console.WriteLine("Status: \t\t{0}", run.Status);
           Console.WriteLine("DataSliceStart: \t{0}", run.DataSliceStart);
           Console.WriteLine("DataSliceEnd: \t\t{0}", run.DataSliceEnd);
           Console.WriteLine("ActivityId: \t\t{0}", run.ActivityName);
           Console.WriteLine("ProcessingStartTime: \t{0}", run.ProcessingStartTime);
           Console.WriteLine("ProcessingEndTime: \t{0}", run.ProcessingEndTime);
           Console.WriteLine("ErrorMessage: \t{0}", run.ErrorMessage);
       }
   
       Console.WriteLine("\nPress any key to exit.");
       Console.ReadKey();
4. In the Solution Explorer, expand the project (**DataFactoryAPITestApp**), right-click **References**, and click **Add Reference**. Select check box for **System.Configuration** assembly and click **OK**. 
5. Build the console application. Click **Build** on the menu and click **Build Solution**. 
6. Confirm that there is at least one file in the adftutorial container in your Azure blob storage. If not, create Emp.txt file in Notepad with the following content and upload it to the adftutorial container.
   
       John, Doe
       Jane, Doe
7. Run the sample by clicking **Debug** -> **Start Debugging** on the menu. When you see the **Getting run details of a data slice**, wait for a few minutes, and press **ENTER**. 
8. Use the Azure Portal to verify that the data factory: **APITutorialFactory** is created with the following artifacts: 
   * Linked service: **LinkedService_AzureStorage** 
   * Dataset: **DatasetBlobSource** and **DatasetBlobDestination**.
   * Pipeline: **PipelineBlobSample** 
9. Verify that an output file is created in the **apifactoryoutput** folder in the **adftutorial** container.

## Login without popup dialog box
The above sample code launches a dialog box for you to enter Azure credentials. If you need to sign-in programmatically without using a dialog-box, see [Authenticating a service principal with Azure Resource Manager](../resource-group-authenticate-service-principal.md#authenticate-service-principal-with-certificate---powershell). 

### Example
Create GetAuthorizationHeaderNoPopup method as shown below:  

    public static string GetAuthorizationHeaderNoPopup()
    {
        var authority = new Uri(new Uri("https://login.windows.net"), ConfigurationManager.AppSettings["ActiveDirectoryTenantId"]);
        var context = new AuthenticationContext(authority.AbsoluteUri);
        var credential = new ClientCredential(ConfigurationManager.AppSettings["AdfClientId"], ConfigurationManager.AppSettings["AdfClientSecret"]);
        AuthenticationResult result = context.AcquireTokenAsync(ConfigurationManager.AppSettings["WindowsManagementUri"], credential).Result;
        if (result != null)
            return result.AccessToken;

        throw new InvalidOperationException("Failed to acquire token");
    }

Replace **GetAuthorizationHeader** call with a call to **GetAuthorizationHeaderNoPopup** in the **Main** function:  

        TokenCloudCredentials aadTokenCredentials =
            new TokenCloudCredentials(
            ConfigurationManager.AppSettings["SubscriptionId"],
            GetAuthorizationHeaderNoPopup());

Here is how you can create the Active Directory application, service principal, and then assign it to the Data Factory Contributor role: 

1. Create the AD application. 
   
        $azureAdApplication = New-AzureRmADApplication -DisplayName "MyADAppForADF" -HomePage "https://www.contoso.org" -IdentifierUris "https://www.myadappforadf.org/example" -Password "Pass@word1"
2. Create the AD service principal. 
   
        New-AzureRmADServicePrincipal -ApplicationId $azureAdApplication.ApplicationId
3. Add service principal to the Data Factory Contributor role. 
   
        New-AzureRmRoleAssignment -RoleDefinitionName "Data Factory Contributor" -ServicePrincipalName $azureAdApplication.ApplicationId.Guid
4. Get the application ID.
   
        $azureAdApplication

Note down the application ID and the password (client secret) and use it in the code above. 

[data-factory-introduction]: data-factory-introduction.md
[adf-getstarted]: data-factory-copy-data-from-azure-blob-storage-to-sql-database.md
[use-custom-activities]: data-factory-use-custom-activities.md
[developer-reference]: http://go.microsoft.com/fwlink/?LinkId=516908

[adf-class-library-reference]: http://go.microsoft.com/fwlink/?LinkID=521877
[azure-developer-center]: http://azure.microsoft.com/downloads/

