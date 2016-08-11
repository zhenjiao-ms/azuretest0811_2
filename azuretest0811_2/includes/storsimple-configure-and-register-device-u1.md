<!--author=alkohli last changed: 02/22/2016-->


### To configure and register the device
1. Access the Windows PowerShell interface on your StorSimple device serial console. See [Use PuTTY to connect to the device serial console](#use-putty-to-connect-to-the-device-serial-console) for instructions. **Be sure to follow the procedure exactly or you will not be able to access the console.**
2. In the session that opens up, press Enter one time to get a command prompt. 
3. You will be prompted to choose the language that you would like to set for your device. Specify the language, and then press Enter. 
   
    ![StorSimple configure and register device 1](./media/storsimple-configure-and-register-device-u1/HCS_RegisterYourDevice1-U1-include.png)
4. In the serial console menu that is presented, choose option 1 to log on with full access. 
   
    ![StorSimple register device 2](./media/storsimple-configure-and-register-device-u1/HCS_RegisterYourDevice2_U1-include.png)
   
     Complete steps 5-12 to configure the minimum required network settings for your device. **These configuration steps need to be performed on the active controller of the device.** The serial console menu indicates the controller state in the banner message. If you are not connected to the active controller, disconnect and then connect to the active controller.
5. At the command prompt, type your password. The default device password is **Password1**.
6. Type the following command: `Invoke-HcsSetupWizard`. 
7. A setup wizard will appear to help you configure the network settings for the device. Supply the the following information: 
   
   * IP address for the DATA 0 network interface
   * Subnet mask
   * Gateway
   * IP address for Primary DNS server
     
        Note that the system is validating network settings after each step in the process.
     
     > [!NOTE]
     > You may have to wait for a few minutes for the subnet mask and the DNS settings to be applied. If you get a "Check the network connectivity to Data 0" error message, check the physical network connection on the DATA 0 network interface of your active controller.
     > 
8. (Optional) configure your web proxy server. Although web proxy configuration is optional, **be aware that if you use a web proxy, you can only configure it here**. For more information, go to [Configure web proxy for your device](../articles/storsimple/storsimple-configure-web-proxy.md).
9. Configure a Primary NTP server for your device. NTP servers are required, as your device must synchronize time so that it can authenticate with your cloud service providers. Ensure that your network allows NTP traffic to pass from your datacenter to the Internet. If this is not possible, specify an internal NTP server. 
10. For security reasons, the device administrator password expires after the first session, and you will need to change it now. When prompted, provide a device administrator password. A valid device administrator password must be between 8 and 15 characters. The password must contain three of the following: lowercase, uppercase, numeric, and special characters.
    
    <br/>![StorSimple register device 5](./media/storsimple-configure-and-register-device-u1/HCS_RegisterYourDevice5_U1-include.png)
11. The final step in the setup wizard registers your device with the StorSimple Manager service. For this, you will need the service registration key that you obtained in step 2. After you supply the registration key, you may need to wait for 2-3 minutes before the device is registered.
    
    > [!NOTE]
    > You can press Ctrl + C at any time to exit the setup wizard. If you have entered all the network settings (IP address for Data 0, Subnet mask, and Gateway), your entries will be retained.
    > 
    > 
    > 
    > 
    
    ![StorSimple register device 6](./media/storsimple-configure-and-register-device-u1/HCS_RegisterYourDevice6_U1-include.png)
12. After the device is registered, a Service Data Encryption key will appear. Copy this key and save it in a safe location. **This key will be required with the service registration key to register additional devices with the StorSimple Manager service.** Refer to [StorSimple security](../articles/storsimple/storsimple-security.md) for more information about this key.
    
    ![StorSimple register device 7](./media/storsimple-configure-and-register-device-u1/HCS_RegisterYourDevice7_U1-include.png)    
    
    > [!NOTE]
    > To copy the text from the serial console window, simply select the text. You should then be able to paste it in the clipboard or any text editor. DO NOT use Ctrl + C to copy the service data encryption key. Using Ctrl + C will cause you to exit the setup wizard. As a result, the device administrator password will not be changed and the device will revert to the default password.
    > 
13. Exit the serial console.
14. Return to the Azure classic portal, and complete the following steps:
    
    1. Double-click your StorSimple Manager service to access the **Quick Start** page.
    2. Click **View connected devices**.
    3. On the **Devices** page, verify that the device has successfully connected to the service by looking up the status. The device status should be **Online**.
       
        ![StorSimple Devices page](./media/storsimple-configure-and-register-device-u1/HCS_DevicesPageM_U1-include.png) 
       
        If the device status is **Offline**, wait for a couple of minutes for the device to come online. 
       
        If the device is still offline after a few minutes, then you need to make sure that your firewall network was configured as described in [networking requirements for your StorSimple device](../articles/storsimple/storsimple-system-requirements.md). 
       
        Verify that port 9354 is open for outbound communication as this is used by the service bus for StorSimple Manager Service-to-device communication.

