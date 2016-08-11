---
title: App Registration Portal Help Topics | Microsoft Azure
description: A description of various features in the Microsoft app registration portal.
services: active-directory
documentationcenter: ''
author: dstrockis
manager: mbaldwin
editor: ''

ms.service: active-directory
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/31/2016
ms.author: dastrock

---
# App registration reference
This document provides context and descriptions of various features found in the Microsoft App Registration Portal [https://apps.dev.microsoft.com](https://apps.dev.microsoft.com).

## My Applications
This list contains all of your applications registered for use with the Azure AD v2.0 endpoint.  These applications have the ability to sign in users with both personal accounts from Microsoft account and work/school accounts from Azure Active Directory.  To learn more about the Azure AD v2.0 endpoint, see our [v2.0 overview](active-directory-appmodel-v2-overview.md).  These applications can also be used to integrate with the Microsoft account authentication endpoint, `https://login.live.com`.

## Live SDK Applications
This list contains all of your applications registered for use solely with Microsoft account.  They are not enabled for use with Azure Active Directory whatsoever.  This is where you will find any applications that had previously been registered with the MSA developer portal at `https://account.live.com/developers/applications`.  All functions that you previously performed at `https://account.live.com/developers/applications` can now be performed in this new portal, `https://apps.dev.microsoft.com`.  If you have any further questions about your Microsoft account applications, please contact us.

## Application Secrets
Application secrets are credentials that allow your application to perform reliable [client authentication](http://tools.ietf.org/html/rfc6749#section-2.3) with Azure AD.  In OAuth & OpenID Connect, an application secrets is commonly referred to as a `client_secret`.  In the v2.0 protocol, any application that receives a security token at a web addressable location (using an `https` scheme) must use an application secret to identify itself to Azure AD upon redemption of that security token.  Furthermore, any native client that recieves tokens on a device will be forbidden from using an application secret to perform client authentication, to discourage the storage of secrets in insecure environments.

Each app can contain two valid application secrets at any given point in time.  By maintaining two secrets, you have the ablilty to perform periodic key rollover across your application's entire environment.  Once you have migrated the entirety of your application to a new secret, you may delete the old secret and provision a new one.

At this time, only two types of application secrets are permitted in the app registration portal.  Choosing **Generate New Password** will generate and store a shared secret in the respective data store, which you can use in your application.  Choosing **Generate New Key Pair** will create a new public/private key pair that can be downloaded and used for client authentication to Azure AD.

## Profile
The profile section of the app registration portal can be used to customize the sign in page for your application.  At this time you can alter the sign in page's application logo, terms of service URL, and privacy statement.  The logo must be a transparent 48 x 48 or 50 x 50 pixel image in a GIF, PNG or JPEG file that is 15 KB or smaller.  Try changing the values and viewing the resulting sign in page!

## Live SDK Support
When you enable "Live SDK Support", any application secrets you create will be provisioned into both the Azure AD and Microsoft Account data stores.  This will allow your application to integrate directly with the Microsoft Account service (login.live.com).  If you wish to build an app using Microsoft Account directly (as opposed to using the Azure AD v2.0 endpoint), you should make sure that Live SDK Support is enabled.

Disabling Live SDK support will ensure that the application secret is only written into the Azure AD data store.  The Azure AD data store incorporates enterprise-grade regulations that allow it to meet certain standards, such as FISMA compliance.  If you enable Live SDK support, your application may not achieve compliance with some of these standards.

If you only ever plan to use the Azure AD v2.0 endpoint, you can safely disable Live SDK support.

