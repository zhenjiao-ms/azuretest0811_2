---
title: Create Windows-based Hadoop clusters in HDInsight | Microsoft Azure
description: Learn how to create clusters for Azure HDInsight.
services: hdinsight
documentationcenter: ''
tags: azure-portal
author: mumian
manager: paulettm
editor: cgronlun

ms.service: hdinsight
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: big-data
ms.date: 07/08/2016
ms.author: jgao

---
# Create Windows-based Hadoop clusters in HDInsight
[!INCLUDE [selector](../../includes/hdinsight-selector-create-clusters.md)]

A Hadoop cluster consists of several virtual machines (nodes) which are used for distributed processing of tasks on the cluster. Azure abstracts the implementation details of installation and configuration of individual nodes, so you only have to provide general configuration information. In this article,  you will learn these configuration settings. 

> [!NOTE]
> the information in this document is specific to Windows-based HDInsight clusters. For information on Linux-based clusters, see [Create Linux-based Hadoop clusters in HDInsight](hdinsight-hadoop-provision-linux-clusters.md).
> 
> 

## Cluster types
Currently, HDInsight provides 4 different types of clusters, each with a set of components to provide certain functionalities: 

| Cluster type | Use this if you need... |
| --- | --- |
| Hadoop |query and analysis (batch jobs) |
| HBase |NoSQL data storage |
| Storm |Real-time event processing |
| Spark (Preview) |In-memory processing, interactive queries, micro-batch stream processing |

Each cluster type has its own terminology for nodes within the cluster, as well as the number of nodes and the default VM size for each node type:

| Type | Nodes (number of nodes) | Diagram |
| --- | --- | --- |
| Hadoop |Head node (2), Data node (1+) |![HDInsight Hadoop cluster nodes](./media/hdinsight-provision-clusters/HDInsight.Hadoop.roles.png) |
| HBase |Head server (2), Region server (1+), Master/Zookeeper node (3) |![HDInsight HBase cluster nodes](./media/hdinsight-provision-clusters/HDInsight.HBase.roles.png) |
| Storm |Nimbus node (2), Supervisor server (1+), Zookeeper node (3) |![HDInsight Storm cluster nodes](./media/hdinsight-provision-clusters/HDInsight.Storm.roles.png) |
| Spark |Head node (2), Worker node (1+), Zookeeper node (3) (Free for A1 Zookeepers VM size) |![HDInsight Spark cluster nodes](./media/hdinsight-provision-clusters/HDInsight.Spark.roles.png) |

(Note: In parentheses are the number of nodes for each node type.)

> [!IMPORTANT]
> If you plan on more than 32 worker nodes, either at cluster creation or by scaling the cluster after creation, then you must select a head node size with at least 8 cores and 14GB ram.
> 
> 

You can add other components such as Hue or R to these basic types by using [Script Actions](#customize-clusters-using-script-action).

## Basic configuration options
The following are the basic configuration options for creating an HDInsight cluster.

* **Cluster name**
  
    Cluster name is used to identify a cluster. Cluster name must be globally unique, and it must follow the following naming guidelines:
  
  * The field must be a string that contains between 3 and 63 characters
  * The field can contain only letters, numbers, and hyphens.
* **Cluster type** 
  
    See [Cluster types](#cluster-types).
* **Operating system**
  
    You can create HDInsight clusters on one of the following two operating systems:
  
  * **HDInsight on Linux (Ubuntu 12.04 LTS for Linux)**: HDInsight provides the option of configuring Linux clusters on Azure. Configure a Linux cluster if you are familiar with Linux or Unix, migrating from an existing Linux-based Hadoop solution, or want easy integration with Hadoop ecosystem components built for Linux. For more information, see [Get started with Hadoop on Linux in HDInsight](hdinsight-hadoop-linux-tutorial-get-started.md).
  * **HDInsight on Windows (Windows Server 2012 R2 Datacenter)**:
* **HDInsight version**
  
    It is used to determine the version of HDInsight to use for this cluster. For more information, see [Hadoop cluster versions and components in HDInsight](https://go.microsoft.com/fwLink/?LinkID=320896&clcid=0x409)
* **Subscription name**
  
    Each HDInsight cluster is tied to one Azure subscription.
* **Resource group name**
  
    [Azure Resource Manager (ARM)](../resource-group-overview.md) enables you to work with the resources in your application as a group, referred to as an Azure Resource Group. You can deploy, update, monitor or delete all of the resources for your application in a single, coordinated operation.    
* **Credentials**
  
    The HDInsight clusters allow you to configure two user accounts during cluster creation:
  
  * HTTP user. The default user name is admin using the basic configuration on the Azure Portal. Sometimes, it is called "Cluster user".
  * RDP user (Windows clusters): It is used to connect to the cluster using RDP. When you create the account, you must set an expiration date that is within 90 days from today.
  * SSH User (Linux clusters): Is used to connect to the cluster using SSH. You can create additional SSH user accounts after the cluster is created by following the steps in [Use SSH with Linux-based Hadoop on HDInsight from Linux, Unix, or OS X](hdinsight-hadoop-linux-use-ssh-unix.md).
* **Data source**
  
    The original HDFS uses many local disks on the cluster. HDInsight uses Azure Blob storage instead for data storage. Azure Blob storage is a robust, general-purpose storage solution that integrates seamlessly with HDInsight. Through a Hadoop distributed file system (HDFS) interface, the full set of components in HDInsight can operate directly on structured or unstructured data in Blob storage. Storing data in Blob storage enables you to safely delete the HDInsight clusters that are used for computation without losing user data.
  
    During configuration, you must specify an Azure storage account and an Azure Blob storage container on the Azure storage account. Some creation process requires the Azure storage account and the Blob storage container created beforehand. The Blob storage container is used as the default storage location by the cluster. Optionally, you can specify additional Azure Storage accounts (linked storage) that will be accessible by the cluster. In addition, the cluster can also access any Blob containers that are configured with full public read access or public read access for blobs only.  For more information on the restrict access, see [Manage Access to Azure Storage Resources](../storage/storage-manage-access-to-resources.md).
  
    ![HDInsight storage](./media/hdinsight-provision-clusters/HDInsight.storage.png)
  
  > [!NOTE]
  > A Blob storage container provides a grouping of a set of blobs as shown in the image:
  > 
  > 
  
    ![Azure blob storage](./media/hdinsight-provision-clusters/Azure.blob.storage.jpg)
  
    It is not recommended to use the default Blob container for storing business data.  It is a good practice to delete thedefault Blob container after each use to reduce storage cost.  Please note that the default container contains application and system logs.  Make sure to retrieve the logs before deleting the container. 
  
  > [!WARNING]
  > Sharing one Blob storage container for multiple clusters is not supported. 
  > 
  > 
  
    For more information on using secondary Blob stores, see [Using Azure Blob Storage with HDInsight](hdinsight-hadoop-use-blob-storage.md).
  
    In addition to Azure Blob storage, you can also use [Azure Data Lake store](../data-lake-store/data-lake-store-overview.md) as default storage account for HBase cluster in HDInsight and as linked storage for all 4 HDInsight cluster types. For the instructions, see [Create an HDInsight cluster with Data Lake Store using Azure Portal](../data-lake-store/data-lake-store-hdinsight-hadoop-use-portal.md) 
* **Location (Region)**
  
    The HDInsight cluster and its default storage account must be located on the same Azure location.
  
    ![Azure regions](./media/hdinsight-provision-clusters/Azure.regions.png)
  
    For a list of supported regions, click the **Region** drop-down list on [HDInsight pricing](https://go.microsoft.com/fwLink/?LinkID=282635&clcid=0x409).
* **Node pricing tiers**
  
    Customers are billed for the usage of those nodes for the duration of the cluster’s life. Billing starts once a cluster is created and stops when the cluster is deleted (clusters can’t be de-allocated or put on hold). 
  
    Different cluster types have different node types, number of nodes, and node sizes. For example, a Hadoop cluster type has two *head nodes* and a default of four *data nodes*, while a Storm cluster type has two *nimbus nodes*, three *zookeeper nodes*, and a default of four *supervisor nodes*. The cost of HDInsight clusters is determined by the number of nodes, and the virtual machines sizes for the nodes. For example, if you know that you will be performing operations that need a lot of memory, you may want to select a compute resource with more memory. For learning purposes, it is recommended to use 1 data node. For more information about HDInsight pricing, see [HDInsight pricing](https://go.microsoft.com/fwLink/?LinkID=282635&clcid=0x409).
  
  > [!NOTE]
  > The cluster size limit varies among Azure subscriptions. Contact billing support to increase the limit.
  > 
  > The nodes used by your cluster do not count as Virtual Machines, as the Virtual Machines images used for the nodes are an implementation detail of the HDInsight service; however, the compute cores used by the nodes do count against the total number of compute cores available to your subscription. You can see the number of cores that will be used by the cluster, as well as the number of cores available, in the summary section of the Node Pricing Tiers blade when creating an HDInsight cluster.
  > 
  > 
  
    When using the Azure portal to configure the cluster, thenNode size is available through the **Node Pricing Tier** blade, and will also display the cost associated with the different node sizes. The following screenshot shows the choices for a Linux-base Hadoop cluster:
  
    ![hdinsight vm node sizes](./media/hdinsight-provision-clusters/hdinsight.node.sizes.png)
  
    The following tables show the sizes supported by HDInsight clusters and the capacities they provide.
  
  * Standard tier: A-series
    
      In the classic deployment model, some VM sizes are slightly different in PowerShell and CLI.
    
    * Standard_A3 is Large
    * Standard_A4 is ExtraLarge
      
      <br>
      
      | Size | CPU cores | Memory | NICs (Max) | Max. disk size | Max. data disks (1023 GB each) | Max. IOPS (500 per disk) |
      | --- | --- | --- | --- | --- | --- | --- |
      | Standard_A3\Large |4 |7 GB |2 |Temporary = 285 GB |8 |8x500 |
      | Standard_A4\ExtraLarge |8 |14 GB |4 |Temporary = 605 GB |16 |16x500 |
      | Standard_A6 |4 |28 GB |2 |Temporary = 285 GB |8 |8x500 |
      | Standard_A7 |8 |56 GB |4 |Temporary = 605 GB |16 |16x500 |
  * Standard tier: D-series
    
    | Size | CPU cores | Memory | NICs (Max) | Max. disk size | Max. data disks (1023 GB each) | Max. IOPS (500 per disk) |
    | --- | --- | --- | --- | --- | --- | --- |
    | Standard_D3 |4 |14 GB |4 |Temporary (SSD) =200 GB |8 |8x500 |
    | Standard_D4 |8 |28 GB |8 |Temporary (SSD) =400 GB |16 |16x500 |
    | Standard_D12 |4 |28 GB |4 |Temporary (SSD) =200 GB |8 |8x500 |
    | Standard_D13 |8 |56 GB |8 |Temporary (SSD) =400 GB |16 |16x500 |
    | Standard_D14 |16 |112 GB |8 |Temporary (SSD) =800 GB |32 |32x500 |
  * Standard tier: Dv2-series
    
    | Size | CPU cores | Memory | NICs (Max) | Max. disk size | Max. data disks (1023 GB each) | Max. IOPS (500 per disk) |
    | --- | --- | --- | --- | --- | --- | --- |
    | Standard_D3_v2 |4 |14 GB |4 |Temporary (SSD) =200 GB |8 |8x500 |
    | Standard_D4_v2 |8 |28 GB |8 |Temporary (SSD) =400 GB |16 |16x500 |
    | Standard_D12_v2 |4 |28 GB |4 |Temporary (SSD) =200 GB |8 |8x500 |
    | Standard_D13_v2 |8 |56 GB |8 |Temporary (SSD) =400 GB |16 |16x500 |
    | Standard_D14_v2 |16 |112 GB |8 |Temporary (SSD) =800 GB |32 |32x500 |
    
    For deployment considerations to be aware of when you're planning to use these resources, see [Sizes for virtual machines](../virtual-machines/virtual-machines-windows-size.md). For information about pricing of the various sizes, see [HDInsight Pricing](https://azure.microsoft.com/pricing/details/hdinsight)   
    
    > [!IMPORTANT]
    > If you plan on more than 32 worker nodes, either at cluster creation or by scaling the cluster after creation, then you must select a head node size with at least 8 cores and 14GB RAM.
    > Billing starts once a cluster is created, and only stops when the cluster is deleted. For more information on pricing, see [HDInsight pricing details](https://azure.microsoft.com/pricing/details/hdinsight/).
    > 
    > 
    > 

## Use additional storage
In some cases, you may wish to add additional storage to the cluster. For example, if you have multiple Azure Storage Accounts for different geographical regions, or for different services, but want to analyze them all with HDInsight.

For more information on using secondary blob stores, see [Using Azure Blob storage with HDInsight](hdinsight-hadoop-use-blob-storage.md). For more information on using secondary Data Lake stores, see [Create HDInsight clusters with Data Lake Store using Azure Portal](../data-lake-store/data-lake-store-hdinsight-hadoop-use-portal.md)

## Use Hive/Oozie metastore
We strongly recommend to use a custom metastore if you want to keep your Hive tables after you delete your HDInsight cluster, for purposes of attaching that metastore to another HDInsight cluster in the future. 

> [!IMPORTANT]
> Hdinsight metastore is not backward compatible. For example, you cannot use a metastore of an HDInsight 3.3 cluster to create an HDInsight 3.2 cluster.
> 
> 

The metastore contains Hive and Oozie metadata, such as Hive tables, partitions, schemas, and columns. Using the metastore helps you to retain your Hive and Oozie metadata, so that you don't need to re-create Hive tables or Oozie jobs when you create a new cluster. By default, Hive uses an embedded Azure SQL database to store this information. The embedded database can't preserve the metadata when the cluster is deleted. For example, you have a cluster created with a Hive metastore. You created some Hive tables. After you delete the cluster, and recreate the cluster using the same Hive metastore, you will be able to see the Hive tables you created in the original cluster.

Metastore configuration is not available for HBase cluster types.

> [!IMPORTANT]
> When creating a custom metastore, do not use a database name that contains dashes or hyphens, as this can cause the cluster creation process to fail.
> 
> 

## Use Azure virtual networks
An [Azure Virtual Network](https://azure.microsoft.com/documentation/services/virtual-network/) allows you to create a secure, persistent network containing the resources you need for your solution. A virtual network allows you to:

* Connect cloud resources together in a private network (cloud-only).
  
    ![diagram of cloud-only configuration](./media/hdinsight-hadoop-provision-linux-clusters/hdinsight-vnet-cloud-only.png)
* Connect your cloud resources to your local data-center network (site-to-site or point-to-site) by using a virtual private network (VPN).
  
  | Site-to-site configuration | Point-to-site configuration |
  | --- | --- |
  | Site-to-site configuration allows you to connect multiple resources from your data center to the Azure virtual network by using a hardware VPN or the Routing and Remote Access Service.<br />![diagram of site-to-site configuration](./media/hdinsight-hadoop-provision-linux-clusters/hdinsight-vnet-site-to-site.png) |Point-to-site configuration allows you to connect a specific resource to the Azure virtual network by using a software VPN.<br />![diagram of point-to-site configuration](./media/hdinsight-hadoop-provision-linux-clusters/hdinsight-vnet-point-to-site.png) |

Windows-based clusters require a v1 (Classic) Virtual Network, while Linux-based clusters require a v2 (Azure Resource Manager,) Virtual Network. If you do not have the correct type of network, it will not be usable when you create the cluster.

For more information on using HDInsight with a Virtual Network, including specific configuration requirements for the Virtual Network, see [Extend HDInsight capabilities by using an Azure Virtual Network](hdinsight-extend-hadoop-virtual-network.md).

## Customize clusters using HDInsight cluster customization (bootstrap)
Sometimes, you want to configure the configuration files:

* clusterIdentity.xml
* core-site.xml
* gateway.xml
* hbase-env.xml
* hbase-site.xml
* hdfs-site.xml
* hive-env.xml
* hive-site.xml
* mapred-site
* oozie-site.xml
* oozie-env.xml
* storm-site.xml
* tez-site.xml
* webhcat-site.xml
* yarn-site.xml

To keep the changes through the clusters' lifetime, you can use HDInsight cluster customization during the creation process, or you can use Ambari in Linux-based clusters saely. For more information, see [Customize HDInsight clusters using Bootstrap](hdinsight-hadoop-customize-cluster-bootstrap.md).

> [!NOTE]
> The Windows-based clusters can't retain the changes due to re-image. For more information, 
> see [Role Instance Restarts Due to OS Upgrades](http://blogs.msdn.com/b/kwill/archive/2012/09/19/role-instance-restarts-due-to-os-upgrades.aspx).  To keep the changes through the clusters' lifetime, you must use HDInsight cluster customization during the creation process.
> 
> 

## Customize clusters using Script action
You can install additional components or customize cluster configuration by using scripts during creation. Such scripts are invoked via **Script Action**, which is a configuration option that can be used from the Portal, HDInsight Windows PowerShell cmdlets, or the HDInsight .NET SDK. For more information, see [Customize HDInsight cluster using Script Action](hdinsight-hadoop-customize-cluster.md).

## Cluster creation methods
In this article, you have learned basic information about creating a Windows-based HDInsight cluster. Use the table below to find specific information on how to create a cluster using a method that best suits your needs:

| Use this to create clusters... | Use web browser... | Use command-line | Use REST API | Use SDK | From Linux, Mac OS X, or Unix | From Windows |
| --- |:---:|:---:|:---:|:---:|:---:|:---:|
| [Azure Portal](hdinsight-hadoop-create-windows-clusters-portal.md) |✔ |&nbsp; |&nbsp; |&nbsp; |✔ |✔ |
| [Azure CLI](hdinsight-hadoop-create-windows-clusters-cli.md) |&nbsp; |✔ |&nbsp; |&nbsp; |✔ |✔ |
| [Azure PowerShell](hdinsight-hadoop-create-windows-clusters-powershell.md) |&nbsp; |✔ |&nbsp; |&nbsp; |✔ |✔ |
| [cURL](hdinsight-hadoop-create-linux-clusters-curl-rest.md) |&nbsp; |✔ |✔ |&nbsp; |✔ |✔ |
| [.NET SDK](hdinsight-hadoop-create-windows-clusters-dotnet-sdk.md) |&nbsp; |&nbsp; |&nbsp; |✔ |✔ |✔ |
| [ARM Templates](hdinsight-hadoop-create-windows-clusters-arm-templates.md) |&nbsp; |✔ |&nbsp; |&nbsp; |✔ |✔ |

