---
title: Failover in Site Recovery | Microsoft Azure
description: Azure Site Recovery coordinates the replication, failover and recovery of virtual machines and physical servers. Learn about failover to Azure or a secondary datacenter.
services: site-recovery
documentationcenter: ''
author: rayne-wiselman
manager: jwhit
editor: ''

ms.service: site-recovery
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: storage-backup-recovery
ms.date: 07/12/2016
ms.author: raynew

---
# Failover in Site Recovery
The Azure Site Recovery service contributes to your business continuity and disaster recovery (BCDR) strategy by orchestrating replication, failover and recovery of virtual machines and physical servers. Machines can be replicated to Azure, or to a secondary on-premises data center. For a quick overview read [What is Azure Site Recovery?](site-recovery-overview.md)

## Overview
This article provides information and instructions for recovering (failing over and failing back) virtual machines and physical servers that are protected with Site Recovery. 

Post any comments or questions at the bottom of this article, or on the [Azure Recovery Services Forum](https://social.msdn.microsoft.com/forums/azure/home?forum=hypervrecovmgr).

## Types of failover
After protection is enabled for virtual machines and physical servers and they're replicating you can run failovers as the need arises. Site Recovery supports a number of types of failover.

| **Failover** | **When to run** | **Details** | **Process** |
| --- | --- | --- | --- |
| **Test failover** |Run to validate your replication strategy or perform a disaster recovery drill |No data loss or downtime.<br/><br/>No impact on replication<br/><br/>No impact on your production environment |Start the failover<br/><br/>Specify how test machines will be connected to networks after failover<br/><br/>Track progress on the **Jobs** tab. Test machines are created and start in the secondary location<br/><br/>Azure - connect to the machine in the Azure portal<br/><br/>Secondary site - access the machine on the same host and cloud<br/><br/>Complete testing and automatically clean up test failover settings. |
| **Planned failover** |Run to meet compliance requirements<br/><br/>Run for planned maintenance<br/><br/>Run to fail over data to keep workloads running for known outages - such as an expected power failure or severe weather reports<br/><br/>Run to failback after failover from primary to secondary |No data loss<br/><br/>Downtime is incurred during the time it takes to shut down the virtual machine on the primary and bring it up on the secondary location.<br/><br/>Virtual machines are impact as  target machines becomes source machines after failover. |Start the failover<br/><br/>Track progress on the **Jobs** tab. Source machines are shut down<br/><br/>Replica machines start in the secondary location<br/><br/>Azure - connect to the replica machine in the Azure portal<br/><br/>Secondary site - access the machine on the same host and in the same cloud<br/><br/>Commit the failover |
| **Unplanned failover** |Run this type of failover in a reactive manner when a primary site becomes inaccessible because of an unexpected incident, such as a power outage or virus attack <br/><br/> You can run an unplanned failover can be done even if primary site isn't available. |Data loss dependent on replication frequency settings<br/><br/>Data will be up-to-date in accordance with the last time it was synchronized |Start the failover<br/><br/>Track progress on the **Jobs** tab. Optionally try to shut down virtual machines and synchronize latest data<br/><br/>Replica machines start in the secondary location<br/><br/>Azure - connect to the replica machine in the Azure portal<br/><br/>Secondary site access the machine on the same host and in the same cloud<br/><br/>Commit the failover |

The types of failovers that are supported depend on your deployment scenario.

| **Failover direction** | **Test failover** | **Planned failover** | **Unplanned failover** |
| --- | --- | --- | --- |
| Primary VMM site to Secondary VMM site |Supported |Supported |Supported  |
| Secondary VMM site to Primary VMM site |Supported |Supported |Supported |
| Cloud to Cloud (single VMM server) |Supported |Supported |Supported |
| VMM site to Azure |Supported |Supported |Supported  |
| Azure to VMM site |Unsupported |Supported |Unsupported  |
| Hyper-V site to Azure |Supported |Supported |Supported |
| Azure to Hyper-V site |Unsupported |Supported |Unsupported |
| VMware site to Azure |Supported (enhanced scenario)<br/><br/> Unsupported (legacy scenario) |Unsupported |Supported |
| Physical server to Azure |Supported (enhanced scenario)<br/><br/> Unsupported (legacy scenario) |Unsupported |Supported |

## Failover and failback
You fail over virtual machines to a secondary on-premises site or to Azure, depending on your deployment. A machine that fails over to Azure is created as an Azure virtual machine. You can fail over a single virtual machine or physical server, or a recovery plan. Recovery plans consists of one or more ordered groups that contain protected virtual machines or physical servers. They're used to orchestrate failover of multiple machines which fail over according to the group they're in. [Read more](site-recovery-create-recovery-plans.md) about recovery plans. 

After failover completes and your machines are up and running in a secondary location note that:

* If you failed over to Azure, after the failover machines aren't protected or replicating in the primary or secondary location. In Azure the virtual machines are stored in geo-replicated storage which provides resiliency, but not replication.
* If you did an unplanned failover to a secondary site, after the failover machines in the secondary location aren't protected or replicating.
* If you did an planned failover to a secondary site, after the failover machines in the secondary location are protected.

### Failback from secondary site
Failback from a secondary site to a primary uses the same process as failover from the primary to secondary. After the failover from primary to secondary datacenter is committed and complete, you can initiate reverse replication when your primary site becomes available. Reverse replication initiates replication between the secondary site and the primary by synchronizing the delta data. Reverse replication brings the virtual machines into a protected state but the secondary datacenter is still the active location. In order to make the primary site into the active location you initiate a planned failover from secondary to primary, followed by another reverse replication.

### Failback from Azure
If you've failed over to Azure your virtual machines are protected by the Azure resiliency features for virtual machines. To make the original primary site into the active location you run a planned failover. You can fail back to the original location or to an alternate location if your original site isn't available. To start replicating again after failback to the primary location you initiate a reverse replication.

### Failover considerations
* **IP address after failover**—By default a failed over machine will have a different IP address than the source machine. If you want to retain the same IP address see: 
  * **Secondary site**—If you're failing over to a secondary site and you want to retain an IP address [read](http://blogs.technet.com/b/scvmm/archive/2014/04/04/retaining-ip-address-after-failover-using-hyper-v-recovery-manager.aspx) this article. Note that you can retain a public IP address if your ISP supports it.
  * **Azure**—If you're failing over to Azure you can specify the IP address you want to assign in the **Configure** tab of the virtual machine properties. You can't retain a public IP address after failover to Azure. You can retain non-RFC 1918 address spaces that are used as internal addresses.
* **Partial failover**—If you want to fail over part of a site rather than an entire site note that: 
  
  * **Secondary site**—If you fail over part of a primary site to a secondary site and you want to connect back to the primary site, use a site-to-site VPN connection to connect failed over applications on the secondary site to infrastructure components running on the primary site. If an entire subnet fails over you can retain the virtual machine IP address. If you fail over a partial subnet you can't retain the virtual machine IP address because subnets can't be split between sites.
  * **Azure**—If you fail over a partial site to Azure and want to connect back to the primary site, you can use a site-to-site VPN to connect a failed over application in Azure to infrastructure components running on the primary site. Note that if the entire subnet fails over you can retain the virtual machine IP address. If you fail over a partial subnet you can't retain the virtual machine IP address because subnets can't be split between sites.
* **Drive letter**—If you want to retain the drive letter on virtual machines after failover you can set the SAN policy for the virtual machine to **On**. Virtual machine disks come online automatically. [Read more](https://technet.microsoft.com/library/gg252636.aspx).
* **Route client requests**—Site Recovery works with Azure Traffic Manager to route client requests to your application after failover.

## Run a test failover
When you run a test failover you'll be asked to select network settings for test replica machines. You have a number of options.  

| **Test failover option** | **Description** | **Failover check** | **Details** |
| --- | --- | --- | --- |
| **Fail over to Azure—without network** |Don't select a target Azure network |Failover checks that test virtual machine starts as expected in Azure |All test virtual machines in a recover plan are added in a single cloud service and can connect to each other<br/><br/>Machines aren't connected to an Azure network after failover.<br/><br/>Users can connect to the test machines with a public IP address |
| **Fail over to Azure—with network** |Select a target Azure network |Failover checks that test machines are connected to the network |Create an Azure network that’s isolated from your Azure production network and set up the infrastructure for the replicated virtual machine to work as expected.<br/><br/>The subnet of the test virtual machine is based on subnet on which the failed over virtual machine is expected to connect to if a planned or unplanned failover occurs. |
| **Fail over to a secondary VMM site—without network** |Don't select a VM network |Failover checks that test machines are created.<br/><br/>The test virtual machine will be created on the same host as the host on which the replica virtual machine exists. It isn’t added to the cloud in which the replica virtual machine is located. |<p>The failed over machine won’t be connected to any network.<br/><br/>The machine can be connected to a VM network after it has been created |
| **Fail over to a secondary VMM site—with network** |Select an existing VM network a |Failover checks that virtual machines are created |The test virtual machine will be created on the same host as the host on which the replica virtual machine exists. It isn’t added to the cloud in which the replica virtual machine is located.<br/><br/>Create a VM network that's isolated from your production network<br/><br/>If you're using a VLAN-based network we recommend you create a separate logical network (not used in production) in VMM for this purpose. This logical network is used to create VM networks for the purpose of test failover.<br/><br/>The logical network should be associated with at least one of the network adapters of all the Hyper-V servers hosting virtual machines.<br/><br/>For VLAN logical networks, the network sites you add to the logical network should be isolated.<br/><br/>If you’re using a Windows Network Virtualization–based logical network, Azure Site Recovery automatically creates isolated VM networks. |
| **Fail over to a secondary VMM site—create a network** |A temporary test network will be created automatically based on the setting you specify in **Logical Network** and its related network sites |Failover checks that virtual machines are created |Use this option if the recovery plan uses more than one VM network. If you're using Windows Network Virtualization networks, this option can automatically create VM networks with the same settings (subnets and IP address pools) in the network of the replica virtual machine. These VM networks are cleaned up automatically after the test failover is complete.</p><p>The test virtual machine will be created on the same host as the host on which the replica virtual machine exists. It isn’t added to the cloud in which the replica virtual machine is located. |

> [!NOTE]
> The IP address given to a virtual machine during test failover is same as the IP address it would receive when doing a planned or unplanned failover (presuming that the IP address is available in the test failover network. If the same IP address isn't available in the test failover network then virtual machine will receive another IP address available in the test failover network.
> 
> 

### Run a test failover from on-premises to Azure
This procedure describes how to run a test failover for a recovery plan. Alternatively you can run the failover for a single machine on the **Virtual Machines** tab.

1. Select **Recovery Plans** > *recoveryplan_name*. Click **Failover** > **Test Failover**.
2. On the **Confirm Test Failover** page, specify how replica machines will be connected to an Azure network after failover.
3. If you're failing over to Azure and data encryption is enabled for the cloud, in **Encryption Key** select the certificate that was issued when you enabled data encryption during Provider installation. 
4. Track failover progress on the **Jobs** tab. You should be able to see the test replica machine in the Azure portal.
5. You can access replica machines in Azure from your on-premises site initiate an RDP connection to the virtual machine. port 3389 will need to be open on the endpoint for the virtual machine.
6. Once you're done, When the failover reaches the **Complete testing** phase , click **Complete Test** to finish.
7. In **Notes** record and save any observations associated with the test failover.
8. Click **The test failover is complete** to automatically clean up the test environment. After this is complete the test failover will show the C**omplete** status.

> [!NOTE]
> If a test failover continues for more than two weeks it'll be completed by force. Any elements or virtual machines created automatically during the test failover will be deleted.
> 
> 

### Run a test failover from a primary on-premises site to a secondary on-premises site
You’ll need to do a number of things to run a test failover, including making a copy of domain controller and placing test DHCP and DNS servers in your test environment. You can do this in a couple of ways:

* If you want to run a test failover using an existing network, prepare Active Directory, DHCP, and DNS in that network.
* If you want to run a test failover using the option to create VM networks automatically, add manual step before Group-1 in the recovery plan you’re going to use for the test failover and then add the infrastructure resources to the automatically created network before running the test failover.

#### Things to note
* When replicating to a secondary site, the type of network used by the replica machine doesn’t need to match the type of logical network used for test failover, but some combinations might not work. If the replica uses DHCP and VLAN-based isolation, the VM network for the replica doesn't need a static IP address pool. So using Windows Network Virtualization for the test failover wouldn't work because no address pools are available. In addition test failover won't work if the replica network is No Isolation and the test network is Windows Network Virtualization. This is because the No Isolation network doesn't have the subnets required to create a Windows Network Virtualization network.
* The way in which replica virtual machines are connected to mapped VM networks after failover depends on how the VM network is configured in the VMM console:
  * **VM network configured with no isolation or VLAN isolation**—If DHCP is defined for the VM network, the replica virtual machine will be connected to the VLAN ID using the settings that are specified for the network site in the associated logical network. The virtual machine will receive its IP address from the available DHCP server. You don't need a static IP address pool defined for the target VM network. If a static IP address pool is used for the VM network the replica virtual machine will be connected to the VLAN ID using the settings that are specified for the network site in the associated logical network. The virtual machine will receive its IP address from the pool defined for the VM network. If a static IP address pool isn't defined on the target VM network, IP address allocation will fail. The IP address pool should be created on both the source and target VMM servers that you are going to use for protection and recovery.
  * **VM network with Windows network virtualization**—If a VM network is configured with this setting a static pool should be defined for the target VM network, regardless of whether the source VM network is configured to use DHCP or a static IP address pool. If you define DHCP, the target VMM server will act as a DHCP server and provide an IP address from the pool that is defined for the target VM network. If use of a static IP address pool is defined for the source server, the target VMM server will allocate an IP address from the pool. In both cases, IP address allocation will fail if a static IP address pool is not defined.

#### Run test
This procedure describes how to run a test failover for a recovery plan. Alternatively you can run the failover for a single virtual machine or physical server on the **Virtual Machines** tab.

1. Select **Recovery Plans** > *recoveryplan_name*. Click **Failover** > **Test Failover**.
2. On the **Confirm Test Failover** page, specify how virtual machines should be connected to networks after the test failover.
3. Track failover progress on the **Jobs** tab. When the failover reaches the** Complete testing** phase, click **Complete Test** to finish up the test failover.
4. Click **Notes** to record and save any observations associated with the test failover.
5. After it's complete verify that the virtual machines start successfully.
6. After verifying that virtual machines start successfully, complete the test failover to clean up the isolated environment. If you chose to automatically create VM networks, cleanup deletes all the test virtual machines and test networks.

> [!NOTE]
> If a test failover continues for more than two weeks it'll be completed by force. Any elements or virtual machines created automatically during the test failover will be deleted.
> 
> 

#### Prepare DHCP
If the virtual machines involved in test failover use DHCP, a test DHCP server should be created within the isolated network that is created for the purpose of test failover.

### Prepare Active Directory
To run a test failover for application testing, you’ll need a copy of the production Active Directory environment in your test environment. Go through [test failover considerations for active directory](site-recovery-active-directory.md#considerations-for-test-failover) section for more details. 

### Prepare DNS
Prepare a DNS server for the test failover as follows:

* **DHCP**—If virtual machines use DHCP, the IP address of the test DNS should be updated on the test DHCP server. If you’re using a network type of Windows Network Virtualization, the VMM server acts as the DHCP server. Therefore, the IP address of DNS should be updated in the test failover network. In this case, the virtual machines will register themselves to the relevant DNS Server.
* **Static address**—If virtual machines use a static IP address, the IP address of the test DNS server should be updated in test failover network. You might need to update DNS with the IP address of the test virtual machines. You can use the following sample script for this purpose: 
  
        Param(
        [string]$Zone,
        [string]$name,
        [string]$IP
        )
        $Record = Get-DnsServerResourceRecord -ZoneName $zone -Name $name
        $newrecord = $record.clone()
        $newrecord.RecordData[0].IPv4Address  =  $IP
        Set-DnsServerResourceRecord -zonename $zone -OldInputObject $record -NewInputObject $Newrecord

## Run a planned failover (primary to secondary)
 This procedure describes how to run a planned failover for a recovery plan. Alternatively you can run the failover for a single virtual machine on the **Virtual Machines** tab.

1. Before you start make sure all the virtual machines you want to fail over have completed initial replication.
2. Select **Recovery Plans** > *recoveryplan_name*. Click **Failover** > **Planned Failover**. 
3. On the **Confirm Planned Failover **page, choose the source and target locations. Note the failover direction.
   
   * If previous failovers worked as expected and all of the virtual machine servers are located on either the source or target location, the failover direction details are for information only. 
   * If virtual machines are active on both the source and target locations, the **Change Direction** button appears. Use this button to change and specify the direction in which the failover should occur.
4. If you're failing over to Azure and data encryption is enabled for the cloud, in **Encryption Key** select the certificate that was issued when you enabled data encryption during Provider installation on the VMM server. 
5. When a planned failover begins the first step is to shut down the virtual machines to ensure no data loss. You can follow the failover progress on the **Jobs** tab. If an error occurs in the failover (either on a virtual machine or in a script that is included in the recovery plan), the planned failover of a recovery plan stops. You can initiate the failover again.
6. After replica virtual machines are created they're in a commit pending state. Click **Commit** to commit the failover. 
7. After replication is complete the virtual machines start up at the secondary location. 

## Run an unplanned failover
This procedure describes how to run an unplanned failover for a recovery plan. Alternatively you can run the failover for a single virtual machine or physical server on the **Virtual Machines** tab.

1. Select **Recovery Plans** > *recoveryplan_name*. Click **Failover** > **Unplanned Failover**. 
2. On the **Confirm Unplanned Failover **page, choose the source and target locations. Note the failover direction.
   
   * If previous failovers worked as expected and all of the virtual machine servers are located on either the source or target location, the failover direction details are for information only. 
   * If virtual machines are active on both the source and target locations, the **Change Direction** button appears. Use this button to change and specify the direction in which the failover should occur.
3. If you're failing over to Azure and data encryption is enabled for the cloud, in **Encryption Key** select the certificate that was issued when you enabled data encryption during Provider installation on the VMM server. 
4. Select **Shut down virtual machines and synchronize the latest data** to specify that Site Recovery should try to shut down the protected virtual machines and synchronize the data so that the latest version of the data will be failed over. If you don’t select this option or the attempt doesn’t succeed the failover will be from the latest available recovery point for the virtual machine.
5. You can follow the failover progress on the **Jobs** tab. Note that even if errors occur during an unplanned failover, the recovery plan runs until it is complete.
6. After the failover, the virtual machines are in a **commit pending** state. Click **Commit** to commit the failover.
7. If you set up replication to use multiple recovery points, in Change Recovery Point you can select to use a recovery point that isn't the latest (latest is used by default). After you commit additional recovery points will be removed.
8. After replication is complete the virtual machines start up and are running at the secondary location. However they aren’t protected or replicating. When the primary site is available again with the same underlying infrastructure, click **Reverse Replicate** to begin reverse replication. This ensures that all the data is replicated back to the primary site, and that the virtual machine is ready for failover again. Reverse replication after an unplanned failover incurs an overhead in data transfer. The transfer will use the same method that is configured for initial replication settings for the cloud.

## Failback from secondary to primary
 After failover from the primary to secondary location, replicated virtual machines aren't protected by Site Recovery, and the secondary location is now acting as the primary. Follow these procedures to fail back to the original primary site. This procedure describes how to run a planned failover for a recovery plan. Alternatively you can run the failover for a single virtual machine on the **Virtual Machines** tab.

1. Select **Recovery Plans** > *recoveryplan_name*. Click **Failover** > **Planned Failover**.
2. On the **Confirm Planned Failover **page, choose the source and target locations. Note the failover direction. If the failover from primary worked as expect and all virtual machines are in the secondary location this is for information only.
3. If you're failing back from Azure select settings in **Data Synchronization**:
   
   * **Synchronize data before failover(Synchonize delta changes only)**—This option minimizes downtime for virtual machines as it synchronizes without shutting them down. It does the following:
     * Phase 1: Takes snapshot of the virtual machine in Azure and copies it to the on-premises Hyper-V host. The machine continues running in Azure.
     * Phase 2: Shuts down the virtual machine in Azure so that no new changes occur there. The final set of changes are transferred to the on-premises server and the on-premises virtual machine is started up.

    - **Synchronize data during failover only(full download)**—Use this option if you've been running on Azure for a long time. This option is faster because we expect that most of the disk has changed and we dont want to spend time in checksum calculation. It performs a download of the disk. It is also useful when the on-prem virtual machine has been deleted.

    > [AZURE.NOTE] We recommend you use this option if you've been running Azure for a while (a month or more) or the on-prem VM has been deleted.This option doesn't perform any checksum calculations.

1. If you're failing over to Azure and data encryption is enabled for the cloud, in **Encryption Key** select the certificate that was issued when you enabled data encryption during Provider installation on the VMM server. 
2. By default the last recovery point is used, but in **Change Recovery Point** you can specify a different recovery point. 
3. Click the checkmark to start the failback.  You can follow the failover progress on the **Jobs** tab. 
4. f you selected the option to synchronize the data before the failover, once the initial data synchronization is complete and you're ready to shut down the virtual machines in Azure, click **Jobs** > <planned failover job name> **Complete Failover**. This shuts down the Azure machine, transfers the latest changes to the on-premises virtual machine, and starts it.
5. You can now log onto the virtual machine to validate it's available as expected. 
6. The virtual machine is in a commit pending state. Click **Commit** to commit the failover.
7. Now in order to complete the failback click **Reverse Replicate** to start protecting the virtual machine in the primary site.

## Failback to an alternate location
If you've deployed protection between a [Hyper-V site and Azure](site-recovery-hyper-v-site-to-azure.md) you have to ability to failback from Azure to an alternate on-premises location. This is useful if you need to set up new on-premises hardware. Here's how you do it.

1. If you're setting up new hardware install Windows Server 2012 R2 and the Hyper-V role on the server.
2. Create a virtual network switch with the same name that you had on the original server.
3. Select **Protected Items** -> **Protection Group** -> <ProtectionGroupName> -> <VirtualMachineName> you want to fail back, and select **Planned Failover**.
4. In **Confirm Planned Failover** select **Create on-premises virtual machine if it does not exist**. 
5. In **Host Name** select the new Hyper-V host server on which you want to place the virtual machine.
6. In Data Synchronization we recommend you select  the option **Synchronize the data before the failover**. This minimizes downtime for virtual machines as it synchronizes without shutting them down. It does the following:
   
   * Phase 1: Takes snapshot of the virtual machine in Azure and copies it to the on-premises Hyper-V host. The machine continues running in Azure.
   * Phase 2: Shuts down the virtual machine in Azure so that no new changes occur there. The final set of changes are transferred to the on-premises server and the on-premises virtual machine is started up.
7. Click the checkmark to begin the failover (failback).
8. After the initial synchronization finishes and you're ready to shut down the virtual machine in Azure, click **Jobs** > <planned failover job> > **Complete Failover**. This shuts down the Azure machine, transfers the latest changes to the on-premises virtual machine and starts it.
9. You can log onto the on-premises virtual machine to verify everything is working as expected. Then click **Commit** to finish the failover.
10. Click **Reverse Replicate** to start protecting the on-premises virtual machine.
    
    > [!NOTE]
    > If you cancel the failback job while it is in Data Synchronization step, the on-premises VM will be in a currupted state. This is because Data Synchonization copies the latest data from Azure VM disks to the on-prem data disks, and untill the synchronization completes, the disk data may not be in a consistent state. If the On-prem VM is booted after Data Synchonization is cancelled, it may not boot. Re-trigger failover to complete the Data Synchonization.
    > 
    > 

