---
title: Controlling Azure CDN caching behavior of requests with query strings | Microsoft Azure
description: Azure CDN query string caching controls how files are to be cached when they contain query strings.
services: cdn
documentationcenter: ''
author: camsoper
manager: erikre
editor: ''

ms.service: cdn
ms.workload: tbd
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 07/28/2016
ms.author: casoper

---
# Controlling caching behavior of CDN requests with query strings
> [!div class="op_single_selector"]
> * [Standard](cdn-query-string.md)
> * [Azure CDN Premium from Verizon](cdn-query-string-premium.md)
> 
> 

## Overview
Query string caching controls how files are to be cached when they contain query strings.

> [!IMPORTANT]
> The Standard and Premium CDN products provide the same query string caching functionality, but the user interface differs.  This document describes the interface for **Azure CDN Standard from Akamai** and **Azure CDN Standard from Verizon**.  For query string caching with **Azure CDN Premium from Verizon**, see [Controlling caching behavior of CDN requests with query strings - Premium](cdn-query-string-premium.md).
> 
> 

Three modes are available:

* **Ignore query strings**:  This is the default mode.  The CDN edge node will pass the query string from the requestor to the origin on the first request and cache the asset.  All subsequent requests for that asset that are served from the edge node will ignore the query string until the cached asset expires.
* **Bypass caching for URL with query strings**:  In this mode, requests with query strings are not cached at the CDN edge node.  The edge node retrieves the asset directly from the origin and passes it to the requestor with each request.
* **Cache every unique URL**:  This mode treats each request with a query string as a unique asset with its own cache.  For example, the response from the origin for a request for *foo.ashx?q=bar* would be cached at the edge node and returned for subsequent caches with that same query string.  A request for *foo.ashx?q=somethingelse* would be cached as a separate asset with its own time to live.

## Changing query string caching settings for standard CDN profiles
1. From the CDN profile blade, click the CDN endpoint you wish to manage.
   
    ![CDN profile blade endpoints](./media/cdn-query-string/cdn-endpoints.png)
   
    The CDN endpoint blade opens.
2. Click the **Configure** button.
   
    ![CDN profile blade manage button](./media/cdn-query-string/cdn-config-btn.png)
   
    The CDN Configuration blade opens.
3. Select a setting from the **Query string caching behavior** dropdown.
   
    ![CDN query string caching options](./media/cdn-query-string/cdn-query-string.png)
4. After making your selection, click the **Save** button.

> [!IMPORTANT]
> The settings changes may not be immediately visible, as it takes time for the registration to propagate through the CDN.  For <b>Azure CDN from Akamai</b> profiles, propagation will usually complete within one minute.  For <b>Azure CDN from Verizon</b> profiles, propagation will usually complete within 90 minutes, but in some cases can take longer.
> 
> 

