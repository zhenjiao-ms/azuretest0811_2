---
title: Introduction to Linux in Azure | Microsoft Azure
description: Learn about using Linux virtual machines on Azure.
services: virtual-machines-linux
documentationcenter: python
author: szarkos
manager: timlt
editor: ''
tags: azure-resource-manager,azure-service-management

ms.service: virtual-machines-linux
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: na
ms.topic: article
ms.date: 05/27/2016
ms.author: szark

---
# Introduction to Linux on Azure
This topic provides an overview of some aspects of using Linux virtual machines in the Azure cloud. Deploying a Linux virtual machine is a straightforward process using an image from the gallery.

## Authentication: Usernames, Passwords and SSH Keys
When creating a Linux virtual machine using the Azure classic portal, you are asked to provide a username, password or an SSH public key. The choice of a username for deploying a Linux virtual machine on Azure is subject to the following constraint: names of system accounts (UID <100) already present in the virtual machine are not allowed, 'root' for example.

* See [Create a Virtual Machine Running Linux](virtual-machines-linux-quick-create-cli.md)
* See [How to Use SSH with Linux on Azure](virtual-machines-linux-ssh-from-linux.md)

## Obtaining Superuser Privileges Using `sudo`
The user account that is specified during virtual machine instance deployment on Azure is a privileged account. This account is configured by the Azure Linux Agent to be able to elevate privileges to root (superuser account) using the `sudo` utility. Once logged in using this user account, you will be able to run commands as root using the command syntax

    # sudo <COMMAND>

You can optionally obtain a root shell using **sudo -s**.

* See [Using root privileges on Linux virtual machines in Azure](virtual-machines-linux-use-root-privileges.md)

## Firewall Configuration
Azure provides an inbound packet filter that restricts connectivity to ports specified in the Azure classic portal. By default, the only allowed port is SSH. You may open up access to additional ports on your Linux virtual machine by configuring endpoints in the Azure classic portal:

* See: [How to Set Up Endpoints to a Virtual Machine](virtual-machines-windows-classic-setup-endpoints.md)

The Linux images in the Azure Gallery do not enable the *iptables* firewall by default. If desired, the firewall may be configured to provide additional filtering.

## Hostname Changes
When you initially deploy an instance of a Linux image, you are required to provide a host name for the virtual machine. Once the virtual machine is running, this hostname is published to the platform DNS servers so that multiple virtual machines connected to each other can perform IP address lookups using hostnames.

If hostname changes are desired after a virtual machine has been deployed, please use the command

    # sudo hostname <newname>

The Azure Linux Agent includes functionality to automatically detect this name change and appropriately configure the virtual machine to persist this change and publish this change to the platform DNS servers.

* [Azure Linux Agent User Guide](virtual-machines-linux-agent-user-guide.md)

### Cloud-Init
**Ubuntu** and **CoreOS** images utilize cloud-init on Azure, which provides additional capabilities for bootstrapping a virtual machine.

* [How to Inject Custom Data](virtual-machines-windows-classic-inject-custom-data.md)
* [Custom Data and Cloud-Init on Microsoft Azure](https://azure.microsoft.com/blog/2014/04/21/custom-data-and-cloud-init-on-windows-azure/)
* [Create Azure Swap Partitions Using Cloud-Init](https://wiki.ubuntu.com/AzureSwapPartitions)
* [How to Use CoreOS on Azure](https://coreos.com/os/docs/latest/booting-on-azure.html)

## Virtual Machine Image Capture
Azure provides the ability to capture the state of an existing virtual machine into an image that can subsequently be used to deploy additional virtual machine instances. The Azure Linux Agent may be used to rollback some of the customization that was performed during the provisioning process. You may follow the steps below to capture a virtual machine as an image:

1. Run **waagent -deprovision** to undo provisioning customization. Or **waagent -deprovision+user** to optionally, delete the user account specified during provisioning and all associated data.
2. Shut down/power off the virtual machine.
3. Click *Capture* in the Azure classic portal or use the Powershell or CLI tools to capture the virtual machine as an image.
   
   * See: [How to Capture a Linux Virtual Machine to Use as a Template](virtual-machines-linux-classic-capture-image.md)

## Attaching Disks
Each virtual machine has a temporary, local *resource disk* attached. Because data on a resource disk may not be durable across reboots, it is often used by applications and processes running in the virtual machine for transient and **temporary** storage of data. It is also used to store the page or swap files for the operating system.

On Linux, the resource disk is typically managed by the Azure Linux Agent and automatically mounted to **/mnt/resource** (or **/mnt** on Ubuntu images).

> [!NOTE]
> Note that the resource disk is a **temporary** disk, and might be deleted and reformatted when the VM is rebooted.
> 
> 

On Linux the data disk might be named by the kernel as `/dev/sdc`, and users will need to partition, format and mount that resource. This is covered step-by-step in the tutorial: [How to Attach a Data Disk to a Virtual Machine](virtual-machines-linux-classic-attach-disk.md).

* **See also:** [Configure Software RAID on Linux](virtual-machines-linux-configure-raid.md)

