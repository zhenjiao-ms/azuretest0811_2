---
title: Azure IoT Hub for C# getting started | Microsoft Azure
description: Azure IoT Hub with C# getting started tutorial. Use Azure IoT Hub and C# with the Microsoft Azure IoT SDKs to implement an Internet of Things solution.
services: iot-hub
documentationcenter: .net
author: dominicbetts
manager: timlt
editor: ''

ms.service: iot-hub
ms.devlang: dotnet
ms.topic: hero-article
ms.tgt_pltfrm: na
ms.workload: na
ms.date: 06/16/2016
ms.author: dobett

---
# Get started with Azure IoT Hub for .NET
[!INCLUDE [iot-hub-selector-get-started](../../includes/iot-hub-selector-get-started.md)]

At the end of this tutorial, you will have three Windows console applications:

* **CreateDeviceIdentity**, which creates a device identity and associated security key to connect your simulated device.
* **ReadDeviceToCloudMessages**, which displays the telemetry sent by your simulated device.
* **SimulatedDevice**, which connects to your IoT hub with the device identity created earlier, and sends a telemetry message every second by using the AMQPS protocol.

> [!NOTE]
> For information about the various SDKs that you can use to build both applications to run on devices, and your solution back end, see [IoT Hub SDKs](iot-hub-sdks-summary.md).
> 
> 

To complete this tutorial, you'll need the following:

* Microsoft Visual Studio 2015.
* An active Azure account. (If you don't have an account, you can create a free trial account in just a couple of minutes. For details, see [Azure Free Trial](http://azure.microsoft.com/pricing/free-trial/).)

[!INCLUDE [iot-hub-get-started-create-hub](../../includes/iot-hub-get-started-create-hub.md)]

You have now created your IoT hub, and you have the hostname and connection string that you need to complete the rest of this tutorial.

## Create a device identity
In this section, you'll create a Windows console app that creates a new device identity in the identity registry in your IoT hub. A device cannot connect to IoT hub unless it has an entry in the device identity registry. For more information, see the "Device identity registry" section of the [IoT Hub Developer Guide](iot-hub-devguide.md#identityregistry). When you run this console app, it generates a unique device ID and key that your device can use to identify itself when it sends device-to-cloud messages to IoT Hub.

1. In Visual Studio, add a new Visual C# Windows Classic Desktop project to the current solution by using the **Console Application** project template. Make sure the .NET Framework version is 4.5.1 or later. Name the project **CreateDeviceIdentity**.
   
    ![New Visual C# Windows Classic Desktop project](./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp1.png)
2. In Solution Explorer, right-click the **CreateDeviceIdentity** project, and then click **Manage NuGet Packages**.
3. In the **NuGet Package Manager** window, select **Browse**, search for **microsoft.azure.devices**, select **Install** to install the **Microsoft.Azure.Devices** package, and accept the terms of use. This downloads, installs, and adds a reference to the [Microsoft Azure IoT Service SDK](https://www.nuget.org/packages/Microsoft.Azure.Devices/) NuGet package and its dependencies.
   
    ![NuGet Package Manager window](./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp2.png)
4. Add the following `using` statements at the top of the **Program.cs** file:
   
        using Microsoft.Azure.Devices;
        using Microsoft.Azure.Devices.Common.Exceptions;
5. Add the following fields to the **Program** class. Replace the placeholder value with the connection string for the IoT hub that you created in the previous section.
   
        static RegistryManager registryManager;
        static string connectionString = "{iothub connection string}";
6. Add the following method to the **Program** class:
   
        private static async Task AddDeviceAsync()
        {
            string deviceId = "myFirstDevice";
            Device device;
            try
            {
                device = await registryManager.AddDeviceAsync(new Device(deviceId));
            }
            catch (DeviceAlreadyExistsException)
            {
                device = await registryManager.GetDeviceAsync(deviceId);
            }
            Console.WriteLine("Generated device key: {0}", device.Authentication.SymmetricKey.PrimaryKey);
        }
   
    This method creates a new device identity with ID **myFirstDevice**. (If that device ID already exists in the registry, the code simply retrieves the existing device information.) The app then displays the primary key for that identity. You will use this key in the simulated device to connect to your IoT hub.
7. Finally, add the following lines to the **Main** method:
   
        registryManager = RegistryManager.CreateFromConnectionString(connectionString);
        AddDeviceAsync().Wait();
        Console.ReadLine();
8. Run this application, and make a note of the device key.
   
    ![Device key generated by the application](./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp3.png)

> [!NOTE]
> The IoT Hub identity registry only stores device identities to enable secure access to the hub. It stores device IDs and keys to use as security credentials, and an enabled/disabled flag that you can use to disable access for an individual device. If your application needs to store other device-specific metadata, it should use an application-specific store. For more information, see [IoT Hub Developer Guide](iot-hub-devguide.md#identityregistry).
> 
> 

## Receive device-to-cloud messages
In this section, you'll create a Windows console app that reads device-to-cloud messages from IoT Hub. An IoT hub exposes an [Azure Event Hubs](../event-hubs/event-hubs-overview.md)-compatible endpoint to enable you to read device-to-cloud messages. To keep things simple, this tutorial creates a basic reader that is not suitable for a high throughput deployment. To learn how to process device-to-cloud messages at scale, see the [Process device-to-cloud messages](iot-hub-csharp-csharp-process-d2c.md) tutorial. For further information about how to process messages from Event Hubs, see the [Get Started with Event Hubs](../event-hubs/event-hubs-csharp-ephcs-getstarted.md) tutorial. (This tutorial is applicable to the IoT Hub Event Hubs-compatible endpoints.)

> [!NOTE]
> The Event Hubs-compatible endpoint for reading device-to-cloud messages always uses the AMQPS protocol.
> 
> 

1. In Visual Studio, add a new Visual C# Windows Classic Desktop project to the current solution, by using the **Console  Application** project template. Make sure the .NET Framework version is 4.5.1 or later. Name the project **ReadDeviceToCloudMessages**.
   
    ![New Visual C# Windows Classic Desktop project](./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp1.png)
2. In Solution Explorer, right-click the **ReadDeviceToCloudMessages** project, and then click **Manage NuGet Packages**.
3. In the **NuGet Package Manager** window, search for **WindowsAzure.ServiceBus**, select **Install**, and accept the terms of use. This downloads, installs, and adds a reference to [Azure Service Bus](https://www.nuget.org/packages/WindowsAzure.ServiceBus), with all its dependencies. This package enables the application to connect to the Event Hubs-compatible endpoint on your IoT hub.
4. Add the following `using` statements at the top of the **Program.cs** file:
   
        using Microsoft.ServiceBus.Messaging;
        using System.Threading;
5. Add the following fields to the **Program** class. Replace the placeholder value with the connection string for the IoT hub you created in the "Create an IoT hub" section.
   
        static string connectionString = "{iothub connection string}";
        static string iotHubD2cEndpoint = "messages/events";
        static EventHubClient eventHubClient;
6. Add the following method to the **Program** class:
   
        private static async Task ReceiveMessagesFromDeviceAsync(string partition, CancellationToken ct)
        {
            var eventHubReceiver = eventHubClient.GetDefaultConsumerGroup().CreateReceiver(partition, DateTime.UtcNow);
            while (true)
            {
                if (ct.IsCancellationRequested) break;
                EventData eventData = await eventHubReceiver.ReceiveAsync();
                if (eventData == null) continue;
   
                string data = Encoding.UTF8.GetString(eventData.GetBytes());
                Console.WriteLine("Message received. Partition: {0} Data: '{1}'", partition, data);
            }
        }
   
    This method uses an **EventHubReceiver** instance to receive messages from all the IoT hub device-to-cloud receive partitions. Notice how you pass a `DateTime.Now` parameter when you create the **EventHubReceiver** object, so that it only receives messages sent after it starts. This is useful in a test environment so you can see the current set of messages, but in a production environment your code should make sure that it processes all the messages. For more information, see the [How to process IoT Hub device-to-cloud messages](iot-hub-csharp-csharp-process-d2c.md) tutorial.
7. Finally, add the following lines to the **Main** method:
   
        Console.WriteLine("Receive messages. Ctrl-C to exit.\n");
        eventHubClient = EventHubClient.CreateFromConnectionString(connectionString, iotHubD2cEndpoint);
   
        var d2cPartitions = eventHubClient.GetRuntimeInformation().PartitionIds;
   
        CancellationTokenSource cts = new CancellationTokenSource();
   
        System.Console.CancelKeyPress += (s, e) =>
        {
          e.Cancel = true;
          cts.Cancel();
          Console.WriteLine("Exiting...");
        };
   
        var tasks = new List<Task>();
        foreach (string partition in d2cPartitions)
        {
           tasks.Add(ReceiveMessagesFromDeviceAsync(partition, cts.Token));
        }  
        Task.WaitAll(tasks.ToArray());

## Create a simulated device app
In this section, you'll create a Windows console app that simulates a device that sends device-to-cloud messages to an IoT hub.

1. In Visual Studio, add a new Visual C# Windows Classic Desktop project to the current solution, by using the **Console  Application** project template. Make sure the .NET Framework version is 4.5.1 or later. Name the project **SimulatedDevice**.
   
    ![New Visual C# Windows Classic Desktop project](./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp1.png)
2. In Solution Explorer, right-click the **SimulatedDevice** project, and then click **Manage NuGet Packages**.
3. In the **NuGet Package Manager** window, select **Browse**, search for **Microsoft.Azure.Devices.Client**, select **Install** to install the **Microsoft.Azure.Devices.Client** package, and accept the terms of use. This downloads, installs, and adds a reference to the [Azure IoT - Device SDK NuGet package](https://www.nuget.org/packages/Microsoft.Azure.Devices.Client/) and its dependencies.
4. Add the following `using` statement at the top of the **Program.cs** file:
   
        using Microsoft.Azure.Devices.Client;
        using Newtonsoft.Json;
5. Add the following fields to the **Program** class. Substitute the placeholder values with the IoT hub hostname you retrieved in the "Create an IoT hub" section, and the device key retrieved in the "Create a device identity" section.
   
        static DeviceClient deviceClient;
        static string iotHubUri = "{iot hub hostname}";
        static string deviceKey = "{device key}";
6. Add the following method to the **Program** class:
   
        private static async void SendDeviceToCloudMessagesAsync()
        {
            double avgWindSpeed = 10; // m/s
            Random rand = new Random();
   
            while (true)
            {
                double currentWindSpeed = avgWindSpeed + rand.NextDouble() * 4 - 2;
   
                var telemetryDataPoint = new
                {
                    deviceId = "myFirstDevice",
                    windSpeed = currentWindSpeed
                };
                var messageString = JsonConvert.SerializeObject(telemetryDataPoint);
                var message = new Message(Encoding.ASCII.GetBytes(messageString));
   
                await deviceClient.SendEventAsync(message);
                Console.WriteLine("{0} > Sending message: {1}", DateTime.Now, messageString);
   
                Task.Delay(1000).Wait();
            }
        }
   
    This method sends a new device-to-cloud message every second. The message contains a JSON-serialized object, with the device ID and a randomly generated number to simulate a wind speed sensor.
7. Finally, add the following lines to the **Main** method:
   
        Console.WriteLine("Simulated device\n");
        deviceClient = DeviceClient.Create(iotHubUri, new DeviceAuthenticationWithRegistrySymmetricKey("myFirstDevice", deviceKey));
   
        SendDeviceToCloudMessagesAsync();
        Console.ReadLine();
   
   By default, the **Create** method creates a **DeviceClient** instance that uses the AMQP protocol to communicate with IoT Hub. To use the HTTPS protocol, use the override of the **Create** method that enables you to specify the protocol. If you use the HTTPS protocol, you should also add the **Microsoft.AspNet.WebApi.Client** NuGet package to your project to include the **System.Net.Http.Formatting** namespace.

This tutorial takes you through the steps to create an IoT Hub device client. You can also use the [Connected Service for Azure IoT Hub](https://visualstudiogallery.msdn.microsoft.com/e254a3a5-d72e-488e-9bd3-8fee8e0cd1d6) Visual Studio extension to add the necessary code to your device client application.

> [!NOTE]
> To keep things simple, this tutorial does not implement any retry policy. In production code, you should implement retry policies (such as an exponential backoff), as suggested in the MSDN article [Transient Fault Handling](https://msdn.microsoft.com/library/hh680901\(v=pandp.50\).aspx).
> 
> 

## Run the applications
You are now ready to run the applications.

1. In Visual Studio, in Solution Explorer, right-click your solution, and then click **Set StartUp projects**. Select **Multiple startup projects**, and then select **Start** as the action for both the **ReadDeviceToCloudMessages** and **SimulatedDevice** projects.
   
    ![Startup project properties](./media/iot-hub-csharp-csharp-getstarted/run-apps1.png)
2. Press **F5** to start both apps running. The console output from the **SimulatedDevice** app shows the messages your simulated device sends to your IoT hub. The console output from the **ReadDeviceToCloudMessages** app shows the messages that your IoT hub receives.
   
    ![Console output from apps](./media/iot-hub-csharp-csharp-getstarted/run-apps2.png)
3. The **Usage** tile in the [Azure portal](https://portal.azure.com/) shows the number of messages sent to the hub:
   
    ![Azure portal Usage tile](./media/iot-hub-csharp-csharp-getstarted/usage.png)

## Next steps
In this tutorial, you configured a new IoT hub in the portal, and then created a device identity in the hub's identity registry. You used this device identity to enable the simulated device app to send device-to-cloud messages to the hub. You also created an app that displays the messages received by the hub. 

To continue getting started with IoT Hub and to explore other IoT scenarios see:

* [Connecting your device](https://azure.microsoft.com/develop/iot/)
* [Getting started with device management](iot-hub-device-management-get-started.md)
* [Getting started with the Gateway SDK](iot-hub-linux-gateway-sdk-get-started.md)

To learn how to extend your your IoT solution and process device-to-cloud messages at scale, see the [Process device-to-cloud messages](iot-hub-csharp-csharp-process-d2c.md) tutorial.

<!-- Images. -->
[41]: ./media/iot-hub-csharp-csharp-getstarted/run-apps1.png
[42]: ./media/iot-hub-csharp-csharp-getstarted/run-apps2.png
[43]: ./media/iot-hub-csharp-csharp-getstarted/usage.png
[10]: ./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp1.png
[11]: ./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp2.png
[12]: ./media/iot-hub-csharp-csharp-getstarted/create-identity-csharp3.png

<!-- Links -->
[lnk-process-d2c-tutorial]: iot-hub-csharp-csharp-process-d2c.md

[lnk-hub-sdks]: iot-hub-sdks-summary.md
[lnk-free-trial]: http://azure.microsoft.com/pricing/free-trial/
[lnk-portal]: https://portal.azure.com/

[lnk-eventhubs-tutorial]: ../event-hubs/event-hubs-csharp-ephcs-getstarted.md
[lnk-devguide-identity]: iot-hub-devguide.md#identityregistry
[lnk-servicebus-nuget]: https://www.nuget.org/packages/WindowsAzure.ServiceBus
[lnk-event-hubs-overview]: ../event-hubs/event-hubs-overview.md

[lnk-nuget-service-sdk]: https://www.nuget.org/packages/Microsoft.Azure.Devices/
[lnk-device-nuget]: https://www.nuget.org/packages/Microsoft.Azure.Devices.Client/
[lnk-transient-faults]: https://msdn.microsoft.com/library/hh680901(v=pandp.50).aspx
[lnk-connected-service]: https://visualstudiogallery.msdn.microsoft.com/e254a3a5-d72e-488e-9bd3-8fee8e0cd1d6
[lnk-device-management]: iot-hub-device-management-get-started.md
[lnk-gateway-SDK]: iot-hub-linux-gateway-sdk-get-started.md
[lnk-connect-device]: https://azure.microsoft.com/develop/iot/