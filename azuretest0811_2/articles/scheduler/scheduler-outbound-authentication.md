---
title: Scheduler Outbound Authentication
description: Scheduler Outbound Authentication
services: scheduler
documentationcenter: .NET
author: krisragh
manager: dwrede
editor: ''

ms.service: scheduler
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.devlang: dotnet
ms.topic: article
ms.date: 06/30/2016
ms.author: krisragh

---
# Scheduler Outbound Authentication
Scheduler jobs may need to call out to services that require authentication. This way, a called service can determine if the Scheduler job can access its resources. Some of these services include other Azure services, Salesforce.com, Facebook, and secure custom websites.

## Adding and Removing Authentication
Adding authentication to a Scheduler job is simple – add a JSON child element `authentication` to the `request` element when creating or updating a job. Secrets passed to the Scheduler service in a PUT, PATCH, or POST request – as part of the `authentication` object – are never returned in responses. In responses, secret information is set to null or may have a public token that represents the authenticated entity.

To remove authentication, PUT or PATCH the job explicitly, setting the `authentication` object to null. You will not see any authentication properties back in response.

Currently, the only supported authentication types are the `ClientCertificate` model (for using the SSL/TLS client certificates), the `Basic` model (for Basic authentication), and the `ActiveDirectoryOAuth` model (for Active Directory OAuth authentication.)

## Request Body for ClientCertificate Authentication
When adding authentication using the `ClientCertificate` model, specify the following additional elements in the request body.  

| Element | Description |
|:--- |:--- |
| *authentication (parent element)* |Authentication object for using an SSL client certificate. |
| *type* |Required. Type of authentication.For SSL client certificates, the value must be `ClientCertificate`. |
| *pfx* |Required. Base64-encoded contents of the PFX file. |
| *password* |Required. Password to access the PFX file. |

## Response Body for ClientCertificate Authentication
When a request is sent with authentication info, the response contains the following authentication-related elements.

| Element | Description |
|:--- |:--- |
| *authentication (parent element)* |Authentication object for using an SSL client certificate. |
| *type* |Type of authentication. For SSL client certificates, the value is `ClientCertificate`. |
| *certificateThumbprint* |The thumbprint of the certificate. |
| *certificateSubjectName* |The subject distinguished name of the certificate. |
| *certificateExpiration* |The expiration date of the certificate. |

## Request Body for Basic Authentication
When adding authentication using the `Basic` model, specify the following additional elements in the request body.

| Element | Description |
|:--- |:--- |
| *authentication (parent element)* |Authentication object for using Basic authentication. |
| *type* |Required. Type of authentication. For Basic authentication, the value must be `Basic`. |
| *username* |Required. Username to authenticate. |
| *password* |Required. Password to authenticate. |

## Response Body for Basic Authentication
When a request is sent with authentication info, the response contains the following authentication-related elements.

| Element | Description |
|:--- |:--- |
| *authentication (parent element)* |Authentication object for using Basic authentication. |
| *type* |Type of authentication. For Basic authentication, the value is `Basic`. |
| *username* |The authenticated username. |

## Request Body for ActiveDirectoryOAuth Authentication
When adding authentication using the `ActiveDirectoryOAuth` model, specify the following additional elements in the request body.

| Element | Description |
|:--- |:--- |
| *authentication (parent element)* |Authentication object for using ActiveDirectoryOAuth authentication. |
| *type* |Required. Type of authentication. For ActiveDirectoryOAuth authentication, the value must be `ActiveDirectoryOAuth`. |
| *tenant* |Required. The tenant identifier for the Azure AD tenant. |
| *audience* |Required. This is set to https://management.core.windows.net/. |
| *clientId* |Required. Provide the client identifier for the Azure AD application. |
| *secret* |Required. Secret of the client that is requesting the token. |

### Determining your Tenant Identifier
You can find the tenant identifier for the Azure AD tenant by running `Get-AzureAccount` in Azure PowerShell.

## Response Body for ActiveDirectoryOAuth Authentication
When a request is sent with authentication info, the response contains the following authentication-related elements.

| Element | Description |
|:--- |:--- |
| *authentication (parent element)* |Authentication object for using ActiveDirectoryOAuth authentication. |
| *type* |Type of authentication. For ActiveDirectoryOAuth authentication, the value is `ActiveDirectoryOAuth`. |
| *tenant* |The tenant identifier for the Azure AD tenant. |
| *audience* |This is set to https://management.core.windows.net/. |
| *clientId* |The client identifier for the Azure AD application. |

## See Also
 [What is Scheduler?](scheduler-intro.md)

 [Azure Scheduler concepts, terminology, and entity hierarchy](scheduler-concepts-terms.md)

 [Get started using Scheduler in the Azure portal](scheduler-get-started-portal.md)

 [Plans and billing in Azure Scheduler](scheduler-plans-billing.md)

 [Azure Scheduler REST API reference](https://msdn.microsoft.com/library/mt629143)

 [Azure Scheduler PowerShell cmdlets reference](scheduler-powershell-reference.md)

 [Azure Scheduler high-availability and reliability](scheduler-high-availability-reliability.md)

 [Azure Scheduler limits, defaults, and error codes](scheduler-limits-defaults-errors.md)

