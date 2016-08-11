---
title: IoT Hub device management device jobs | Microsoft Azure
description: Azure IoT Hub for device management tutorial describing how to use device jobs to perform operations such as remote firmware update.
services: iot-hub
documentationcenter: .net
author: juanjperez
manager: timlt
editor: ''

ms.service: iot-hub
ms.devlang: dotnet
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: na
ms.date: 04/29/2016
ms.author: juanpere

---
# Tutorial: How to use device jobs to update device firmware (preview)
[!INCLUDE [iot-hub-device-management-job-selector](../../includes/iot-hub-device-management-jobs-selector.md)]

## Introduction
Azure IoT device management allows you to interact with physical devices using device jobs. Once you have identified the device twin (the service representation of a physical device), you can interact with its corresponding physical device using device jobs. Device jobs enable coordination of complex processes on multiple devices. This process can include multiple steps and long running operations.

There are six types of device jobs that are provided by Azure IoT Hub device management at present (we will add additional jobs as customers need them):

* **Firmware update**: Updates the firmware (or OS image) on the physical device.
* **Reboot**: Reboots the physical device.
* **Factory reset**: Reverts the firmware (or OS image) of the physical device to a factory provided backup image stored on the device.
* **Configuration update**: Configures the IoT Hub client agent running on the physical device.
* **Read device property**: Gets the most recent value of a device property on the physical device.
* **Write device property:** Changes a device property on the physical device.

For details on how to use each of these jobs, please see the [API documentation](iot-hub-sdks-summary.md).

You can query job history to understand the state of jobs that you have started. For some example queries, see [our query expression library](https://github.com/Azure/azure-iot-sdks/blob/dmpreview/doc/get_started/dm_queries/query-samples.md).

## Using device jobs to perform firmware update: architecture
The diagram below illustrates a firmware update device job interacting with a single physical device.

![](media/iot-hub-device-management-device-jobs/image1.png)

Steps for the firmware update device job:

1. The cloud based IoT solution starts the firmware update device job and provides the URI for the location of the firmware package. It is the responsibility of the IoT solution to place the firmware package in a location from where the device can download it.
2. When the physical device receives this URI, it automatically begins downloading from the provided URI.
3. Your code on the device receives the request from IoT Hub and downloads the firmware package from the provided location URI.
4. After it receives the download completed device status message, the device job instructs the device to apply the downloaded firmware image.
5. After the device applies the firmware image, it reboots, reconnects to the IoT Hub, and informs the IoT Hub that the new firmware was applied and the device job is then complete.

## Running the firmware update sample
The following sample extends the [Get started with Azure IoT Hub device management](iot-hub-device-management-get-started.md) tutorial functionality. Starting from having the different simulated devices running, it will start a job to update the firmware on all of them.

### Prerequisites
Before running this sample, you must have completed the steps in [Get started with Azure IoT Hub device management](iot-hub-device-management-get-started.md). That means your simulated devices must be running. If you completed the process before, please restart your simulated devices now.

### Starting the sample
To start the sample, you need to run `jobClient_scheduleJob.js`. This starts the firmware update process on all the simulated devices. Follow the steps below to start the sample:

1. From the root folder where you cloned the **azure-iot-sdks** repository, navigate to the **azure-iot-sdks/node/service/samples** directory.  
2. Open **jobClient_scheduleJob.js** and replace the placeholder with your IoT Hub connection string.
3. Run `node jobClient_scheduleJob.js`.

You should see output in the command line window showing seven device jobs tracking the simulated firmware update against the six simulated devices.

### Starting a device job
In general, device jobs are started using a number of **schedule&lt;JobName&gt;** methods on the **JobClient** instance. In the firmware update sample, we call the **scheduleFirmwareUpdate** method. Since we pass an array with 6 device ids, 7 device jobs are started, one for each device being updated and a parent device job used to track the other 6.

In the snippet below, a firmware update job is started. The call takes a string array of **deviceId** values as a parameter, representing the devices we want to update.

```
jobClient.scheduleFirmwareUpdate(jobId, deviceIds, packageURI, timeoutInMinutes, callback);
```

### Device simulator implementation details
In the previous sections, we show the implementation details of firmware update from the service standpoint (how to start a device job and query for its status). Now, we will discuss the corresponding implementation on the device side.

Azure IoT Hub device management client library handles communication between the device and the service, so all that remains is implementation of device specific logic. This consists of two pieces:

* Implement the device-specific firmware update process: this involves writing device-specific logic to download the firmware package and apply the update in the appropriate callbacks listed below. In the simulated sample, this is implemented in [the sample](https://github.com/Azure/azure-iot-sdks/blob/dmpreview/c/iotdm_client/samples/iotdm_simple_sample/iotdm_simple_sample.c):
  
  ```
  object_firmwareupdate *obj = get_firmwareupdate_object(0);
  obj->firmwareupdate_packageuri_write_callback = start_firmware_download;
  // platform specific code
  obj->firmwareupdate_update_execute_callback = start_firmware_update;
  //platform specific code
  ```
* Inform the service of the firmware update process: this involves modifying the firmware update state and firmware update result fields. You achieve this by calling the **set\_firmwareupdate\_state** and **set\_firmwareupdate\_updateresult** APIs. In the simulated sample, this is implemented in [the sample](https://github.com/Azure/azure-iot-sdks/blob/dmpreview/c/iotdm_client/samples/iotdm_simple_sample/iotdm_simple_sample.c).

## Next steps
To learn more about the Azure IoT Hub device management features you can go through the tutorials:

* [Enable managed devices behind an IoT gateway](iot-hub-gateway-device-management.md)
* [Introducing the Azure IoT Hub device management client library](iot-hub-device-management-library.md)
* The Azure IoT Hub DM client library provides an end to end sample using an [Intel Edison device](https://github.com/Azure/azure-iot-sdks/tree/dmpreview/c/iotdm_client/samples/iotdm_edison_sample).

To further explore the capabilities of IoT Hub, see:

* [Designing your solution](iot-hub-guidance.md)
* [Developer guide](iot-hub-devguide.md)
* [Simulating a device with the Gateway SDK](iot-hub-linux-gateway-sdk-simulated-device.md)
* [Using the Azure Portal to manage IoT Hub](iot-hub-manage-through-portal.md)

<!-- Images and links -->

[img-architecture]: media/iot-hub-device-management-device-jobs/image1.png
[img-output1]: media/iot-hub-device-management-device-jobs/image2.png
[img-output2]: media/iot-hub-device-management-device-jobs/image3.png
[img-properties]: media/iot-hub-device-management-device-jobs/image4.png

[lnk-apidocs]: iot-hub-sdks-summary.md
[lnk-twin-tutorial]: iot-hub-device-management-device-twin.md
[lnk-tutorial-queries]: iot-hub-device-management-device-query.md
[lnk-edison]: https://github.com/Azure/azure-iot-sdks/tree/dmpreview/c/iotdm_client/samples/iotdm_edison_sample
[lnk-get-started]: iot-hub-device-management-get-started.md
[lnk-github-firmware]: https://github.com/Azure/azure-iot-sdks/blob/dmpreview/c/iotdm_client/samples/iotdm_simple_sample/iotdm_simple_sample.c
[lnk-query-samples]: https://github.com/Azure/azure-iot-sdks/blob/dmpreview/doc/get_started/dm_queries/query-samples.md

[lnk-dm-gateway]: iot-hub-gateway-device-management.md
[lnk-library-c]: iot-hub-device-management-library.md

[lnk-design]: iot-hub-guidance.md
[lnk-devguide]: iot-hub-devguide.md
[lnk-gateway]: iot-hub-linux-gateway-sdk-simulated-device.md
[lnk-portal]: iot-hub-manage-through-portal.md