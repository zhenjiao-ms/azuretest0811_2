
---
title: Azure Guidance | patterns & practices | Microsoft Azure
description: Best practices and guidance for Azure
services: ''
documentationcenter: na
author: bennage
manager: marksou
editor: ''
tags: ''

ms.service: guidance
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: na
ms.date: 06/29/2016
ms.author: christb

---
# Azure Guidance
[!INCLUDE [pnp-header](../../includes/guidance-pnp-header-include.md)]

The Microsoft patterns & practices team is part of the Azure Customer Advisory Team. Our purpose is to help developers, architects, and IT professionals be successful on the Microsoft Azure platform. We develop guidance that shows best practices for building cloud solutions on Azure.

## Checklists
These lists are a quick reference for reviewing the fundamental aspects of availability and scalability. 

* [Availability Checklist](../best-practices-availability-checklist.md) 
  
    A summary of recommended practices for ensuring resiliency and availability.
* [Scalability Checklist](../best-practices-scalability-checklist.md)
  
    A summary of recommended practices for designing and implementing scalable services and handling data management.

## Best practices articles
These articles provide an in-depth discussion of important concepts commonly associated with cloud computing. 

* [API Design](../best-practices-api-design.md) 
  
    A discussion of design issues to consider when designing a web API.
* [API Implementation](../best-practices-api-implementation.md) 
  
    A set of recommended practices for implementing and publishing a web API.
* [API security guidance](https://github.com/mspnp/azure-guidance/blob/master/API-security.md) 
  
    A discussion of authentication and authorization concerns (e.g., token types, authorization protocols, authorization flows and threat mitigation).
* [Autoscaling guidance](../best-practices-auto-scaling.md) 
  
    A summary of considerations for taking advantage of the elasticity of cloud-hosted environments without the need for manual intervention.
* [Background Jobs guidance](../best-practices-background-jobs.md) 
  
    A description of available options and recommended practices for implementing tasks that should be performed in the background, independently from any foreground or interactive operations.
* [Content Delivery Network (CDN) guidance](../best-practices-cdn.md) 
  
    General guidance and recommended practice for using the CDN to minimize the load on your applications, and maximize availability and performance.
* [Caching guidance](../best-practices-caching.md) 
  
    A summary of how to use caching to improve the performance and scalability of a system.
* [Data Partitioning guidance](../best-practices-data-partitioning.md)
  
    Strategies that you can use to partition data to improve scalability, reduce contention, and optimize performance.
* [Monitoring and Diagnostics guidance](../best-practices-monitoring.md) 
  
    Guidance on how to track the way in which users utilize your system, trace resource utilization, and generally monitor the health and performance of your system.
* [Recommended naming conventions](guidance-naming-conventions.md) 
  
    Recommended naming conventions for Azure resources.
* [Retry General guidance](../best-practices-retry-general.md) 
  
    Discussion of the general concepts for handling transient faults.
* [Retry Service-specific guidance](../best-practices-retry-service-specific.md)
  
    A summary of retry features for many of Azure services, including information to help you use, adapt, or extend the retry mechanism for that service.

## Scenario guides
* [Running Elasticsearch on Azure](guidance-elasticsearch.md) 
  
    Elasticsearch is a highly scalable open-source search engine and database. It is suitable for situations that require fast analysis and discovery of information held in big datasets. This guidance looks at some key aspects to consider when designing an Elasticsearch cluster.
* [Identity management for multitenant applications](guidance-multitenant-identity.md) 
  
    Multitenancy is an architecture where multiple tenants share the same app but are isolated from one another. This guidance will show you how to manage user identities in a multitenant application, using [Azure Active Directory](https://azure.microsoft.com/documentation/services/active-directory/) to handle sign-in and authentication.
* [Developing big data solutions](https://msdn.microsoft.com/library/dn749874.aspx)
  
    This guide explores the use of HDInsight in a range of use cases and scenarios such as iterative exploration, as a data warehouse, for ETL processes, and integration into existing BI systems. It also includes guidance on understanding the concepts of big data, planning and designing big data solutions, and implementing these solutions.

## Patterns
* [Cloud Design Patterns: Prescriptive Architecture Guidance for Cloud Applications](https://msdn.microsoft.com/library/dn568099.aspx)
  
    Cloud Design Patterns is a library of design patterns and related guidance topics. It articulates the benefit of applying patterns by showing how each piece can fit into the big picture of cloud application architectures.
* [Optimizing Performance for Cloud Applications](https://github.com/mspnp/performance-optimization)
  
    This guidance is an exploration of common anti-patterns that impede apps from scaling under load. It includes samples demonstratraing 8 anti-patterns as well as a [performance analysis primer](https://github.com/mspnp/performance-optimization/blob/master/Performance-Analysis-Primer.md) and a guide for [assessing performance against key metrics](https://github.com/mspnp/performance-optimization/blob/master/Assessing-System-Performance-Against-KPI.md).

## Under development
We're creating a new set of guidance we're calling *reference architectures*. Each reference architecture offers recommended practices and prescriptive steps for infrastructure-oriented scenarios. We're actively developing these reference architectures, and some are available for preview. We're very intereseted in your feedback.

Running virtual machines on Azure:

* [Running a Windows VM on Azure](guidance-compute-single-vm.md)
* [Running a Linux VM on Azure](guidance-compute-single-vm-linux.md)
* [Running multiple VMs for scalability and availability](guidance-compute-multi-vm.md)
* [Running VMs for an N-tier architecture](guidance-compute-3-tier-vm.md)
* [Adding reliability to an N-tier architecture (Windows)](guidance-compute-n-tier-vm.md)
* [Adding reliability to an N-tier architecture (Linux)](guidance-compute-n-tier-vm-linux.md)
* [Running VMs in multiple regions for high availability (Windows)](guidance-compute-multiple-datacenters.md)
* [Running VMs in multiple regions for high availability (Linux)](guidance-compute-multiple-datacenters-linux.md)

Hybrid network architectures:

* [Implementing a hybrid network architecture with Azure and on-premises VPN](guidance-hybrid-network-vpn.md)
* [Implementing a hybrid network architecture with Azure ExpressRoute](guidance-hybrid-network-expressroute.md)
* [Implementing a highly available hybrid network architecture](guidance-hybrid-network-expressroute-vpn-failover.md)
* [Implementing a DMZ between Azure and your on-premises datacenter](guidance-iaas-ra-secure-vnet-hybrid.md)
* [Implementing a DMZ between Azure and the Internet](guidance-iaas-ra-secure-vnet-dmz.md)

Web applications (PaaS):

* [Basic web application](guidance-web-apps-basic.md)
* [Improving scalability in a web application](guidance-web-apps-scalability.md)
* [Web application with high availability](guidance-web-apps-multi-region.md)

[AzureAD]: https://azure.microsoft.com/documentation/services/active-directory/

[PerformanceOptimization]: https://github.com/mspnp/performance-optimization

[APIDesign]: ../best-practices-api-design.md
[APIImplementation]: ../best-practices-api-implementation.md
[AutoscalingGuidance]: ../best-practices-auto-scaling.md
[BackgroundJobsGuidance]: ../best-practices-background-jobs.md
[CDNGuidance]: ../best-practices-cdn.md
[CachingGuidance]: ../best-practices-caching.md
[DataPartitioningGuidance]: ../best-practices-data-partitioning.md
[MonitoringandDiagnosticsGuidance]: ../best-practices-monitoring.md
[RetryGeneralGuidance]: ../best-practices-retry-general.md
[RetryServiceSpecificGuidance]: ../best-practices-retry-service-specific.md
[RetryPolicies]: Retry-Policies.md
[ScalabilityChecklist]: ../best-practices-scalability-checklist.md
[AvailabilityChecklist]: ../best-practices-availability-checklist.md
[naming-conventions]: guidance-naming-conventions.md

<!-- guidance projects -->
[elasticsearch]: guidance-elasticsearch.md
[identity-multitenant]: guidance-multitenant-identity.md

<!-- reference architectures -->
[ref-arch-single-vm-windows]: guidance-compute-single-vm.md
[ref-arch-single-vm-linux]: guidance-compute-single-vm-linux.md
[ref-arch-multi-vm]: guidance-compute-multi-vm.md
[ref-arch-3-tier]: guidance-compute-3-tier-vm.md
[ref-arch-n-tier-windows]: guidance-compute-n-tier-vm.md
[ref-arch-n-tier-linux]: guidance-compute-n-tier-vm-linux.md
[ref-arch-multi-dc-windows]: guidance-compute-multiple-datacenters.md
[ref-arch-multi-dc-linux]: guidance-compute-multiple-datacenters-linux.md
