---
title: What happened to my ASP.NET project? | Microsoft Azure | Visual Studio connected services
description: Describes what happens after adding Azure Storage to a ASP.NET project using Visual Studio connected services
services: storage
documentationcenter: ''
author: TomArcher
manager: douge
editor: ''

ms.service: storage
ms.workload: web
ms.tgt_pltfrm: vs-what-happened
ms.devlang: na
ms.topic: article
ms.date: 05/08/2016
ms.author: tarcher

---
# What happened to my ASP.NET project (Visual Studio Azure Storage connected service)?
## References added
The Azure Storage NuGet package was added to your Visual Studio project.  
This package adds the following .NET references:

* **Microsoft.Data.Edm**
* **Microsoft.Data.OData**
* **Microsoft.Data.Services.Client**
* **Microsoft.WindowsAzure.Configuration**
* **Microsoft.WindowsAzure.Storage**
* **Newtonsoft.Json**
* **System.Data**
* **System.Spatial**

## Connection string for Azure Storage added
In the web.config file of your project, an element was created with the selected storage account's connection string and key.

For more information, see [ASP.NET](http://www.asp.net).

