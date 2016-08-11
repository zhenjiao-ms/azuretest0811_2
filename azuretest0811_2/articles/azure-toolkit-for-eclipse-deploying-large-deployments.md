---
title: Deploying Large Deployments
description: Learn how to deploy large deployments using the Azure Toolkit for Eclipse.
services: ''
documentationcenter: java
author: rmcmurray
manager: wpickett
editor: ''

ms.service: multiple
ms.workload: na
ms.tgt_pltfrm: multiple
ms.devlang: Java
ms.topic: article
ms.date: 06/24/2016
ms.author: robmcm

---
<!-- Legacy MSDN URL = https://msdn.microsoft.com/library/azure/dn268601.aspx -->

# Deploying Large Deployments
If your deployment is too large to be contained in the default approot folder, you can use a local storage resource as the deployment root folder for your JDK and application server.

## To use a local storage resource as the deployment root folder for large deployments
1. Create a new local storage resource. The name of the resource does not matter. Storage resources are defined at the role level. The quickest way to access the local storage configuration dialog, from which you could create a new local storage resource, is by using the following steps: Right-click the role in the **Project Explorer** view (expand your Azure project node if you don't see the role), click **Azure**, and then click **Local Storage**. Within the **Local Storage** dialog, click **Add** to create a new local storage resource.
2. Set the desired size to at least 2048 MB (anything less may cause the same file size problems as you would encounter in the approot).
3. Ensure that **Clean the contents when the role instance is recycled** is checked; this will help prevent the deployment's startup logic from running into conflicts with pre-existing files in the resource when the role instance is recycled.
4. Ensure that the **Environment variable storing the resource's directory path after deployment** value is set to the string **DEPLOYROOT**. Your local storage resource dialog will look similar to the following.
    ![](./media/azure-toolkit-for-eclipse-deploying-large-deployments/ic667943.png)

Alternatively, if you use **DEPLOYROOT** as the *name* of your local resource and you do not change the automatically-generated environment variable name (which will be set to **DEPLOYROOT_PATH** in that case), that would work for your application as well.

Additional information about creating a local storage resource can be found at [Local storage properties](http://go.microsoft.com/fwlink/?LinkID=699525#local_storage_properties).

## See Also
[Azure Toolkit for Eclipse](http://go.microsoft.com/fwlink/?LinkID=699529)

[Creating a Hello World Application for Azure in Eclipse](http://go.microsoft.com/fwlink/?LinkID=699533)

[Installing the Azure Toolkit for Eclipse](http://go.microsoft.com/fwlink/?LinkId=699546) 

For more information about using Azure with Java, see the [Azure Java Developer Center](http://go.microsoft.com/fwlink/?LinkID=699547).

<!-- URL List -->

[Azure Java Developer Center]: http://go.microsoft.com/fwlink/?LinkID=699547
[Azure Toolkit for Eclipse]: http://go.microsoft.com/fwlink/?LinkID=699529
[Creating a Hello World Application for Azure in Eclipse]: http://go.microsoft.com/fwlink/?LinkID=699533
[Installing the Azure Toolkit for Eclipse]: http://go.microsoft.com/fwlink/?LinkId=699546
[Local storage properties]: http://go.microsoft.com/fwlink/?LinkID=699525#local_storage_properties

<!-- IMG List -->

[ic667943]: ./media/azure-toolkit-for-eclipse-deploying-large-deployments/ic667943.png
