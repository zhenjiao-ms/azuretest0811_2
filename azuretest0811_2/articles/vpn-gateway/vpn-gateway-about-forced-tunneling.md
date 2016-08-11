---
title: Configure forced tunneling for Site-to-Site connections using the classic deployment model | Microsoft Azure
description: How to redirect or 'force' all Internet-bound traffic back to your on-premises location.
services: vpn-gateway
documentationcenter: na
author: cherylmc
manager: carmonm
editor: ''
tags: azure-service-management

ms.service: vpn-gateway
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: infrastructure-services
ms.date: 05/16/2016
ms.author: cherylmc

---
# Configure forced tunneling using the classic deployment model
> [!div class="op_single_selector"]
> * [PowerShell - Service Management](vpn-gateway-about-forced-tunneling.md)
> * [PowerShell - Resource Manager](vpn-gateway-forced-tunneling-rm.md)
> 
> 

Forced tunneling lets you redirect or "force" all Internet-bound traffic back to your on-premises location via a Site-to-Site VPN tunnel for inspection and auditing. This is a critical security requirement for most enterprise IT policies. 

Without forced tunneling, Internet-bound traffic from your VMs in Azure will always traverse from Azure network infrastructure directly out to the Internet, without the option to allow you to inspect or audit the traffic. Unauthorized Internet access can potentially lead to information disclosure or other types of security breaches.

This article will walk you through configuring forced tunneling for virtual networks created using the classic deployment model. 

**About Azure deployment models**

[!INCLUDE [vpn-gateway-clasic-rm](../../includes/vpn-gateway-classic-rm-include.md)]

**Deployment models and tools for forced tunneling**

A forced tunneling connection can be configured in both deployment models and by using different tools. See the table below for more information. We update this table as new articles, new deployment models, and additional tools become available for this configuration. When an article is available, we link directly to it from the table.

[!INCLUDE [vpn-gateway-forcedtunnel](../../includes/vpn-gateway-table-forcedtunnel-include.md)]

## Requirements and considerations
Forced tunneling in Azure is configured via virtual network user defined routes (UDR). Redirecting traffic to an on-premises site is expressed as a Default Route to the Azure VPN gateway. The following section lists the current limitation of the routing table and routes for an Azure Virtual Network:

* Each virtual network subnet has a built-in, system routing table. The system routing table has the following 3 groups of routes:
  
  * **Local VNet routes:** Directly to the destination VMs in the same virtual network
  * **On premises routes:** To the Azure VPN gateway
  * **Default route:** Directly to the Internet. Note that packets destined to the private IP addresses not covered by the previous two routes will be dropped.
* With the release of user defined routes, you can create a routing table to add a default route, and then associate the routing table to your VNet subnet(s) to enable forced tunneling on those subnets.
* You need to set a "default site" among the cross-premises local sites connected to the virtual network.
* Forced tunneling must be associated with a VNet that has a dynamic routing VPN gateway (not a static gateway).
* ExpressRoute forced tunneling is not configured via this mechanism, but instead, is enabled by advertising a default route via the ExpressRoute BGP peering sessions. Please see the [ExpressRoute Documentation](https://azure.microsoft.com/documentation/services/expressroute/) for more information.

## Configuration overview
In the example below, the Frontend subnet is not forced tunneled. The workloads in the Frontend subnet can continue to accept and respond to customer requests from the Internet directly. The Mid-tier and Backend subnets are forced tunneled. Any outbound connections from these two subnets to the Internet will be forced or redirected back to an on-premises site via one of the S2S VPN tunnels.

This allows you to restrict and inspect Internet access from your virtual machines or cloud services in Azure, while continuing to enable your multi-tier service architecture required. You also have the option to apply forced tunneling to the entire virtual networks if there are no Internet-facing workloads in your virtual networks.

![Forced Tunneling](./media/vpn-gateway-about-forced-tunneling/forced-tunnel.png)

## Before you begin
Verify that you have the following items before beginning configuration.

* An Azure subscription. If you don't already have an Azure subscription, you can activate your [MSDN subscriber benefits](https://azure.microsoft.com/pricing/member-offers/msdn-benefits-details/) or sign up for a [free account](https://azure.microsoft.com/pricing/free-trial/).
* A configured virtual network. 
* The latest version of the Azure PowerShell cmdlets. See [How to install and configure Azure PowerShell](../powershell-install-configure.md) for more information about installing the PowerShell cmdlets.

## Configure forced tunneling
The procedure below will help you specify forced tunneling for a virtual network. The configuration steps correspond to the virtual network network configuration file (netcfg) example below. 

    <VirtualNetworkSite name="MultiTier-VNet" Location="North Europe">
     <AddressSpace>
      <AddressPrefix>10.1.0.0/16</AddressPrefix>
        </AddressSpace>
        <Subnets>
          <Subnet name="Frontend">
            <AddressPrefix>10.1.0.0/24</AddressPrefix>
          </Subnet>
          <Subnet name="Midtier">
            <AddressPrefix>10.1.1.0/24</AddressPrefix>
          </Subnet>
          <Subnet name="Backend">
            <AddressPrefix>10.1.2.0/23</AddressPrefix>
          </Subnet>
          <Subnet name="GatewaySubnet">
            <AddressPrefix>10.1.200.0/28</AddressPrefix>
          </Subnet>
        </Subnets>
        <Gateway>
          <ConnectionsToLocalNetwork>
            <LocalNetworkSiteRef name="DefaultSiteHQ">
              <Connection type="IPsec" />
            </LocalNetworkSiteRef>
            <LocalNetworkSiteRef name="Branch1">
              <Connection type="IPsec" />
            </LocalNetworkSiteRef>
            <LocalNetworkSiteRef name="Branch2">
              <Connection type="IPsec" />
            </LocalNetworkSiteRef>
            <LocalNetworkSiteRef name="Branch3">
              <Connection type="IPsec" />
            </LocalNetworkSiteRef>
        </Gateway>
      </VirtualNetworkSite>
    </VirtualNetworkSite>

In this example, the virtual network "MultiTier-VNet" has 3 subnets: *Frontend*, *Midtier*, and *Backend* subnets, with 4 cross premises connections: *DefaultSiteHQ*, and 3 *Branches*. 

The procedure steps will set the *DefaultSiteHQ* as the default site connection for forced tunneling, and configure the Midtier and Backend subnets to use forced tunneling.

1. Create a routing table. Use the following cmdlet to create your route table.
   
        New-AzureRouteTable –Name "MyRouteTable" –Label "Routing Table for Forced Tunneling" –Location "North Europe"
2. Add a default route to the routing table. 
   
    The cmdlet example below adds a default route to the routing table created in Step 1. Note that the only route supported is the destination prefix of "0.0.0.0/0" to the "VPNGateway" nexthop.
   
        Set-AzureRoute –RouteTable "MyRouteTable" –RouteName "DefaultRoute" –AddressPrefix "0.0.0.0/0" –NextHopType VPNGateway
3. Associate the routing table to the subnets. 
   
    After a routing table is created and a route added, use the cmdlet below to add or associate the route table to a VNet subnet. The samples below add the route table "MyRouteTable" to the Midtier and Backend subnets of VNet MultiTier-VNet.
   
        Set-AzureSubnetRouteTable -VirtualNetworkName "MultiTier-VNet" -SubnetName "Midtier" -RouteTableName "MyRouteTable"
   
        Set-AzureSubnetRouteTable -VirtualNetworkName "MultiTier-VNet" -SubnetName "Backend" -RouteTableName "MyRouteTable"
4. Assign a default site for forced tunneling. 
   
    In the preceding step, the sample cmdlet scripts created the routing table and associated the route table to two of the VNet subnets. The remaining step is to select a local site among the multi-site connections of the virtual network as the default site or tunnel.
   
        $DefaultSite = @("DefaultSiteHQ")
        Set-AzureVNetGatewayDefaultSite –VNetName "MultiTier-VNet" –DefaultSite "DefaultSiteHQ"

## Additional PowerShell cmdlets
### To delete a route table
    Remove-AzureRouteTable -Name <routeTableName>

### To list a route table
    Get-AzureRouteTable [-Name <routeTableName> [-DetailLevel <detailLevel>]]

### To delete a route from a route table
    Remove-AzureRouteTable –Name <routeTableName>

### To remove a route from a subnet
    Remove-AzureSubnetRouteTable –VirtualNetworkName <virtualNetworkName> -SubnetName <subnetName>

### To list the route table associated with a subnet
    Get-AzureSubnetRouteTable -VirtualNetworkName <virtualNetworkName> -SubnetName <subnetName>

### To remove a default site from a VNet VPN gateway
    Remove-AzureVnetGatewayDefaultSite -VNetName <virtualNetworkName>






