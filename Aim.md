# Aim

This document is to elaborate what we shoud do in the project.

## Signals to be identified

Our algorithm is expected to identify the following modulation format as much as possible.

| Bit Per Symbol |   1   |   2   |   3   |   4   |   5   |  ...  |
| :------------: | :---: | :---: | :---: | :---: | :---: | :---: |
|      QAM       |  --   | QPSK  | 8QAM  | 16QAM | 32QAM |  ...  |
|      PSK       | 2PSK  | 4PSK  | 8PSK  | 16PSK | 32PSK |  ...  |

## Characterization of Signals

We need use some parameters to preprocess the origin signals to adapt the machine learning algorithms. Those parameters should are able to describe some typical characters of the signal. The common-used parameters are shown in the following:

+ **constellation diagram**
+ **high order moment**
+ other parameters defined by ourselves (e.g. angle distribution, amplitude distribution ...)

Classification by high order moment is an easy method and also can obtain a high accuracy.

## Machine Learning Algorithms

For modulation format identification (MFI), the following machine learning algorithms are recommended:

+ **Support Vector Machine (SVM)**
+ **Convulutional Neural Networks (CNN)**

SVM is a easy way to classify different modulation format

## Our Plan

Using **high order moment** and **SVM** to identify different digital modulation format is recommended, because it is easy to realize and there are a lot of blogs, articles and open-source projects to be referred. 

## Notice

+ The [signal generating function](https://github.com/Eric-Ma-7/Modulation-Format-Classification/blob/master/src/signal_generation.m) has been written and it can generate PSK and QAM signal with any number of bit per symbol.
+ The [dataset generating script](https://github.com/Eric-Ma-7/Modulation-Format-Classification/blob/master/src/dataset_generate.m) gives an exmaple to generate a dataset. You can modify this script to generate the dataset you want, but DO NOT submit it onto git unless it is necessary.

## Reference
+ [A blog about the realization of digital MFI under AWGN channel](https://www.cnblogs.com/wsine/p/4673364.html)
+ [An article about digital MFI](https://github.com/Eric-Ma-7/Modulation-Format-Classification/blob/master/doc/MFI_based_on_high_order_moment.pdf)

