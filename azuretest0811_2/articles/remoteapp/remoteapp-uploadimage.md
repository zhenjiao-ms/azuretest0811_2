
---
title: Upload a custom image for Azure RemoteApp | Microsoft Azure
description: Learn how to upload a custom image for Azure RemoteApp
services: remoteapp
documentationcenter: ''
author: ericorman
manager: mbaldwin

ms.service: remoteapp
ms.workload: compute
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 06/12/2016
ms.author: ericor

---
# Upload a custom image for Azure RemoteApp
Now that you have created your custom template image or have updated it with changes, you need to upload that image to your Azure RemoteApp image library. Use these steps.

## Before you start
1. Verify your custom image meets the [image requirements](remoteapp-imagereqs.md) and [application requirements](remoteapp-appreqs.md).
2. Install the [Azure PowerShell module](../powershell-install-configure.md).

## Step by step on how to upload custom image
1. Open Azure Management Portal and navigate to the RemoteApp page.
2. On the **Template images** tab, click **Upload** at the bottom of the page.
3. Enter a friendly name for your image and specify the storage account location. Ensure the location is the same location as your RemoteApp collection or a location where you want to create one.
4. When prompted, download the script to your local PC.
5. Copy the command parameters in the text box to your clipboard.
6. Open an elevated Windows PowerShell window.
7. From the elevated Windows PowerShell window, navigate to the same directory where you downloaded the script.
8. Paste the copied command and press **Enter**.
   
   The upload process will begin and duration may depend on many factors including your network speed and size of the image
9. If your upload does not succeed because of network interruption or things like that, you can always resume the upload process you began. To resume an upload, run the script again using the same command line.

> [!WARNING]
> Never modify the upload script. Specific checks have been implemented to ensure that the image meets the image requirements and application requirements.
> 
> 

## Common problems
* Make sure you use Windows PowerShell, not Azure PowerShell. You need to install the Azure PowerShell module because certain modules are needed during the upload process.
* Never alter the script, validations are there for your convenience.
* If the vhd file gets locked out during upload, copy the file or move it to a new location and attempt upload again. There might be some Windows process that is preventing upload.  

