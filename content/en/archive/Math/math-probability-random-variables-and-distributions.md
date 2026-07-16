---
title: Math - Probability, Random Variables and Distributions (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 6mchh1x7mrv
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-12 00:00:00
---

## Random Variable

* Let the sample space of random experiment be S, X = X(e) is a real-valued single-valued function defined on sample space S. X = X(e) is called a random variable.
* Essentially a function about basic events, independent variable is basic event, dependent variable is function value.

### Random Experiment:

Satisfies: 

* (1) Repeatability: Experiment can be repeated under same conditions;
  
* (2) Knowability: Each experiment has more than one possible result, and all possible results of experiment can be clearly identified in advance;
  
* (3) Uncertainty: Before conducting an experiment, cannot determine which result will appear, but one of the results must appear.

### Sample Space:
The set of all basic results of a random experiment is called the sample space. Elements of sample space are called sample points or basic events. That is, sample space is essentially a set, each element is a result of one random experiment.


### Sample and Random Variable:
Samples in mathematical statistics have duality, that is, samples can be viewed both as a set of observed values and as random variables.

* First, before sampling. Cannot determine sample's observed values, so can be viewed as random variables.
  
* Second, after sample is extracted and observed, sample has specific observed values, so can be viewed as a set of determined values.


## Probability Distribution

Let's look at the simplest coin toss event. Theoretically, probability of heads and tails are both 50%

![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/37ad586a7450df254377069cf6cb942221abec1888d7f4479f847d9052399caf.png)  

### Try with Code

```js

function flipCoin(){
    for (let index = 0; index < 10; index++) {
        // Round random number
        let randomNum = Math.round(Math.random())
        // If random is 1 then heads
        if(randomNum === 1){
            console.log('Heads')
        }else{
            console.log('Tails')
        }
    }

}

flipCoin()

```

Try 10 times result:

![Figure 3](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/ae33d052a617115dd55e6ba4b518174d2e32882ca4d0011ef8c14d882906ca4a.png)  


Try 1000 times

![Figure 4](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/ded88ad6ca997dbfbf9424b9b83159d1d16b329611da5902fc2734b219c16362.png)  


* More sampling times in statistics, closer to theoretical situation

* Probability distribution actually describes probability law of random variables.

## Discrete Distribution Models

### Bernoulli Distribution
This is distribution of a single random variable, and this variable only has two values, 0 or 1.

![Figure 5](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/857fa1c74e576b0da786c1426090e02a008172a9f3cd01d867c7a7f3580ff1b2.png)  

or

![Figure 6](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/f5945b9cf937d09adbb61ff6eb44493efc82170ec4ac1d82210d972555a63f81.png)  

```
Example:

Assume you want to have children, probability of boy is p, probability of girl is 1-p

Bernoulli experiment: Have one child

Bernoulli distribution: Have one child, probability of boy is p, probability of girl is 1-p, this is Bernoulli distribution
```

![Figure 7](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4dd3a2264061010d7c4a332050cccb1549fe594a97676c3f9d2305c1e44a97ad.png)  


## Categorical Distribution (also called Multinoulli Distribution)

It describes a single random variable with k different states. Here k is a finite value, if k is 2, then categorical distribution becomes Bernoulli distribution. I've listed the formula and diagram of this distribution.

![Figure 8](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/fb55f261b37f0963c7c89e2ed67e11132897839b9335bda7c0a150c531929a84.png)  



## Normal Distribution

Formula:
![Figure 9](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/6dc708e463f8c158c107510d1b735dd2b2bb94bfa3f670474a090ad9b38b6e00.png)  


In this formula there are two parameters, μ represents mean, σ represents variance.

![Figure 10](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/f717b791257809f884e53ec6bba6edd51b48f2bec8509cba5ea9fe5b25a81759.png)  

