

This article shows you how to deploy an Azure Virtual Machine Scale Set using a Visual Studio Resource Group Deployment.

[Azure Virtual Machine Scale Sets](https://azure.microsoft.com/blog/azure-vm-scale-sets-public-preview/) are an Azure Compute resource to deploy and manage a collection of similar virtual machines with easily integrated options for auto-scale and load balancing. You can provision and deploy VM Scale Sets using [Azure Resource Manager (ARM) Templates](https://github.com/Azure/azure-quickstart-templates). ARM Templates can be deployed using Azure CLI, PowerShell, REST and also directly from Visual Studio. Visual Studio provides a set of example Templates which can be deployed as part of an Azure Resource Group Deployment project.

Azure Resource Group deployments are a way to group together and publish a set of related Azure resources in a single deployment operation. You can learn more about them here: [Creating and deploying Azure resource groups through Visual Studio](../articles/vs-azure-tools-resource-groups-deployment-projects-create-deploy.md).

## Pre-requisites
To get started deploying VM Scale Sets in Visual Studio you need the following:

* Visual Studio 2013 or 2015
* Azure SDK 2.7 or 2.8

Note: These instructions assume you are using Visual Studio 2015 with [Azure SDK 2.8](https://azure.microsoft.com/blog/announcing-the-azure-sdk-2-8-for-net/).

## Creating a Project
1. Create a new project in Visual Studio 2015 by choosing **File | New | Project**.
   
    ![File New](./media/virtual-machines-common-scale-sets-visual-studio/1-FileNew.png)
2. Under **Visual C# | Cloud**, choose **Azure Resource Manager** to create a project for deploying an ARM Template.
   
    ![Create Project](./media/virtual-machines-common-scale-sets-visual-studio/2-CreateProject.png)
3. From the list of Templates, select either the Linux or Windows Virtual Machine Scale Set Template.
   
   ![Select Template](./media/virtual-machines-common-scale-sets-visual-studio/3b-SelectTemplateLin.png)
4. Once your project is created you’ll see PowerShell deployment scripts, an Azure Resource Manager Template, and a parameter file for the Virtual Machine Scale Set.
   
    ![Solution Explorer](./media/virtual-machines-common-scale-sets-visual-studio/4-SolutionExplorer.png)

## Customize your project
Now you can edit the Template to customize it for your application's needs, such as adding VM extension properties or editing load balancing rules. By default the VM Scale Set Templates are configured to deploy the AzureDiagnostics extension which makes it easy to add autoscale rules. It also deploys a load balancer with a public IP address, configured with inbound NAT rules which let you connect to the VM instances with SSH (Linux) or RDP (Windows) – the front end port range starts at 50000, which means in the case of Linux, if you SSH to port 50000 of the public IP address (or domain name) you will be routed to port 22 of the first VM in the Scale Set. Connecting to port 50001 will be routed to port 22 of the second VM and so on.

 A good way to edit your Templates with Visual Studio is to use the JSON Outline to organize the parameters, variables and resources. With an understanding of the schema Visual Studio can point out errors in your Template before you deploy it.

![JSON Explorer](./media/virtual-machines-common-scale-sets-visual-studio/10-JsonExplorer.png)

## Deploy the project
1. Deploy the ARM Template to Azure to create the VM Scale Set resource. Right click on the project node, choose **Deploy | New Deployment**.
   
    ![Deploy Template](./media/virtual-machines-common-scale-sets-visual-studio/5-DeployTemplate.png)
2. Select your subscription in the “Deploy to Resource Group” dialog.
   
    ![Deploy Template](./media/virtual-machines-common-scale-sets-visual-studio/6-DeployTemplate.png)
3. From here you can also create a new Azure Resource Group to deploy your Template to.
   
    ![New Resource Group](./media/virtual-machines-common-scale-sets-visual-studio/7-NewResourceGroup.png)
4. Next select the **Edit Parameters** button to enter parameters which will be passed to your Template, Certain values such as the username and password for the OS are required to create the deployment.
   
    ![Edit Parameters](./media/virtual-machines-common-scale-sets-visual-studio/8-EditParameter.png)
5. Now click **Deploy**. The **Output** window will show the deployment progress. Note that the the action is executing the **Deploy-AzureResourceGroup.ps1** script.
   
   ![Output Window](./media/virtual-machines-common-scale-sets-visual-studio/9-Output.png)

## Exploring your VM Scale Set
Once the deployment completes, you can view the new VM Scale Set in the Visual Studio **Cloud Explorer** (refresh the list). Cloud Explorer lets you manage Azure resources in Visual Studio while developing applications. You can also view your VM Scale Set in the Azure Portal and Azure Resource Explorer.

![Cloud Explorer](./media/virtual-machines-common-scale-sets-visual-studio/12-CloudExplorer.png)

 The portal provides the best way to visually manage your Azure infrastructure with a web browser, while Azure Resource Explorer provides an easy way to explorer and debug Azure resources, giving a window into the “instance view” and also showing PowerShell commands for the resources you are looking at. While VM Scale Sets are in preview, the Resource Explorer will show the most detail for your VM Scale Sets.

## Next steps
Once you’ve successfully deployed VM Scale Sets through Visual Studio you can further customize your project to suit your application requirements. For example setting up autoscale by adding an Insights resource, adding infrastructure to your Template like standalone VMs, or deploying applications using the custom script extension. A good source of example Templates can be found in the [Azure Quickstart Templates](https://github.com/Azure/azure-quickstart-templates) GitHub repository (search for "vmss").

[file_new]: ./media/virtual-machines-common-scale-sets-visual-studio/1-FileNew.png
[create_project]: ./media/virtual-machines-common-scale-sets-visual-studio/2-CreateProject.png
[select_Template]: ./media/virtual-machines-common-scale-sets-visual-studio/3b-SelectTemplateLin.png
[solution_explorer]: ./media/virtual-machines-common-scale-sets-visual-studio/4-SolutionExplorer.png
[json_explorer]: ./media/virtual-machines-common-scale-sets-visual-studio/10-JsonExplorer.png
[5deploy_Template]: ./media/virtual-machines-common-scale-sets-visual-studio/5-DeployTemplate.png
[6deploy_Template]: ./media/virtual-machines-common-scale-sets-visual-studio/6-DeployTemplate.png
[new_resource]: ./media/virtual-machines-common-scale-sets-visual-studio/7-NewResourceGroup.png
[edit_parameters]: ./media/virtual-machines-common-scale-sets-visual-studio/8-EditParameter.png
[output_window]: ./media/virtual-machines-common-scale-sets-visual-studio/9-Output.png
[cloud_explorer]: ./media/virtual-machines-common-scale-sets-visual-studio/12-CloudExplorer.png