---
title: Math - Naive Bayes Classification Algorithm (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 6iwpimvelxh
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-14 00:00:00
---

## Naive Bayes

> "After updating our initial beliefs about something with objective new information, we get a new, improved belief."
>  ---- Mathematician Thomas Bayes (Thomas Bayes, 1702～1761)

When you cannot accurately know the essence of something, you can rely on how many events related to that specific essence appear to judge the probability of its essential attributes.

The more events supporting a certain attribute occur, the greater the possibility that attribute holds.


In 1774, French mathematician Pierre-Simon Laplace (Pierre-Simon Laplace, 1749-1827) independently rediscovered Bayes' formula.


![Figure 16](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/3d6c983eec1f9283cb79904d2cc4cc1c7ee9654d73874ce1daf498b94fd23358.png)  

Alternative writing:

![Figure 17](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/a1ace7950302e8e260f8397ea6c765ad2affa502ebc48d64f8b437e03eaf57ac.png)  




## Let Computer Distinguish Fruits

We need to convert fruit characteristics into data that computers can understand. The most common method is to extract attributes of objects in the real world and convert these into numbers.

For example: shape, skin color, zebra texture, weight, grip feel, taste.


![Figure 19](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/a99743fd96d79a2d6d343ef81f988c32f9ea4b28a8ad5c2391c2658ba60c188b.png)  


Convert these descriptions into numbers, convert weight from continuous value to discrete value, this is because Naive Bayes processes discrete values

![Figure 20](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/c6c05b372ef0736d10734971409f755698ca90913095af1e752a7ecee88f9e7a.png)  

Expand sample, only 3 fruits is not enough to constitute training samples needed for Naive Bayes classification


![Figure 21](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d485cea0f343ac13f4056b4ec0042563ae0866e275ab17b45ad7aecedc4f41f9.png)  


### How Do We Use Bayes' Formula

> Use prior probability and conditional probability to estimate posterior probability.
> 
![Figure 22](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/a725fc90f77e944d101977ea08e273e05f77c4160eb3ecf861a952a8719b8ac1.png)  



Assume different attributes of data object are independent when affecting its classification. At this time, if attributes fi and fj appear simultaneously in data object o, then probability object o belongs to category c is like this

> Naive Bayes algorithm assumes features are independent of each other, only then can both sides be equal, this is also the source of "naive" in Naive Bayes classification

![Figure 23](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/890407d644aa61250ee7e983ec0fd8e161679f7ff7e29a02bab486922a42e607.png)  

Use 10 fruits' data to build Naive Bayes model

![Figure 24](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/6ec393ee25603bb065911573df41cc0ce291e26087cb78c1a2f80b64e3739eb1.png)  

#### Smoothing
Zero probability situations will occur, so we usually take a very small value smaller than minimum statistical probability in this dataset to replace "zero probability". For example, we take 0.01 here. When filling attribute values that never appeared in training data, we use this technique, we call this technique Smoothing.



### Example:

Assume we have a new fruit, its shape is round, taste is sweet, then according to Naive Bayes, what are probabilities it belongs to apple, sweet orange and watermelon respectively?

![Figure 25](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/e7bb1d2b6d6271b843f6fe43a407494899f04695c881ed0971f8ad09b862abdb.png)  


apple represents classification as apple, shape-2 represents shape attribute value is 2 (i.e., round), taste-2 represents taste attribute value is 2. Similarly, we can also calculate probability this fruit belongs to sweet orange and watermelon.


![Figure 26](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/566411191bd8528f098fcae1cb13f0ff42a4b689de1e6f364b8dfbd38ebeb8f3.png)  


Comparing these three values, 0.00198<0.00798<0.26934, so computer can conclude, this fruit most likely belongs to sweet orange


### Naive Bayes Classification Mainly Includes These Steps

* `Prepare data`: For fruit classification case, we collected several fruit instances, and starting from common fruit attributes, converted them into data computers can understand. This data is also called training samples.
  
* `Build model`: Through fruit instances at hand, we let computer count prior probability of each fruit and attribute occurrence, and conditional probability of certain attribute occurrence under certain fruit classification. This process is also called sample-based training.
  
* `Classify new data`: For a new fruit's attribute data, computer derives and calculates according to already built model, gets probability this fruit belongs to each classification, achieving classification purpose. This process is also called prediction.


### Advantages and Disadvantages of Naive Bayes Classification

* Advantages:

 1. Simple algorithm logic, easy to implement

 2. Small time and space overhead during classification

* Disadvantages:

Theoretically, Naive Bayes model has smallest error rate compared to other classification methods. But actually this is not always the case, this is because Naive Bayes model assumes attributes are independent of each other, this assumption is often not true in practical applications. When number of attributes is large or correlation between attributes is large, classification effect is poor.

