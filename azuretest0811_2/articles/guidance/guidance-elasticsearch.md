
---
title: Elasticsearch on Azure Guidance | Microsoft Azure
description: Elasticsearch on Azure Guidance.
services: ''
documentationcenter: na
author: dragon119
manager: bennage
editor: ''
tags: ''

ms.service: guidance
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: na
ms.workload: na
ms.date: 02/18/2016
ms.author: masashin

---
# Elasticsearch on Azure Guidance
[!INCLUDE [pnp-header](../../includes/guidance-pnp-header-include.md)]

Elasticsearch is a highly scalable open-source search engine and database. It is suitable for situations that require fast analysis and discovery of information held in big datasets. This guidance looks at some key aspects to consider when designing an Elasticsearch cluster: 

* **[Running Elasticsearch on Azure](guidance-elasticsearch-running-on-azure.md)** provides a brief introduction to the general structure of Elasticsearch, and  describes how to implement an Elasticsearch cluster using Azure.
* **[Tuning Data Ingestion Performance for Elasticsearch on Azure](guidance-elasticsearch-tuning-data-ingestion-performance.md)** describes the deployment and configuration options to consider for an Elasticsearch cluster that expects a high rate of data ingestion.
* **[Tuning Data Aggregation and Query Performance for Elasticsearch on Azure](guidance-elasticsearch-tuning-data-aggregation-and-query-performance.md)** summarizes options that you can consider when determining the best way to optimize your system for query and search performance.
* **[Configuring Resilience and Recovery on Elasticsearch on Azure](guidance-elasticsearch-configuring-resilience-and-recovery.md)** summarizes the resiliency and recovery options available with Elasticsearch when hosted in Azure.
* **[Creating a Performance Testing Environment for Elasticsearch on Azure](guidance-elasticsearch-creating-performance-testing-environment.md)** describes how to set up an environment for testing the performance of an Elasticsearch cluster.
* **[Implementing a JMeter Test Plan for Elasticsearch](guidance-elasticsearch-implementing-jmeter-test-plan.md)** describes how to create and use a JUnit sampler that can generate and upload data to an Elasticsearch cluster.
* **[Deploying a JMeter JUnit Sampler for Testing Elasticsearch Performance](guidance-elasticsearch-deploying-jmeter-junit-sampler.md)** summarizes the key experiences gained from constructing and running data ingestion and query test plans. 
* **[Running the Automated Elasticsearch Resiliency Tests](guidance-elasticsearch-running-automated-resilience-tests.md)** summarizes running the resiliency tests used in the article above.
* **[Running the Automated Elasticsearch Performance Tests](guidance-elasticsearch-running-automated-performance-tests.md)** summarizes running the performance tests used in the article above.

> [!NOTE]
> This guidance assumes some basic familiarity with Elasticsearch. For more 
> detailed information, visit the [Elasticsearch website](https://www.elastic.co/products/elasticsearch).
> 
> 

[Running Elasticsearch on Azure]: guidance-elasticsearch-running-on-azure.md
[Tuning Data Ingestion Performance for Elasticsearch on Azure]: guidance-elasticsearch-tuning-data-ingestion-performance.md
[Creating a Performance Testing Environment for Elasticsearch on Azure]: guidance-elasticsearch-creating-performance-testing-environment.md
[Implementing a JMeter Test Plan for Elasticsearch]: guidance-elasticsearch-implementing-jmeter-test-plan.md
[Deploying a JMeter JUnit Sampler for Testing Elasticsearch Performance]: guidance-elasticsearch-deploying-jmeter-junit-sampler.md
[Tuning Data Aggregation and Query Performance for Elasticsearch on Azure]: guidance-elasticsearch-tuning-data-aggregation-and-query-performance.md
[Configuring Resilience and Recovery on Elasticsearch on Azure]: guidance-elasticsearch-configuring-resilience-and-recovery.md
[Running the Automated Elasticsearch Resiliency Tests]: guidance-elasticsearch-running-automated-resilience-tests.md
[Running the Automated Elasticsearch Performance Tests]: guidance-elasticsearch-running-automated-performance-tests.md
