---
title: Preparing your environment to back up workloads using Azure Backup Server | Microsoft Azure
description: Make sure your environment is properly prepared to back up workloads using Azure Backup Server
services: backup
documentationcenter: ''
author: pvrk
manager: shivamg
editor: ''
keywords: azure backup server; backup vault

ms.service: backup
ms.workload: storage-backup-recovery
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/10/2016
ms.author: jimpark;trinadhk;pullabhk; markgal

---
# Preparing to back up workloads using Azure Backup Server
> [!div class="op_single_selector"]
> * [Azure Backup Server](backup-azure-microsoft-azure-backup.md)
> * [SCDPM](backup-azure-dpm-introduction.md)
> * [Azure Backup Server (Classic)](backup-azure-microsoft-azure-backup-classic.md)
> * [SCDPM (Classic)](backup-azure-dpm-introduction-classic.md)
> 
> 

This article is about preparing your environment to back up workloads using Azure Backup Server. With Azure Backup Server, you can protect application workloads such as Hyper-V VMs, Microsoft SQL Server, SharePoint Server, Microsoft Exchange and Windows clients from a single console.

> [!WARNING]
> Azure Backup Server inherits the functionality of Data Protection Manager (DPM) for workload backup. You will find pointers to DPM documentation for some of these capabilities. However Azure Backup Server does not provide protection on tape or integrate with System Center.
> 
> 

## 1. Windows Server machine
![step1](./media/backup-azure-microsoft-azure-backup/step1.png)

The first step towards getting the Azure Backup Server up and running is to have a Windows Server machine.

| Location | Minimum requirements | Additional instructions |
| --- | --- | --- |
| Azure |Azure IaaS virtual machine<br><br>A2 Standard: 2 cores, 3.5GB RAM |You can start with a simple gallery image of Windows Server 2012 R2 Datacenter. [Protecting IaaS workloads using Azure Backup Server (DPM)](https://technet.microsoft.com/library/jj852163.aspx) has many nuances. Ensure that you read the article completely before deploying the machine. |
| On-premises |Hyper-V VM,<br> VMWare VM,<br> or a physical host<br><br>2 cores and 4GB RAM |You can deduplicate the DPM storage using Windows Server Deduplication. Learn more about how [DPM and deduplication](https://technet.microsoft.com/library/dn891438.aspx) work together when deployed in Hyper-V VMs. |

> [!NOTE]
> It is recommended that Azure Backup Server be installed on a machine with Windows Server 2012 R2 Datacenter. A lot of the prerequisites are automatically covered with the latest version of the Windows operating system.
> 
> 

If you plan to join this server to a domain at some point, it is recommended that the domain-joining activity be done before the Azure Backup Server installation. Moving an existing Azure Backup Server machine to a new domain after deployment is *not supported*.

## 2. Backup vault
![step2](./media/backup-azure-microsoft-azure-backup/step2.png)

Whether you send backup data to Azure or keep it locally, the software needs to be connected to Azure. To be more specific, the Azure Backup Server machine needs to be registered with a backup vault.

To create a backup vault:

1. Sign in to the [Management Portal](http://manage.windowsazure.com/).
2. Click **New** > **Data Services** > **Recovery Services** > **Backup Vault** > **Quick Create**. If you have multiple subscriptions associated with your organizational account, choose the correct subscription to associate with the backup vault.
3. In **Name**, enter a friendly name to identify the vault. This needs to be unique for each subscription.
4. In **Region**, select the geographic region for the vault. Typically, the vault's region is picked based on data sovereignty or network latency constraints.
   
    ![Create backup vault](./media/backup-azure-microsoft-azure-backup/backup_vaultcreate.png)
5. Click **Create Vault**. It can take a while for the backup vault to be created. Monitor the status notifications at the bottom of the portal.
   
    ![Create vault toast notification](./media/backup-azure-microsoft-azure-backup/creating-vault.png)
6. A message confirms that the vault has been successfully created and it will be listed in the Recovery Services page as Active.
    ![List of backup vaults](./media/backup-azure-microsoft-azure-backup/backup_vaultslist.png)
   
   > [!IMPORTANT]
   > Make sure that the appropriate storage redundancy option is chosen right after the vault has been created. Read more about [geo-redundant](../storage/storage-redundancy.md#geo-redundant-storage) and [locally redundant](../storage/storage-redundancy.md#locally-redundant-storage) options in this [overview](../storage/storage-redundancy.md).
   > 
   > 
   > 

## 3. Software package
![step3](./media/backup-azure-microsoft-azure-backup/step3.png)

### Downloading the software package
Similar to vault credentials, you can download Microsoft Azure Backup for application workloads from the **Quick Start Page** of the backup vault.

1. Click **For Application Workloads (Disk to Disk to Cloud)**. This will take you to the Download Center page from where the software package can be downloaded.
   
    ![Microsoft Azure Backup Welcome Screen](./media/backup-azure-microsoft-azure-backup/dpm-venus1.png)
2. Click **Download**.
   
    ![Download center 1](./media/backup-azure-microsoft-azure-backup/downloadcenter1.png)
3. Select all the files and click **Next**. Download all the files coming in from the Microsoft Azure Backup download page, and place all the files in the same folder.
   ![Download center 1](./media/backup-azure-microsoft-azure-backup/downloadcenter.png)
   
    Since the download size of all the files together is > 3G, on a 10Mbps download link it may take up to 60 minutes for the download to complete.

### Extracting the software package
After you've downloaded all the files, click **MicrosoftAzureBackupInstaller.exe**. This will start the **Microsoft Azure Backup Setup Wizard** to extract the setup files to a location specified by you. Continue through the wizard and click on the **Extract** button to begin the extraction process.

> [!WARNING]
> At least 4GB of free space is required to extract the setup files.
> 
> 

![Microsoft Azure Backup Setup Wizard](./media/backup-azure-microsoft-azure-backup/extract/03.png)

Once the extraction process complete, check the box to launch the freshly extracted *setup.exe* to begin installing Microsoft Azure Backup Server and click on the **Finish** button.

### Installing the software package
1. Click **Microsoft Azure Backup** to launch the setup wizard.
   
    ![Microsoft Azure Backup Setup Wizard](./media/backup-azure-microsoft-azure-backup/launch-screen2.png)
2. On the Welcome screen click the **Next** button. This takes you to the *Prerequisite Checks* section. On this screen, click on the **Check** button to determine if the hardware and software prerequisites for Azure Backup Server have been met. If all of the prerequisites are have been met successfully, you will see a message indicating that the machine meets the requirements. Click on the **Next** button.
   
    ![Azure Backup Server - Welcome and Prerequisites check](./media/backup-azure-microsoft-azure-backup/prereq/prereq-screen2.png)
3. Microsoft Azure Backup Server requires SQL Server Standard, and the Azure Backup Server installation package comes bundled with the appropriate SQL Server binaries needed. When starting with a new Azure Backup Server installation, you should pick the option **Install new Instance of SQL Server with this Setup** and click the **Check and Install** button. Once the prerequisites are successfully installed, click **Next**.
   
    ![Azure Backup Server - SQL check](./media/backup-azure-microsoft-azure-backup/sql/01.png)
   
    If a failure occurs with a recommendation to restart the machine, do so and click **Check Again**.
   
   > [!NOTE]
   > Azure Backup Server will not work with a remote SQL Server instance. The instance being used by Azure Backup Server needs to be local.
   > 
4. Provide a location for the installation of Microsoft Azure Backup server files and click **Next**.
   
    ![Microsoft Azure Backup PreReq2](./media/backup-azure-microsoft-azure-backup/space-screen.png)
   
    The scratch location is a requirement for back up to Azure. Ensure the scratch location is at least 5% of the data planned to be backed up to the cloud. For disk protection, separate disks need to be configured once the installation completes. For more information regarding storage pools, see [Configure storage pools and disk storage](https://technet.microsoft.com/library/hh758075.aspx).
5. Provide a strong password for restricted local user accounts and click **Next**.
   
    ![Microsoft Azure Backup PreReq2](./media/backup-azure-microsoft-azure-backup/security-screen.png)
6. Select whether you want to use *Microsoft Update* to check for updates and click **Next**.
   
   > [!NOTE]
   > We recommend having Windows Update redirect to Microsoft Update, which offers security and important updates for Windows and other products like Microsoft Azure Backup Server.
   > 
   > 
   
    ![Microsoft Azure Backup PreReq2](./media/backup-azure-microsoft-azure-backup/update-opt-screen2.png)
7. Review the *Summary of Settings* and click **Install**.
   
    ![Microsoft Azure Backup PreReq2](./media/backup-azure-microsoft-azure-backup/summary-screen.png)
8. The installation happens in phases. In the first phase the Microsoft Azure Recovery Services Agent is installed on the server. The wizard also checks for Internet connectivity. If Internet connectivity is available you can proceed with installation, if not, you need to provide proxy details to connect to the Internet.
   
    The next step is to configure the Microsoft Azure Recovery Services Agent. As a part of the configuration, you will have to provide your the vault credentials to register the machine to the backup vault. You will also provide a passphrase to encrypt/decrypt the data sent between Azure and your premises. You can automatically generate a passphrase or provide your own minimum 16-character passphrase. Continue with the wizard until the agent has been configured.
   
    ![Azure Backup Serer PreReq2](./media/backup-azure-microsoft-azure-backup/mars/04.png)
9. Once registration of the Microsoft Azure Backup server successfully completes, the overall setup wizard proceeds to the installation and configuration of SQL Server and the Azure Backup Server components. Once the SQL Server component installation completes, the Azure Backup Server components are installed.
   
    ![Azure Backup Server](./media/backup-azure-microsoft-azure-backup/final-install/venus-installation-screen.png)

When the installation step has completed, the product's desktop icons will have been created as well. Just double-click the icon to launch the product.

### Add backup storage
The first backup copy is kept on storage attached to the Azure Backup Server machine. For more information about adding disks, see [Configure storage pools and disk storage](https://technet.microsoft.com/library/hh758075.aspx).

> [!NOTE]
> You need to add backup storage even if you plan to send data to Azure. In the current architecture of Azure Backup Server, the Azure Backup vault holds the *second* copy of the data while the local storage holds the first (and mandatory) backup copy.  
> 
> 

## 4. Network connectivity
![step4](./media/backup-azure-microsoft-azure-backup/step4.png)

Azure Backup Server requires connectivity to the Azure Backup service for the product to work successfully. To validate whether the machine has the connectivity to Azure, use the ```Get-DPMCloudConnection``` commandlet in the Azure Backup Server PowerShell console. If the output of the commandlet is TRUE then connectivity exists, else there is no connectivity.

At the same time, the Azure subscription needs to be in a healthy state. To find out the state of your subscription and to manage it, log in to the [subscription portal](https://account.windowsazure.com/Subscriptions).

Once you know the state of the Azure connectivity and of the Azure subscription, you can use the table below to find out the impact on the backup/restore functionality offered.

| Connectivity State | Azure Subscription | Backup to Azure | Backup to disk | Restore from Azure | Restore from disk |
| --- | --- | --- | --- | --- | --- |
| Connected |Active |Allowed |Allowed |Allowed |Allowed |
| Connected |Expired |Stopped |Stopped |Allowed |Allowed |
| Connected |Deprovisioned |Stopped |Stopped |Stopped and Azure recovery points deleted |Stopped |
| Lost connectivity > 15 days |Active |Stopped |Stopped |Allowed |Allowed |
| Lost connectivity > 15 days |Expired |Stopped |Stopped |Allowed |Allowed |
| Lost connectivity > 15 days |Deprovisioned |Stopped |Stopped |Stopped and Azure recovery points deleted |Stopped |

### Recovering from loss of connectivity
If you have a firewall or a proxy that is preventing access to Azure, you need to whitelist the following domain addresses in the firewall/proxy profile:

* www.msftncsi.com
* \*.Microsoft.com
* \*.WindowsAzure.com
* \*.microsoftonline.com
* \*.windows.net

Once connectivity to Azure has been restored to the Azure Backup Server machine, the operations that can be performed are determined by the Azure subscription state. The table above has details about the operations allowed once the machine is "Connected".

### Handling subscription states
It is possible to take an Azure subscription from an *Expired* or *Deprovisioned* state to the *Active* state. However this has some implications on the product behavior while the state is not *Active*:

* A *Deprovisioned* subscription loses functionality for the period that it is deprovisioned. On turning *Active*, the product functionality of backup/restore is revived. The backup data on the local disk also can be retrieved if it was kept with a sufficiently large retention period. However, the backup data in Azure is irretrievably lost once the subscription enters the *Deprovisioned* state.
* An *Expired* subscription only loses functionality for until it has been made *Active* again. Any backups scheduled for the period that the subscription was *Expired* will not run.

## Troubleshooting
If Microsoft Azure Backup server fails with errors during the setup phase (or backup or restore), refer to this [error codes document](https://support.microsoft.com/kb/3041338)  for more information.
You can also refer to [Azure Backup related FAQs](backup-azure-backup-faq.md)

## Next steps
You can get detailed information about [preparing your environment for DPM](https://technet.microsoft.com/library/hh758176.aspx) on the Microsoft TechNet site. It also contains information about supported configurations on which Azure Backup Server can be deployed and used.

You can use these articles to gain a deeper understanding of workload protection using Microsoft Azure Backup server.

* [SQL Server backup](backup-azure-backup-sql.md)
* [SharePoint server backup](backup-azure-backup-sharepoint.md)
* [Alternate server backup](backup-azure-alternate-dpm-server.md)

