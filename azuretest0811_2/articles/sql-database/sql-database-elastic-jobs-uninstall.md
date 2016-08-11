---
title: How to uninstall elastic database jobs tool
description: How to uninstall the elastic database jobs tool
services: sql-database
documentationcenter: ''
manager: jhubbard
author: ddove
editor: ''

ms.service: sql-database
ms.workload: sql-database
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/27/2016
ms.author: ddove

---
# Uninstall Elastic Database jobs components
**Elastic Database jobs** components can be uninstalled using either the Portal or PowerShell.

## Uninstall Elastic Database jobs components using the Azure portal
1. Open the [Azure portal](https://portal.azure.com/).
2. Navigate to the subscription that contains **Elastic Database jobs** components, namely the subscription in which Elastic Database jobs components were installed.
3. Click **Browse** and click **Resource groups**.
4. Select the resource group named "__ElasticDatabaseJob".
5. Delete the resource group.

## Uninstall  Elastic Database jobs components using PowerShell
1. Launch a Microsoft Azure PowerShell command window and navigate to the tools sub-directory under the Microsoft.Azure.SqlDatabase.Jobs.x.x.xxxx.x folder: Type **cd tools**.
   
     PS C:\*Microsoft.Azure.SqlDatabase.Jobs.x.x.xxxx.x*>cd tools
2. Execute the .\UninstallElasticDatabaseJobs.ps1 PowerShell script.
   
     PS C:\*Microsoft.Azure.SqlDatabase.Jobs.x.x.xxxx.x*\tools>Unblock-File .\UninstallElasticDatabaseJobs.ps1
     PS C:\*Microsoft.Azure.SqlDatabase.Jobs.x.x.xxxx.x*\tools>.\UninstallElasticDatabaseJobs.ps1

Or simply, execute the following script, assuming default values where used on installation of the components:

        $ResourceGroupName = "__ElasticDatabaseJob"
        Switch-AzureMode AzureResourceManager

        $resourceGroup = Get-AzureResourceGroup -Name $ResourceGroupName
        if(!$resourceGroup)
        {
            Write-Host "The Azure Resource Group: $ResourceGroupName has already been deleted.  Elastic database job components are uninstalled."
            return
        }

        Write-Host "Removing the Azure Resource Group: $ResourceGroupName.  This may take a few minutes.”
        Remove-AzureResourceGroup -Name $ResourceGroupName -Force
        Write-Host "Completed removing the Azure Resource Group: $ResourceGroupName.  Elastic database job compoennts are now uninstalled."

## Next steps
To re-install Elastic Database jobs, see [Installing the Elastic Database job service](sql-database-elastic-jobs-service-installation.md)

For an overview of Elastic Database jobs, see [Elastic Database jobs overview](sql-database-elastic-jobs-overview.md).

<!--Image references-->


