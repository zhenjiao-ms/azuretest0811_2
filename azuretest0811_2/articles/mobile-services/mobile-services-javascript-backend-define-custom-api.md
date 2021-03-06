---
title: How to define a custom API in a JavaScript backend mobile service | Azure Mobile Services
description: Learn how to define a custom API endpoint in a JavaScript backend mobile service.
services: mobile-services
documentationcenter: ''
author: ggailey777
manager: erikre
editor: ''

ms.service: mobile-services
ms.workload: mobile
ms.tgt_pltfrm: mobile-multiple
ms.devlang: javascript
ms.topic: article
ms.date: 07/21/2016
ms.author: glenga

---
# How to: define a custom API endpoint in a JavaScript backend mobile service
> [!div class="op_single_selector"]
> * [JavaScript backend](mobile-services-javascript-backend-define-custom-api.md)
> * [.NET backend](mobile-services-dotnet-backend-define-custom-api.md)
> 
> 

&nbsp;

[!INCLUDE [mobile-service-note-mobile-apps](../../includes/mobile-services-note-mobile-apps.md)]

> For the equivalent Mobile Apps version of this topic, see [How to: Define a custom API controller](../app-service-mobile/app-service-mobile-node-backend-how-to-use-server-sdk.md#CustomAPI).
> 
> 

This topic shows you how to define a custom API endpoint in a JavaScript backend mobile service. A custom API lets you define custom endpoints with server functionality, but it does not map to a database insert, update, delete, or read operation. By using a custom API, you have more control over messaging, including HTTP headers and body format.

[!INCLUDE [mobile-services-create-custom-api](../../includes/mobile-services-create-custom-api.md)]

For information on how to invoke a custom API in your app using a Mobile Services client library, see [Call a custom API](mobile-services-windows-dotnet-how-to-use-client-library.md#custom-api) in the client SDK reference.

<!-- Anchors. -->

<!-- Images. -->

<!-- URLs. -->

