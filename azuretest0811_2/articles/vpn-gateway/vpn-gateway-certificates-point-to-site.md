---
title: Creating self-signed certificates for Point-to-Site VPN Gateway cross-premises configurations using makecert | Microsoft Azure
description: This article contains steps to use makecert to create self-signed root certificates on Windows 10.
services: vpn-gateway
documentationcenter: na
author: cherylmc
manager: carmonm
editor: ''
tags: azure-resource-manager

ms.service: vpn-gateway
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: infrastructure-services
ms.date: 04/26/2016
ms.author: cherylmc

---
# Working with self-signed root certificates for Point-to-Site configurations
The tasks below will help you create a root certificate using makecert and generate client certificates from the root certificate. The steps below are written for using makecert on Windows 10. 

## Create a self-signed root certificate
Makecert is one way of creating a self-signed root certificate. The steps below will walk you through creating a self-signed root certificate using makecert. These steps are not deployment-model specific. They are valid for both Resource Manager and classic.

### To create a self-signed root certificate
1. From a computer running Windows 10, download and install the [Windows Software Development Kit (SDK) for Windows 10](https://dev.windows.com/en-us/downloads/windows-10-sdk).
2. After installation, you can find the makecert.exe utility under this path: C:\Program Files (x86)\Windows Kits\10\bin\<arch>. 
   
    Example: 
   
        C:\Program Files (x86)\Windows Kits\10\bin\x64\makecert.exe
3. Next, create and install a root certificate in the Personal certificate store on your computer. The example below creates a corresponding *.cer* file that you'll later upload. Run the following command, as administrator, where *RootCertificateName* is the name that you want to use for the certificate. 
   
    Note: If you run the following example with no changes, the result will be a root certificate and the corresponding file *RootCertificateName.cer*. You can find the .cer file in the directory from which you ran the command. The certificate will be located in your Certificates - Current User\Personal\Certificates.
   
        makecert -sky exchange -r -n "CN=RootCertificateName" -pe -a sha1 -len 2048 -ss My "RootCertificateName.cer"
   
   > [!NOTE]
   > Because you have created a root certificate from which client certificates will be generated, you may want to export this certificate along with its private key and save it to a safe location where it may be recovered.
   > 
   > 

## Generate, export, and install client certificates
You can generate a client certificate from a self-signed root certificate, and then export and install the client certificate. The steps below are not deployment-model specific. They are valid for both Resource Manager and classic.

### To generate a client certificate from a self-signed root certificate.
The steps below will walk you through one way to generate a client certificate from a self-signed root certificate. You may generate multiple client certificates from the same root certificate. Each client certificate can then be exported and installed on the client computer. 

1. On the same computer that you used to create the self-signed root certificate, open a command prompt as administrator.
2. Change the directory to the location to which you want to save the client certificate file. *RootCertificateName* refers to the self-signed root certificate that you generated. If you run the following example (changing the RootCertificateName to the name of your root certificate), the result will be a client certificate named "ClientCertificateName" in your Personal certificate store.
3. Type the following command:
   
        makecert.exe -n "CN=ClientCertificateName" -pe -sky exchange -m 96 -ss My -in "RootCertificateName" -is my -a sha1
4. All certificates are stored in your Certificates - Current User\Personal\Certificates store on your computer. You can generate as many client certificates as needed based on this procedure.

### To export a client certificate
1. To export a client certificate, use *certmgr.msc*. Right-click the client certificate that you want to export, click **all tasks**, and then click **export**. This will open the Certificate Export Wizard.
2. In the Wizard, click **Next**, then select **Yes, export the private key**, and then click **Next**.
3. On the **Export File Format** page, you can leave the defaults selected. Then click **Next**. 
4. On the **Security** page, you must protect the private key. If you select to use a password, make sure to record or remember the password that you set for this certificate.Then click **Next**.
5. On the **File to Export**, **Browse** to the location to which you want to export the certificate. For **File name**, name the certificate file. Then click **Next**.
6. Click **Finish** to export the certificate.    

### To install a client certificate
Each client that you want to connect to your virtual network by using a Point-to-Site connection must have a client certificate installed. This certificate is in addition to the required VPN configuration package. The steps below will walk you through installing the client certificate manually.

1. Locate and copy the *.pfx* file to the client computer. On the client computer, double-click the *.pfx* file to install. Leave the **Store Location** as **Current User**, then click **Next**.
2. On the **File** to import page, don't make any changes. Click **Next**.
3. On the **Private key protection** page, input the password for the certificate if you used one, or verify that the security principal that is installing the certificate is correct, then click **Next**.
4. On the **Certificate Store** page, leave the default location, and then click **Next**.
5. Click **Finish**. On the **Security Warning** for the certificate installation, click **Yes**. The certificate is now successfully imported.

## Next steps
Continue with your Point-to-Site configuration. 

* For **Resource Manager** deployment model steps, see [Configure a Point-to-Site connection to a virtual network using PowerShell](vpn-gateway-howto-point-to-site-rm-ps.md). 
* For **classic** deployment model steps, see [Configure a Point-to-Site VPN connection to a VNet](vpn-gateway-point-to-site-create.md).

