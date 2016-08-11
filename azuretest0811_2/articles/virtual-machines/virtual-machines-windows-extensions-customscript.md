---
title: Custom scripts on Windows VMs using templates | Microsoft Azure
description: Automate Windows VM configuration tasks by using the Custom Script extension with Resource Manager templates
services: virtual-machines-windows
documentationcenter: ''
author: kundanap
manager: timlt
editor: ''
tags: azure-resource-manager

ms.service: virtual-machines-windows
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure-services
ms.date: 03/29/2016
ms.author: kundanap

---
# Using the Custom Script extension for Windows VMs With Azure Resource Manager templates
[!INCLUDE [virtual-machines-common-extensions-customscript](../../includes/virtual-machines-common-extensions-customscript.md)]

## Template example for a Windows VM
Define the following resource in the Resource section of the template

       {
       "type": "Microsoft.Compute/virtualMachines/extensions",
       "name": "MyCustomScriptExtension",
       "apiVersion": "2015-05-01-preview",
       "location": "[parameters('location')]",
       "dependsOn": [
           "[concat('Microsoft.Compute/virtualMachines/',parameters('vmName'))]"
       ],
       "properties": {
           "publisher": "Microsoft.Compute",
           "type": "CustomScriptExtension",
           "typeHandlerVersion": "1.7",
           "autoUpgradeMinorVersion":true,
           "settings": {
               "fileUris": [
               "http://Yourstorageaccount.blob.core.windows.net/customscriptfiles/start.ps1"
           ],
           "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File start.ps1"
         }
       }
     }

In the example above, replace the file URL and the file name with your own settings.
After authoring the template, you can deploy it using Azure Powershell.

In many scenarios customers want to keep the script urls and parameters as private. This can be achieved by keeping the script URL as a private so that can be accessed only with a storage account name and key , sent as protected settings. In addition the script parameters can also be provided as protected settings with version 1.7 or above for the windows custom script extension.

## Template example for a Windows VM with protected settings
        {
        "publisher": "Microsoft.Compute",
        "type": "CustomScriptExtension",
        "typeHandlerVersion": "1.7",
        "settings": {
        "fileUris": [
        "http: //Yourstorageaccount.blob.core.windows.net/customscriptfiles/start.ps1"
        ]
        },
        "protectedSettings": {
        "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -start.ps1",
        "storageAccountName": "yourStorageAccountName",
        "storageAccountKey": "yourStorageAccountKey"
        }
        }
For information on the schema of the latest versions of custom script extension, please refer to the documentation [here](virtual-machines-windows-extensions-configuration-samples.md)

Please refer to the example below for a complete samples of configuring applications on a VM using Custom Script extension.

* [Custom Script extension on a Windows VM](https://github.com/Azure/azure-quickstart-templates/blob/b1908e74259da56a92800cace97350af1f1fc32b/201-list-storage-keys-windows-vm/azuredeploy.json/)

