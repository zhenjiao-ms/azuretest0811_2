---
title: Configuring Application Insights SDK with ApplicationInsights.config or .xml
description: Enable or disable data collection modules, and add performance counters and other parameters
services: application-insights
documentationcenter: ''
author: OlegAnaniev-MSFT
editor: alancameronwills
manager: douge

ms.service: application-insights
ms.workload: tbd
ms.tgt_pltfrm: ibiza
ms.devlang: na
ms.topic: article
ms.date: 03/12/2016
ms.author: awills

---
# Configuring the Application Insights SDK with ApplicationInsights.config or .xml
The Application Insights .NET SDK consists of a number of NuGet packages. The 
[core package](http://www.nuget.org/packages/Microsoft.ApplicationInsights) provides the API for sending telemetry to 
the Application Insights. [Additional packages](http://www.nuget.org/packages?q=Microsoft.ApplicationInsights) provide 
telemetry *modules* and *initializers* for automatically tracking telemetry from your application and its context. By 
adjusting the configuration file, you can enable or disable telemetry modules and initializers, and set parameters for 
some of them.

The configuration file is named `ApplicationInsights.config` or `ApplicationInsights.xml`, depending on the type of your
application. It is automatically added to your project when you [install most versions of the SDK](app-insights-overview.md). It is also added to a web app 
by [Status Monitor on an IIS server](app-insights-monitor-performance-live-website-now.md), or when you select the Appplication Insights 
[extension for an Azure website or VM](../azure-portal/insights-perf-analytics.md).

There isn't an equivalent file to control the [SDK in a web page](app-insights-javascript.md).

This document describes the sections you see in the configuration file, how they control the components of the SDK, and which NuGet packages load those components.

## Telemetry Modules (ASP.NET)
Each telemetry module collects a specific type of data and uses the core API to send the data. The modules are installed by different NuGet packages, which also add the required lines to the .config file.

There's a node in the configuration file for each module. To disable a module, delete the node or comment it out.

### Dependency Tracking
[Dependency tracking](app-insights-dependencies.md) collects telemetry about calls your app makes to databases and external services and databases. To allow this module to work in an IIS server, you need to [install Status Monitor](app-insights-monitor-performance-live-website-now.md). To use it in Azure web apps or VMs, [select the Application Insights extension](../azure-portal/insights-perf-analytics.md).

You can also write your own dependency tracking code using the [TrackDependency API](app-insights-api-custom-events-metrics.md#track-dependency).

* `Microsoft.ApplicationInsights.DependencyCollector.DependencyTrackingTelemetryModule`
* [Microsoft.ApplicationInsights.DependencyCollector](http://www.nuget.org/packages/Microsoft.ApplicationInsights.DependencyCollector) NuGet package.

### Performance collector
[Collects system performance counters](app-insights-web-monitor-performance.md#system-performance-counters) such as CPU, memory and network load from IIS installations. You can specify which counters to collect, including performance counters you have set up yourself.

* `Microsoft.ApplicationInsights.Extensibility.PerfCounterCollector.PerformanceCollectorModule`
* [Microsoft.ApplicationInsights.PerfCounterCollector](http://www.nuget.org/packages/Microsoft.ApplicationInsights.PerfCounterCollector) NuGet package.

### Application Insights Diagnostics Telemetry
The `DiagnosticsTelemetryModule` reports errors in the Application Insights instrumentation code itself. For example, 
if the code cannot access performance counters or if an `ITelemetryInitializer` throws an exception. Trace telemetry 
tracked by this module appears in the [Diagnostic Search](app-insights-diagnostic-search.md). Sends diagnostic data to dc.services.vsallin.net.

* `Microsoft.ApplicationInsights.Extensibility.Implementation.Tracing.DiagnosticsTelemetryModule`
* [Microsoft.ApplicationInsights](http://www.nuget.org/packages/Microsoft.ApplicationInsights) NuGet package. If you only install this package, the ApplicationInsights.config file is not automatically created. 

### Developer Mode
`DeveloperModeWithDebuggerAttachedTelemetryModule` forces the Application Insights `TelemetryChannel` to send data immediately, one telemetry item at a time, when a debugger is attached to the application process. This reduces the amount of time between the moment when your application tracks telemetry and when it appears on the Application Insights portal. It causes significant overhead in CPU and network bandwidth.

* `Microsoft.ApplicationInsights.WindowsServer.DeveloperModeWithDebuggerAttachedTelemetryModule`
* [Application Insights Windows Server](http://www.nuget.org/packages/Microsoft.ApplicationInsights.WindowsServer/) NuGet package

### Web Request Tracking
Reports the [response time and result code](app-insights-asp-net.md) of HTTP requests. 

* `Microsoft.ApplicationInsights.Web.RequestTrackingTelemetryModule`
* [Microsoft.ApplicationInsights.Web](http://www.nuget.org/packages/Microsoft.ApplicationInsights.Web) NuGet package

### Exception tracking
`ExceptionTrackingTelemetryModule` tracks unhandled exceptions in your web app. See [Failures and exceptions](app-insights-asp-net-exceptions.md).

* `Microsoft.ApplicationInsights.Web.ExceptionTrackingTelemetryModule`
* [Microsoft.ApplicationInsights.Web](http://www.nuget.org/packages/Microsoft.ApplicationInsights.Web) NuGet package
* `Microsoft.ApplicationInsights.WindowsServer.UnobservedExceptionTelemetryModule` - tracks [unobserved task exceptions](http://blogs.msdn.com/b/pfxteam/archive/2011/09/28/task-exception-handling-in-net-4-5.aspx).
* `Microsoft.ApplicationInsights.WindowsServer.UnhandledExceptionTelemetryModule` - tracks unhandled exceptions for worker roles, windows services, and console applications.
* [Application Insights Windows Server](http://www.nuget.org/packages/Microsoft.ApplicationInsights.WindowsServer/) NuGet package.

### Microsoft.ApplicationInsights
The Microsoft.ApplicationInsights package provides the [core API](https://msdn.microsoft.com/library/mt420197.aspx) of the SDK. The other telemetry modules use this, and you can also [use it to define your own telemetry](app-insights-api-custom-events-metrics.md).

* No entry in ApplicationInsights.config.
* [Microsoft.ApplicationInsights](http://www.nuget.org/packages/Microsoft.ApplicationInsights) NuGet package. If you just install this NuGet, no .config file is generated.

## Telemetry Channel
The telemetry channel manages buffering and transmission of telemetry to the Application Insights service. 

* `Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.ServerTelemetryChannel` is the default channel for services. It buffers data in memory.
* `Microsoft.ApplicationInsights.PersistenceChannel` is an alternative for console applications. It can save any unflushed data to persistent storage when your app closes down, and will send it when the app starts again.

## Telemetry Initializers (ASP.NET)
Telemetry initializers set context properties that are sent along with every item of telemetry. 

You can [write your own initializers](app-insights-api-filtering-sampling.md#add-properties) to set context properties.

The standard initializers are all set either by the Web or WindowsServer NuGet packages:

* `AccountIdTelemetryInitializer` sets the AccountId property.
* `AuthenticatedUserIdTelemetryInitializer` sets the AuthenticatedUserId property as set by the JavaScript SDK.
* `AzureRoleEnvironmentTelemetryInitializer` updates the `RoleName` and `RoleInstance` properties of the `Device` context for all telemetry items with information extracted from the Azure runtime environment.
* `BuildInfoConfigComponentVersionTelemetryInitializer` updates the `Version` property of the `Component` context for all telemetry items with the value extracted from the `BuildInfo.config` file produced by MS Build.
* `ClientIpHeaderTelemetryInitializer` updates `Ip` property of the `Location` context of all telemetry items based on the `X-Forwarded-For` HTTP header of the request.
* `DeviceTelemetryInitializer` updates the following properties of the `Device` context for all telemetry items.
  * `Type` is set to "PC"
  * `Id` is set to the domain name of the computer where the web application is running.
  * `OemName` is set to the value extracted from the `Win32_ComputerSystem.Manufacturer` field using WMI.
  * `Model` is set to the value extracted from the `Win32_ComputerSystem.Model` field using WMI.
  * `NetworkType` is set to the value extracted from the `NetworkInterface`.
  * `Language` is set to the name of the `CurrentCulture`.
* `DomainNameRoleInstanceTelemetryInitializer` updates the `RoleInstance` property of the `Device` context for all
  telemetry items with the domain name of the computer where the web application is running.
* `OperationNameTelemetryInitializer` updates the `Name` property of the `RequestTelemetry` and the `Name` property of the `Operation` context of all telemetry items based on the HTTP method, as well as names of ASP.NET MVC controller and action invoked to process the request.
* `OperationIdTelemetryInitializer` or `OperationCorrelationTelemetryInitializer` updates the `Operation.Id` context property of all telemetry items tracked while handling a request with the automatically generated `RequestTelemetry.Id`.
* `SessionTelemetryInitializer` updates the `Id` property of the `Session` context for all telemetry items with value extracted from the `ai_session` cookie generated by the ApplicationInsights JavaScript instrumentation code running in the user's browser. 
* `SyntheticTelemetryInitializer` or `SyntheticUserAgentTelemetryInitializer` updates the `User`, `Session` and `Operation` contexts properties of all telemetry items tracked when handling a request from a synthetic source, such as an availability test or search engine bot. By default, [Metrics Explorer](app-insights-metrics-explorer.md) does not display synthetic telemetry. 
  
    The `<Filters>` set identifying properties of the requests.
* `UserAgentTelemetryInitializer` updates the `UserAgent` property of the `User` context of all telemetry items based on the `User-Agent` HTTP header of the request.
* `UserTelemetryInitializer` updates the `Id` and `AcquisitionDate` properties of `User` context for all telemetry items with values extracted from the `ai_user` cookie generated by the Application Insights JavaScript instrumentation code running in the user's browser.
* `WebTestTelemetryInitializer` sets the user id, session id and synthetic source properties for HTTP requests that come from [availability tests](app-insights-monitor-web-app-availability.md).
  The `<Filters>` set identifying properties of the requests.

## Telemetry Processors (ASP.NET)
Telemetry processors can filter and modify each telemetry item just before it is sent from the SDK to the portal.

You can [write your own telemetry processors](app-insights-api-filtering-sampling.md#filtering).

#### Adaptive sampling telemetry processor (from 2.0.0-beta3)
This is enabled by default. If your app sends a lot of telemetry, this processor removes some of it.

```xml

    <TelemetryProcessors>
      <Add Type="Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.AdaptiveSamplingTelemetryProcessor, Microsoft.AI.ServerTelemetryChannel">
        <MaxTelemetryItemsPerSecond>5</MaxTelemetryItemsPerSecond>
      </Add>
    </TelemetryProcessors>

```

The parameter provides the target that the algorithm tries to achieve. Each instance of the SDK works independently, so if your server is a cluster of several machines, the actual volume of telemetry will be multiplied accordingly.

[Learn more about sampling](app-insights-sampling.md).

#### Fixed-rate sampling telemetry processor (from 2.0.0-beta1)
There is also a standard [sampling telemetry processor](app-insights-api-filtering-sampling.md#sampling) (from 2.0.1):

```XML

    <TelemetryProcessors>
     <Add Type="Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.SamplingTelemetryProcessor, Microsoft.AI.ServerTelemetryChannel">

     <!-- Set a percentage close to 100/N where N is an integer. -->
     <!-- E.g. 50 (=100/2), 33.33 (=100/3), 25 (=100/4), 20, 1 (=100/100), 0.1 (=100/1000) -->
     <SamplingPercentage>10</SamplingPercentage>
     </Add>
   </TelemetryProcessors>

```



## Channel parameters (Java)
These parameters affect how the Java SDK should store and flush the telemetry data that it collects.

#### MaxTelemetryBufferCapacity
The number of telemetry items that can be stored in the SDK's in-memory storage. When this number is reached, the telemetry buffer is flushed - that is, the telemetry items are sent to the Application Insights server.

* Min: 1
* Max: 1000
* Default: 500

```

  <ApplicationInsights>
      ...
      <Channel>
       <MaxTelemetryBufferCapacity>100</MaxTelemetryBufferCapacity>
      </Channel>
      ...
  </ApplicationInsights>
```

#### FlushIntervalInSeconds
Determines how often the data that is stored in the in-memory storage should be flushed (sent to Application Insights).

* Min: 1
* Max: 300
* Default: 5

```

    <ApplicationInsights>
      ...
      <Channel>
        <FlushIntervalInSeconds>100</FlushIntervalInSeconds>
      </Channel>
      ...
    </ApplicationInsights>
```

#### MaxTransmissionStorageCapacityInMB
Determines the maximum size in MB that is allotted to the persistent storage on the local disk. This storage is used for persisting telemetry items that failed to be transmitted to the Application Insights endpoint. When the storage size has been met, new telemetry items will be discarded.

* Min: 1
* Max: 100
* Default: 10

```

   <ApplicationInsights>
      ...
      <Channel>
        <MaxTransmissionStorageCapacityInMB>50</MaxTransmissionStorageCapacityInMB>
      </Channel>
      ...
   </ApplicationInsights>
```



## InstrumentationKey
This determines the Application Insights resource in which your data appears. Typically you create a separate resource, with a separate key, for each of your applications.

If you want to set the key dynamically - for example if you want to send results from your application to different resources - you can omit the key from the configuration file, and set it in code instead.

To set the key for all instances of TelemetryClient, including standard telemetry modules, set the key in TelemetryConfiguration.Active. Do this in an initialization method, such as global.aspx.cs in an ASP.NET service:

```C#

    protected void Application_Start()
    {
      Microsoft.ApplicationInsights.Extensibility.
        TelemetryConfiguration.Active.InstrumentationKey = 
          // - for example -
          WebConfigurationManager.Settings["ikey"];
      //...
```

If you just want to send a specific set of events to a different resource, you can set the key for a specific TelemetryClient:

```C#

    var tc = new TelemetryClient();
    tc.Context.InstrumentationKey = "----- my key ----";
    tc.TrackEvent("myEvent");
    // ...

```

[Learn more about the API](app-insights-api-custom-events-metrics.md).

To get a new key, [create a new resource in the Application Insights portal](app-insights-create-new-resource.md).

<!--Link references-->

[api]: app-insights-api-custom-events-metrics.md
[azure]: ../insights-perf-analytics.md
[client]: app-insights-javascript.md
[diagnostic]: app-insights-diagnostic-search.md
[exceptions]: app-insights-asp-net-exceptions.md
[netlogs]: app-insights-asp-net-trace-logs.md
[new]: app-insights-create-new-resource.md
[redfield]: app-insights-monitor-performance-live-website-now.md
[start]: app-insights-overview.md

