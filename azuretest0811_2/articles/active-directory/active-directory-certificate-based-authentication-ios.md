---
title: Get started with certificate based authentication on iOS | Microsoft Azure
description: Learn how to configure certificate based authentication in solutions with iOS devices
services: active-directory
author: markusvi
documentationcenter: na
manager: femila

ms.service: active-directory
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: identity
ms.date: 08/02/2016
ms.author: markvi

---
# Get started with certificate based authentication on iOS - Public Preview
> [!div class="op_single_selector"]
> * [iOS](active-directory-certificate-based-authentication-ios.md)
> * [Android](active-directory-certificate-based-authentication-android.md)
> 
> 

This topic shows you how to configure and utilize certificate based authentication (CBA) on an iOS device for users of tenants in Office 365 Enterprise, Business, and Education plans. 

CBA enables you to be authenticated by Azure Active Directory with a client certificate on an Android or iOS device when connecting your Exchange online account to: 

* Office mobile applications such as Microsoft Outlook and Microsoft Word   
* Exchange ActiveSync (EAS) clients 

Configuring this feature eliminates the need to enter a username and password combination into certain mail and Microsoft Office applications on your mobile device. 

## Supported scenarios and requirements
### General requirements
For all scenarios in this topic, the following tasks are required:  

* Access to certificate authority(s) to issue client certificates.  
* The certificates authority(s) must be configured in Azure Active Directory. You can find detailed steps on how to complete the configuration in the [Getting Started](#getting-started) section.  
* The root certificate authority and any intermediate certificate authorities must be configured in Azure Active Directory.  
* Each certificate authority must have a certificate revocation list (CRL) that can be referenced via an Internet facing URL.  
* The client certificate must be issued for client authentication.  
* For Exchange ActiveSync clients only, the client certificate must have the user’s routable email address in Exchange online in either the Principal Name or the RFC822 Name value of the Subject Alternative Name field. Azure Active Directory maps the RFC822 value to the Proxy Address attribute in the directory.  

### Office mobile applications support
| Apps | Support |
| --- | --- |
| Word / Excel / PowerPoint |![Check](./media/active-directory-certificate-based-authentication-ios/ic195031.png) |
| OneNote |![Check](./media/active-directory-certificate-based-authentication-ios/ic195031.png) |
| OneDrive |![Check](./media/active-directory-certificate-based-authentication-ios/ic195031.png) |
| Outlook |Coming soon |
| Yammer |![Check](./media/active-directory-certificate-based-authentication-ios/ic195031.png) |
| Skype for Business |Coming soon |

### Requirements
The device OS version must be iOS 9 and above 

A federation server must be configured.  

Azure Authenticator is required for Office applications on iOS.  

For Azure Active Directory to revoke a client certificate, the ADFS token must have the following claims:  

* `http://schemas.microsoft.com/ws/2008/06/identity/claims/<serialnumber>`  
  (The serial number of the client certificate) 
* `http://schemas.microsoft.com/2012/12/certificatecontext/field/<issuer>`  
  (The string for the issuer of the client certificate) 

Azure Active Directory adds these claims to the refresh token if they are available in the ADFS token (or any other SAML token). When the refresh token needs to be validated, this information is used to check the revocation. 

As a best practice, you should update the ADFS error pages with the following:

* The requirement for installing the Azure Authenticator on iOS
* Instructions on how to get a user certificate. 

For more details, see [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx).  

### Exchange ActiveSync clients support
On iOS 9 or later, the native iOS mail client is supported. For all other Exchange ActiveSync applications, to determine if this feature is supported, contact your application developer.  

## Getting started
To get started, you need to configure the certificate authorities in Azure Active Directory. For each certificate authority, upload the following: 

* The public portion of the certificate, in *.cer* format 
* The Internet facing URLs where the Certificate Revocation Lists (CRLs) reside

Below is the schema for a certificate authority: 

    class TrustedCAsForPasswordlessAuth 
    { 
       CertificateAuthorityInformation[] certificateAuthorities;    
    } 

    class CertificateAuthorityInformation 

    { 
        CertAuthorityType authorityType; 
        X509Certificate trustedCertificate; 
        string crlDistributionPoint; 
        string deltaCrlDistributionPoint; 
        string trustedIssuer; 
        string trustedIssuerSKI; 
    }                

    enum CertAuthorityType 
    { 
        RootAuthority = 0, 
        IntermediateAuthority = 1 
    } 


To upload the information, you can use  the Azure AD module through Windows PowerShell.  
Below are examples for adding, removing or modifying a certificate authority. 

### Configuring your Azure AD tenant for certificate based authentication
1. Start Windows PowerShell with administrator privileges. 
2. Install the Azure AD module. You need to install Version [1.1.143.0](http://www.powershellgallery.com/packages/AzureADPreview/1.1.143.0) or higher.  
   
        Install-Module -Name AzureADPreview –RequiredVersion 1.1.143.0 
3. Connect to your target tenant: 
   
        Connect-AzureAD 

### Adding a new certificate authority
1. Set various properties of the certificate authority and add it to Azure Active Directory: 
   
        $cert=Get-Content -Encoding byte "[LOCATION OF THE CER FILE]" 
        $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation 
        $new_ca.AuthorityType=0 
        $new_ca.TrustedCertificate=$cert 
        New-AzureADTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca 
2. Get the Certificate Authorities: 
   
        Get-AzureADTrustedCertificateAuthority 

### Retrieving the list certificate authorities
Retrieve the certificate authorities currently stored in Azure Active Directory for your tenant: 

        Get-AzureADTrustedCertificateAuthority 


### Removing a certificate authority
1. Retrieve the certificate authorities: 
   
     $c=Get-AzureADTrustedCertificateAuthority 
2. Remove the certificate for the certificate authority: 
   
        Remove-AzureADTrustedCertificateAuthority -CertificateAuthorityInformation $c[2] 

### Modfiying a certificate authority
1. Retrieve the certificate authorities: 
   
     $c=Get-AzureADTrustedCertificateAuthority 
2. Modify properties on the certificate authority: 
   
        $c[0].AuthorityType=1 
3. Set the **Certificate Authority**: 
   
        Set-AzureADTrustedCertificateAuthority -CertificateAuthorityInformation $c[0] 

## Testing Office mobile applications
To test certificate authentication on your mobile Office application: 

1. On your test device, install an Office mobile application (e.g. OneDrive) from the App Store.
2. Verify that the user certificate has been provisioned to your test device. 
3. Launch the application. 
4. Enter your user name, and then pick the user certificate you want to use. 

You should be successfully signed in. 

## Testing Exchange ActiveSync client applications
To access Exchange ActiveSync via certificate based authentication, an EAS profile containing the client certificate must be available to application. The EAS profile must contain the following information:

* The user certificate to be used for authentication 
* The EAS endpoint must be outlook.office365.com (as this feature is currently supported only in the Exchange online multi-tenant environment)

An EAS profile can be configured and placed on the device through the utilization of an MDM such as Intune or by manually placing the certificate in the EAS profile on the device.  

### Testing EAS client applications on iOS
To test certificate authentication with the native mail application on iOS 9 or above: 

1. Configure an EAS profile that satisfies the requirements above. 
2. Install the profile on the iOS device (either using an MDM, such as Intune, or the Apple Configurator application)
3. Once the profile is properly installed, open the native Mail application, and verify that mail is synchronizing

## Revocation
To revoke a client certificate, Azure Active Directory fetches the certificate revocation list (CRL) from the URLs uploaded as part of certificate authority information and caches it. The last publish timestamp (**Effective Date** property) in the CRL is used to ensure the CRL is still valid. The CRL is periodically referenced to revoke access to certificates that are a part of the list.

If a more instant revocation is required (for example, if a user loses a device), the authorization token of the user can be invalidated. To invalidate the authorization token, set the **StsRefreshTokenValidFrom** field for this particular user using Windows PowerShell. You must update the **StsRefreshTokenValidFrom** field for each user you want to revoke access for.

To ensure that the revocation persists, you must set the **Effective Date** of the CRL to a date after the value set by **StsRefreshTokenValidFrom** and ensure the certificate in question is in the CRL.

The following steps outline the process for updating and invalidating the authorization token by setting the **StsRefreshTokenValidFrom** field. 

1. Connect with admin credentials to the MSOL service: 
   
        $msolcred = get-credential 
        connect-msolservice -credential $msolcred 
2. Retrieve the current StsRefreshTokensValidFrom value for a user: 
   
     $user = Get-MsolUser -UserPrincipalName test@yourdomain.com` 
     $user.StsRefreshTokensValidFrom 
3. Configure a new StsRefreshTokensValidFrom value for the user equal to the current timestamp: 
   
     Set-MsolUser -UserPrincipalName test@yourdomain.com -StsRefreshTokensValidFrom ("03/05/2016")

The date you set must be in the future. If the date is not in the future, the **StsRefreshTokensValidFrom** property is not set. If the date is in the future, **StsRefreshTokensValidFrom** is set to the current time (not the date indicated by Set-MsolUser command). 

<!--Image references-->
[1]: ./media/active-directory-certificate-based-authentication-ios/ic195031.png