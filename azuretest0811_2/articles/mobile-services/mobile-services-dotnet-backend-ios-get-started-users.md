---
title: Add Authentication to Existing Azure Mobile Services App (iOS) | .NET Backend | Microsoft Azure
description: Learn how to use Mobile Services to authenticate users of your iOS app through a variety of identity providers, including Google, Facebook, Twitter, and Microsoft.
services: mobile-services
documentationcenter: ios
author: krisragh
manager: erikre
editor: ''

ms.service: mobile-services
ms.workload: mobile
ms.tgt_pltfrm: mobile-ios
ms.devlang: objective-c
ms.topic: article
ms.date: 07/21/2016
ms.author: krisragh

---
# Add Authentication to Existing Azure Mobile Services app
[!INCLUDE [mobile-services-selector-get-started-users](../../includes/mobile-services-selector-get-started-users.md)]

&nbsp;

[!INCLUDE [mobile-service-note-mobile-apps](../../includes/mobile-services-note-mobile-apps.md)]

> For the equivalent Mobile Apps version of this topic, see [Add authentication to your iOS app](../app-service-mobile/app-service-mobile-ios-get-started-users.md).
> 
> 

In this tutorial, you add authentication to the Quick Start project using a supported identity provider. This tutorial is based on the [Mobile Services Quick Start tutorial](mobile-services-dotnet-backend-ios-get-started.md), which you must complete first.

## <a name="register"></a>Register app for authentication and configure Mobile Services
[!INCLUDE [mobile-services-register-authentication](../../includes/mobile-services-register-authentication.md)]

[!INCLUDE [mobile-services-dotnet-backend-aad-server-extension](../../includes/mobile-services-dotnet-backend-aad-server-extension.md)]

## <a name="permissions"></a>Restrict permissions to authenticated users
[!INCLUDE [mobile-services-restrict-permissions-dotnet-backend](../../includes/mobile-services-restrict-permissions-dotnet-backend.md)]

In Xcode, open the project. Press the **Run** button to  start the app. Verify that an exception with a status code of 401 (Unauthorized) is raised after the app starts. This happens because the app attempts to access Mobile Services as an unauthenticated user, but the *TodoItem* table now requires authentication.

## <a name="add-authentication"></a>Add authentication to app
[!INCLUDE [mobile-services-ios-authenticate-app](../../includes/mobile-services-ios-authenticate-app.md)]

## <a name="store-authentication"></a>Store authentication tokens in app
[!INCLUDE [mobile-services-ios-authenticate-app-with-token](../../includes/mobile-services-ios-authenticate-app-with-token.md)]

## <a name="next-steps"></a>Next steps
In the next tutorial, [Service-side authorization of Mobile Services users](mobile-services-dotnet-backend-service-side-authorization.md), you will user the user ID value to filter returned data.

<!-- Anchors. -->
[Register your app for authentication and configure Mobile Services]: #register
[Restrict table permissions to authenticated users]: #permissions
[Add authentication to the app]: #add-authentication
[Next Steps]:#next-steps
[Storing authentication tokens in your app]:#store-authentication

<!-- URLs. -->
[Service-side authorization of Mobile Services users]: mobile-services-dotnet-backend-service-side-authorization.md
[Mobile Services Quick Start tutorial]: mobile-services-dotnet-backend-ios-get-started.md
[Get started with authentication]: mobile-services-dotnet-backend-ios-get-started-users.md
[Get started with push notifications]: mobile-services-dotnet-backend-ios-get-started-push.md
[Authorize users with scripts]: mobile-services-dotnet-backend-service-side-authorization.md
[Mobile Services .NET How-to Conceptual Reference]: /develop/mobile/how-to-guides/work-with-net-client-library
[Register your Windows Store app package for Microsoft authentication]: ../mobile-services-how-to-register-store-app-package-microsoft-authentication.md
