# AWS Machine Learning Specialty Study

This repo is an study guide for [AWS Machine Learning Specialty - MLS-C01](https://aws.amazon.com/pt/certification/certified-machine-learning-specialty/)

## Concepts

### Classification

- [Algorithms](https://ml-cheatsheet.readthedocs.io/en/latest/classification_algos.html)

* [Confusion matrix](https://towardsdatascience.com/understanding-confusion-matrix-a9ad42dcfd62)

* [Accuracy, precision, recall and F1 test](https://towardsdatascience.com/accuracy-recall-precision-f-score-specificity-which-to-optimize-on-867d3f11124)

- [Precision x Recall Tradeoff](https://datascience-george.medium.com/the-precision-recall-trade-off-aa295faba140)

- [ROC Curve and AUC](https://developers.google.com/machine-learning/crash-course/classification/roc-and-auc)

* [Gini impurity](https://bambielli.com/til/2017-10-29-gini-impurity/#:~:text=Gini%20Impurity%20is%20a%20measurement,labels%20from%20the%20data%20set.)

## Python Environment

To study algorithms and frameworks we need a local Sagemaker environment. This steps emulates this.

Install [Anaconda](https://docs.anaconda.com/anaconda/install/)

Create new Virtual Environment:

```sh
conda create -n aws-ml-specialty python=3.6.3
conda activate aws-ml-specialty
pip install -r requirements.txt
```

Start the jupyter notebooks server:

```sh
jupyter notebook labs
```

All labs are in [labs directory](https://github.com/tentativafc/aws-machine-learning-specialty/tree/main/labs).

## Support materials

- [AWS Machine Learning producs](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/machine-learning.html)

* [AWS Glue](https://docs.aws.amazon.com/glue/latest/dg/what-is-glue.html)

  - [Samples](https://github.com/aws-samples/aws-glue-samples)

* [EMR](https://docs.aws.amazon.com/emr/index.html)

  - [Samples](https://github.com/aws-samples/analysing-realtime-streaming-data-using-msk-emr)

* [Kinesis](https://docs.aws.amazon.com/kinesis/index.html)

  - [Streaming Data Solutions on AWS with Amazon Kinesis](https://docs.aws.amazon.com/whitepapers/latest/streaming-data-solutions-amazon-kinesis/welcome.html?did=wp_card&trk=wp_card)

* [Linux Academy github](https://github.com/linuxacademy/content-aws-mls-c01)
