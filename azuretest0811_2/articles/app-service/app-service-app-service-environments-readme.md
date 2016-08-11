---
title: App Service Environment | Microsoft Azure
description: What is an Azure App Service Environment? An introduction to App Service Environment.
keywords: azure app service environment, virtual network, secure networking
services: app-service
documentationcenter: ''
author: yochay
manager: wpickett
editor: ''

ms.service: app-service
ms.workload: na
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 07/15/2016
ms.author: stefsch

---
# App Service Environment Documentation
An App Service Environment is a [Premium](http://azure.microsoft.com/pricing/details/app-service/) service plan option of Azure App Service that provides a fully isolated and dedicated environment for securely running Azure App Service apps at high scale, including [Web Apps](http://azure.microsoft.com/documentation/articles/app-service-web-overview/), [Mobile Apps](http://azure.microsoft.com/documentation/articles/app-service-mobile-value-prop-preview/), and [API Apps](http://azure.microsoft.com/documentation/articles/app-service-api-apps-why-best-platform/).  

App Service Environments are ideal for application workloads requiring:

* Very high scale
* Isolation and secure network access

Customers can create multiple App Service Environments within a single Azure region, as well as across multiple Azure regions.  This makes App Service Environments ideal for horizontally scaling state-less application tiers in support of high RPS workloads.

App Service Environments are isolated to running only a single customer's applications, and are always deployed into a virtual network.  Customers have fine-grained control over both inbound and outbound application network traffic using [network security groups](https://azure.microsoft.com/documentation/articles/virtual-networks-nsg/).  Applications can also establish high-speed secure connections over virtual networks to on-premises corporate resources.

Apps frequently need to access corporate resources such as internal databases and web services.  Apps running on App Service Environments can access resources reachable via [Site-to-Site](https://azure.microsoft.com/documentation/articles/vpn-gateway-site-to-site-create/) VPN and [Azure ExpressRoute](http://azure.microsoft.com/services/expressroute/) connections.

* [What is an App Service Environment?](../app-service-web/app-service-app-service-environment-intro.md)
* [Creating an App Service Environment](../app-service-web/app-service-web-how-to-create-an-app-service-environment.md)
* [Creating Apps in an App Service Environment](../app-service-web/app-service-web-how-to-create-a-web-app-in-an-ase.md)
* [Creating and Using an Internal Load Balancer with App Service Environments](../app-service-web/app-service-environment-with-internal-load-balancer.md)
* [Configuring an App Service Environment](../app-service-web/app-service-web-configure-an-app-service-environment.md) 
* [Scaling Apps in an App Service Environment](../app-service-web/app-service-web-scale-a-web-app-in-an-app-service-environment.md)
* [Network Security and Architecture](../app-service-web/app-service-app-service-environment-network-architecture-overview.md)

## How Tos
[!INCLUDE [app-service-blueprint-app-service-environment](../../includes/app-service-blueprint-app-service-environment.md)]

## Videos
[!VIDEO https://channel9.msdn.com/Events/Microsoft-Azure/AzureCon-2015/ACON325/player]


[!VIDEO https://channel9.msdn.com/Events/Ignite/2015/BRK3715/player]



<!-- LINKS -->
[PremiumTier]: http://azure.microsoft.com/pricing/details/app-service/
[WebApps]: http://azure.microsoft.com/documentation/articles/app-service-web-overview/
[MobileApps]: http://azure.microsoft.com/documentation/articles/app-service-mobile-value-prop-preview/
[APIApps]: http://azure.microsoft.com/documentation/articles/app-service-api-apps-why-best-platform/
[NetworkSecurityGroups]: https://azure.microsoft.com/documentation/articles/virtual-networks-nsg/
[SiteToSite]: https://azure.microsoft.com/documentation/articles/vpn-gateway-site-to-site-create/
[ExpressRoute]: http://azure.microsoft.com/services/expressroute/
