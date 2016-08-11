

To register the app for push notifications through Apple Push Notification Service (APNS), you must create a new push certificate, App ID, and provisioning profile for the project on Apple's developer portal. The App ID will contain the configuration settings that enable your app to send and receive push notifications. These settings will include the push notification certificate needed to authenticate with Apple Push Notification Service (APNS) when sending and receiving push notifications. For more information on these concepts see the official [Apple Push Notification Service](http://go.microsoft.com/fwlink/p/?LinkId=272584) documentation.

#### Generate the Certificate Signing Request file for the push certificate
These steps walk you through creating the certificate signing request. This will be used to generate a push certificate to be used with APNS.

1. On your Mac, run the Keychain Access tool. It can be opened from the **Utilities** folder or the **Other** folder on the launch pad.
2. Click **Keychain Access**, expand **Certificate Assistant**, then click **Request a Certificate from a Certificate Authority...**.
   
      ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-request-cert-from-ca.png)
3. Select your **User Email Address** and **Common Name** , make sure that **Saved to disk** is selected, and then click **Continue**. Leave the **CA Email Address** field blank as it is not required.
   
      ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-csr-info.png)
4. Type a name for the Certificate Signing Request (CSR) file in **Save As**, select the location in **Where**, then click **Save**.
   
      ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-save-csr.png)
   
      This saves the CSR file in the selected location; the default location is in the Desktop. Remember the location chosen for this file.

#### Register your app for push notifications
Create a new Explicit App ID for your application with Apple and also configure it for push notifications.  

1. Navigate to the [iOS Provisioning Portal](http://go.microsoft.com/fwlink/p/?LinkId=272456) at the Apple Developer Center, log on with your Apple ID, click **Identifiers**, then click **App IDs**, and finally click on the **+** sign to register a new app.
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-ios-appids.png)
2. Update the following three fields for your new app and then click **Continue**:
   
   * **Name**: Type a descriptive name for your app in the **Name** field in the **App ID Description** section.
   * **Bundle Identifier**: Under the **Explicit App ID** section, enter a **Bundle Identifier** in the form `<Organization Identifier>.<Product Name>` as mentioned in the [App Distribution Guide](https://developer.apple.com/library/mac/documentation/IDEs/Conceptual/AppDistributionGuide/ConfiguringYourApp/ConfiguringYourApp.html#//apple_ref/doc/uid/TP40012582-CH28-SW8). This must match what is also used in the XCode, Xamarin, or Cordova project for your app.
   * **Push Notifications**: Check the **Push Notifications** option in the **App Services** section, .
     
     ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-new-appid-info.png)
3. On the Confirm your App ID screen, review the setting and after you have verified them click **Submit**
4. Once you have submitted the new App ID, you will see the **Registration complete** screen. Click **Done**.
5. In the Developer Center, under App IDs, locate the app ID that you just created, and click on its row. Clicking on the app ID row will display the app details. Click the **Edit** button at the bottom.
6. Scroll to the bottom of the screen, and click the **Create Certificate...** button under the section **Development Push SSL Certificate**.
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-appid-create-cert.png)
   
       This will display the "Add iOS Certificate" assistant.
   
   > [!NOTE]
   > This tutorial uses a development certificate. The same process is used when registering a production certificate. Just make sure that you use the same certificate type when sending notifications.
   > 
7. Click **Choose File**, browse to the location where you saved the CSR for your push certificate. Then click **Generate**.
   
      ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-appid-cert-choose-csr.png)
8. After the certificate is created by the portal, click the **Download** button.
   
      ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-appid-download-cert.png)
   
       This downloads the signing certificate and saves it to your computer in your Downloads folder.
   
      ![](./media/notification-hubs-enable-apple-push-notifications/notification-hubs-cert-downloaded.png)
   
   > [!NOTE]
   > By default, the downloaded file a development certificate is named **aps_development.cer**.
   > 
9. Double-click the downloaded push certificate **aps_development.cer**. This installs the new certificate in the Keychain, as shown below:
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-cert-in-keychain.png)
   
   > [!NOTE]
   > The name in your certificate might be different, but it will be prefixed with **Apple Development iOS Push Services:**.
   > 
10. In Keychain Access, right-click the new push certificate that you just created in the **Certificates** category. Click **Export**, name the file, select the **.p12** format, and then click **Save**.
    
    Remember the file name and location of the exported .p12 push certificate. It will be used to enable authentication with APNS by uploading it on the Azure Classic Portal.

#### Create a provisioning profile for the app
1. Back in the <a href="http://go.microsoft.com/fwlink/p/?LinkId=272456" target="_blank">iOS Provisioning Portal</a>, select **Provisioning Profiles**, select **All**, and then click the **+** button to create a new profile. This launches the **Add iOS Provisiong Profile** Wizard
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-new-provisioning-profile.png)
2. Select **iOS App Development** under **Development** as the provisiong profile type, and click **Continue**.
3. Next, select the app ID you just created from the **App ID** drop-down list, and click **Continue**
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-select-appid-for-provisioning.png)
4. In the **Select certificates** screen, select your development certificate used for code signing, and click **Continue**. This is a signing certificate, not the push certificate you just created.
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-provisioning-select-cert.png)
5. Next, select the **Devices** to use for testing, and click **Continue**
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-provisioning-select-devices.png)
6. Finally, pick a name for the profile in **Profile Name**, click **Generate**.
   
       ![](./media/notification-hubs-xamarin-enable-apple-push-notifications/notification-hubs-provisioning-name-profile.png)

