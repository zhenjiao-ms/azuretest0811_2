---
title: Convert a Machine Learning training experiment to a predictive experiment | Microsoft Azure
description: How to convert a Machine Learning training experiment, used for training your predictive analytics model, to a predictive experiment which can be deployed as a web service.
services: machine-learning
documentationcenter: ''
author: garyericson
manager: paulettm
editor: cgronlun

ms.service: machine-learning
ms.workload: data-services
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/02/2016
ms.author: garye

---
# Convert a Machine Learning training experiment to a predictive experiment
Azure Machine Learning enables you to build, test, and deploy predictive analytics solutions.

Once you've created and iterated on a *training experiment* to train your predictive analytics model, and you're ready to use it to score new data, you need to prepare and streamline your experiment for scoring. You can then deploy this *predictive experiment* as an Azure web service so that users can send data to your model and receive your model's predictions.

By converting to a predictive experiment, you're getting your trained model ready to be deployed as a web service. Users of the web service will send input data to your model and your model will send back the prediction results. So as you convert to a predictive experiment you will want to keep in mind how you expect your model to be used by others.

[!INCLUDE [machine-learning-free-trial](../../includes/machine-learning-free-trial.md)]

The process of converting a training experiment to a predictive experiment involves three steps:

1. Save the machine learning model that you've trained, and then replace the machine learning algorithm and [Train Model](https://msdn.microsoft.com/library/azure/5cc7053e-aa30-450d-96c0-dae4be720977/) modules with your saved trained model.
2. Trim the experiment to only those modules that are needed for scoring. A training experiment includes a number of modules that are necessary for training but are not needed once the model is trained and ready to use for scoring.
3. Define where in your experiment you will accept data from the web service user, and what data will be returned.

## Set Up Web Service button
After you have run your experiment (**RUN** button at the bottom of the experiment canvas), the **Set Up Web Service** button (select the **Predictive Web Service** option) will perform for you the three steps of converting your training experiment to a predictive experiment:

1. It saves your trained model as a module in the **Trained Models** section of the module palette (to the left of the experiment canvas), then replaces the machine learning algorithm and [Train Model](https://msdn.microsoft.com/library/azure/5cc7053e-aa30-450d-96c0-dae4be720977/) modules with the saved trained model.
2. It removes modules that are clearly not needed. In our example, this includes the [Split](https://msdn.microsoft.com/library/azure/70530644-c97a-4ab6-85f7-88bf30a8be5f/), 2nd [Score Model](https://msdn.microsoft.com/library/azure/401b4f92-e724-4d5a-be81-d5b0ff9bdb33/), and [Evaluate Model](https://msdn.microsoft.com/library/azure/927d65ac-3b50-4694-9903-20f6c1672089/) modules.
3. It creates Web service input and output modules and adds them in default locations in your experiment.

For example, the following experiment trains a two-class boosted decision tree model using sample census data:

![Training experiment](./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure1.png)

The modules in this experiment perform basically four different functions:

![Module functions](./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure2.png)

When you convert this training experiment to a predictive experiment, some of these modules are no longer needed or they have a different purpose:

* **Data** - The data in this sample dataset is not used during scoring - the user of the web service will supply the data to be scored. However, the metadata from this dataset, such as data types, is used by the trained model. So you need to keep the dataset in the predictive experiment so that it can provide this metadata.
* **Prep** - Depending on the data that will be submitted for scoring, these modules may or may not be necessary to process the incoming data.
  
    For instance, in this example the sample dataset may have missing values and it includes columns that are not needed to train the model. So a [Clean Missing Data](https://msdn.microsoft.com/library/azure/d2c5ca2f-7323-41a3-9b7e-da917c99f0c4/) module was included to deal with missing values, and a [Select Columns in Dataset](https://msdn.microsoft.com/library/azure/1ec722fa-b623-4e26-a44e-a50c6d726223/) module was included to exclude those extra columns from the data flow. If you know that the data that will be submitted for scoring through the web service will not have missing values, then you can remove the [Clean Missing Data](https://msdn.microsoft.com/library/azure/d2c5ca2f-7323-41a3-9b7e-da917c99f0c4/) module. However, since the [Select Columns in Dataset](https://msdn.microsoft.com/library/azure/1ec722fa-b623-4e26-a44e-a50c6d726223/) module helps define the set of features being scored, that module needs to remain.
* **Train** - Once the model has been successfully trained, you save it as a single trained model module. You then replace these individual modules with the saved trained model.
* **Score** - In this example, the Split module is used to divide the data stream into a set of test data and training data. In the predictive experiment this is not needed and can be removed. Similarly, the 2nd [Score Model](https://msdn.microsoft.com/library/azure/401b4f92-e724-4d5a-be81-d5b0ff9bdb33/) module and the [Evaluate Model](https://msdn.microsoft.com/library/azure/927d65ac-3b50-4694-9903-20f6c1672089/) module are used to compare results from the test data, so these modules are also not needed in the predictive experiment. The remaining [Score Model](https://msdn.microsoft.com/library/azure/401b4f92-e724-4d5a-be81-d5b0ff9bdb33/) module, however, is needed to return a score result through the web service.

Here is how our example looks after clicking **Set Up Web Service**:

![Converted predictive experiment](./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure3.png)

This may be sufficient to prepare your experiment to be deployed as a web service. However, you may want to do some additional work specific to your experiment.

### Adjust input and output modules
In your training experiment, you used a set of training data and then did some processing to get the data in a form that the machine learning algorithm needed. If the data you expect to receive through the web service will not need this processing, you can move the **Web service input module** to a different node in your experiment.

For example, by default **Set Up Web Service** puts the **Web service input** module at the top of your data flow, as in the figure above. However, if the input data will not need this processing, then you can manually position the **Web service input** past the data processing modules:

![Moving the web service input](./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure4.png)

The input data provided through the web service will now pass directly into the Score Model module without any preprocessing.

Similarly, by default **Set Up Web Service** puts the Web service output module at the bottom of your data flow. In this example, the web service will return to the user the output of the [Score Model](https://msdn.microsoft.com/library/azure/401b4f92-e724-4d5a-be81-d5b0ff9bdb33/) module which includes the complete input data vector plus the scoring results.

However, if you would prefer to return something different - for example, only the scoring results and not the entire vector of input data - then you can insert a [Select Columns in Dataset](https://msdn.microsoft.com/library/azure/1ec722fa-b623-4e26-a44e-a50c6d726223/) module to exclude all columns except the scoring results. You then move the **Web service output** module to the output of the [Select Columns in Dataset](https://msdn.microsoft.com/library/azure/1ec722fa-b623-4e26-a44e-a50c6d726223/) module:

![Moving the web service output](./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure5.png)

### Add or remove additional data processing modules
If there are more modules in your experiment that you know will not be needed during scoring, these can be removed. For example, because we have moved the **Web service input** module to a point after the data processing modules, we can remove the [Clean Missing Data](https://msdn.microsoft.com/library/azure/d2c5ca2f-7323-41a3-9b7e-da917c99f0c4/) module from the predictive experiment.

Our predictive experiment now looks like this:

![Removing additional module](./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure6.png)

### Add optional Web Service Parameters
In some cases, you may want to allow the user of your web service to change the behavior of modules when the service is accessed. *Web Service Parameters* allow you to do this.

A common example is setting up the [Import Data](https://msdn.microsoft.com/library/azure/4e1b0fe6-aded-4b3f-a36f-39b8862b9004/) module so that the user of the deployed web service can specify a different data source when the web service is accessed. Or configuring the [Export Data](https://msdn.microsoft.com/library/azure/7a391181-b6a7-4ad4-b82d-e419c0d6522c/) module so that a different destination can be specified.

You can define Web Service Parameters and associate them with one or more module parameters, and you can specify whether they are required or optional. The user of the web service can then provide values for these parameters when the service is accessed and the module actions will be modified accordingly.

For more information about Web Service Parameters, see [Using Azure Machine Learning Web Service Parameters
](machine-learning-web-service-parameters.md).

[webserviceparameters]: machine-learning-web-service-parameters.md


## Deploy the predictive experiment as a web service
Now that the predictive experiment has been sufficiently prepared, you can deploy it as an Azure web service. Using the web service, users can send data to your model and the model will return its predictions.

For more information on the complete deployment process, see [Deploy an Azure Machine Learning web service](machine-learning-publish-a-machine-learning-web-service.md)

[deploy]: machine-learning-publish-a-machine-learning-web-service.md


<!-- Images -->
[figure1]:./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure1.png
[figure2]:./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure2.png
[figure3]:./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure3.png
[figure4]:./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure4.png
[figure5]:./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure5.png
[figure6]:./media/machine-learning-convert-training-experiment-to-scoring-experiment/figure6.png


<!-- Module References -->
[clean-missing-data]: https://msdn.microsoft.com/library/azure/d2c5ca2f-7323-41a3-9b7e-da917c99f0c4/
[evaluate-model]: https://msdn.microsoft.com/library/azure/927d65ac-3b50-4694-9903-20f6c1672089/
[select-columns]: https://msdn.microsoft.com/library/azure/1ec722fa-b623-4e26-a44e-a50c6d726223/
[import-data]: https://msdn.microsoft.com/library/azure/4e1b0fe6-aded-4b3f-a36f-39b8862b9004/
[score-model]: https://msdn.microsoft.com/library/azure/401b4f92-e724-4d5a-be81-d5b0ff9bdb33/
[split]: https://msdn.microsoft.com/library/azure/70530644-c97a-4ab6-85f7-88bf30a8be5f/
[train-model]: https://msdn.microsoft.com/library/azure/5cc7053e-aa30-450d-96c0-dae4be720977/
[export-data]: https://msdn.microsoft.com/library/azure/7a391181-b6a7-4ad4-b82d-e419c0d6522c/
