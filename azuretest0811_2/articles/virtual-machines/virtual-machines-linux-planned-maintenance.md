---
title: Planned maintenance for Linux VMs | Microsoft Azure
description: Understand what Azure planned maintenance is and how it affects your Linux virtual machines running in Azure
services: virtual-machines-linux
documentationcenter: ''
author: drewm
manager: timlt
editor: ''
tags: azure-service-management,azure-resource-manager

ms.service: virtual-machines-linux
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: na
ms.topic: article
ms.date: 04/26/2016
ms.author: drewm

---
# Planned maintenance for Linux virtual machines in Azure
Understand what Azure planned maintenance is and how it can affect the availability of your Linux virtual machines. This article is also available for [Windows virtual machines](virtual-machines-windows-planned-maintenance.md). 

This article provides a background as to the Azure planned maintenance process. If you are wanting to troubleshoot why your VM rebooted, you can [read this blog post detailing viewing VM reboot logs](https://azure.microsoft.com/blog/viewing-vm-reboot-logs/).

[!INCLUDE [learn-about-deployment-models](../../includes/learn-about-deployment-models-both-include.md)]

## Why Azure performs planned maintenance
Microsoft Azure periodically performs updates across the globe to improve the reliability, performance, and security of the host infrastructure that underlies virtual machines. Many of these updates are performed without any impact to your virtual machines or Cloud Services, including memory-preserving updates.

However, some updates do require a reboot to your virtual machines to apply the required updates to the infrastructure. The virtual machines are shut down while we patch the infrastructure, and then the virtual machines are restarted.

Please note that there are two types of maintenance that can impact the availability of your virtual machines: planned and unplanned. This page describes how Microsoft Azure performs planned maintenance. For more information about unplanned maintenance, see [Understand planned versus unplanned maintenance](virtual-machines-linux-manage-availability.md).

[!INCLUDE [virtual-machines-common-planned-maintenance](../../includes/virtual-machines-common-planned-maintenance.md)]

