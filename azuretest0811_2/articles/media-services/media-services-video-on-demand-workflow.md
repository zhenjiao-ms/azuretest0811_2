---
title: Delivering Media on-Demand with Azure Media Services
description: This topic talks about common scenarios of delivering media on-demand with Azure Media Services.
services: media-services
documentationcenter: ''
author: Juliako
manager: erikre
editor: ''

ms.service: media-services
ms.workload: media
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 06/22/2016
ms.author: juliako

---
# Delivering Media on-Demand with Azure Media Services
## Overview
This topic describes steps of a typical Azure Media Services (AMS) Video-on-Demand workflow. Each step links to relevant topics. For tasks that can be achieved using different technologies, there are buttons that link to technology of your choice (for example, .NET or REST).   

Note that you can integrate Media Services with your existing tools and processes. For example, encode content on-site, then upload to Media Services for transcoding into multiple formats and deliver through Azure CDN or a third-party CDN. 

The following diagram shows the major parts of the Media Services platform that are involved in the Video on Demand Workflow.
![VoD workflow](./media/media-services-video-on-demand-workflow/media-services-video-on-demand.png)

## <a id="vod_scenarios"></a>Common Scenarios: Delivering Media on-Demand
### Protect content in storage and deliver streaming media in the clear (non-encrypted)
1. Upload a high-quality mezzanine file into an asset.
   
    It is recommended to apply storage encryption option to your asset in order to protect your content during upload and while at rest in storage. 
2. Encode to adaptive bitrate MP4 set. 
   
    It is recommended to apply storage encryption option to the output asset in order to protect your content at rest.
3. Configure asset delivery policy (used by dynamic packaging). 
   
    If your asset is storage encrypted, you **must** configure asset delivery policy. 
4. Publish the asset by creating an OnDemand locator.
   
    Make sure to have at least one streaming reserved unit on the streaming endpoint from which you want to stream content.
5. Stream published content.

### Protect content in storage, deliver dynamically encrypted streaming media
To be able to use dynamic encryption, you must first get at least one streaming reserved unit on the streaming endpoint from which you want to stream encrypted content.

1. Upload a high-quality mezzanine file into an asset. Apply storage encryption option to the asset.
2. Encode to adaptive bitrate MP4 set. Apply storage encryption option to the output asset.
3. Create encryption content key for the asset you want to be dynamically encrypted during playback.
4. Configure content key authorization policy.
5. Configure asset delivery policy (used by dynamic packaging and dynamic encryption).
6. Publish the asset by creating an OnDemand locator.
7. Stream published content. 

### Index content
1. Upload a high-quality mezzanine file into an Asset.
2. Index content.
   
    The indexing job generates files that can be used as Closed Captions (CC) in video playback. It also generates files that enable you to do in-video search and jump to the exact location of the video.    
3. Consume indexed content.

### Deliver progressive download
1. Upload a high-quality mezzanine file into an asset.
2. Encode to adaptive bitrate MP4 set or a single MP4.
3. Publish the asset by creating an OnDemand or SAS locator.
   
    If using OnDemand locator, make sure to have at least one streaming reserved unit on the streaming endpoint from which you plan to progressively download content.
   
    If using SAS locator, the content is downloaded from the Azure blob storage. In this case, you do not need to have streaming reserved units.
4. Progressively download content.

This article contains links to topics that show how to set up your development environment and perform tasks mentioned above.

## Concepts
For concepts related to delivering your content on demand, see [Media Services Concepts](media-services-concepts.md).

## Media Services learning paths
[!INCLUDE [media-services-learning-paths-include](../../includes/media-services-learning-paths-include.md)]

## Provide feedback
[!INCLUDE [media-services-user-voice-include](../../includes/media-services-user-voice-include.md)]

[vod-overview]: ./media/media-services-video-on-demand-workflow/media-services-video-on-demand.png

