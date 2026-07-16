---
title: Math - Probability, Joint Probability, Conditional Probability, Marginal Probability and Bayes' Theorem (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: haz1cu03hf
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-13 00:00:00
---

> Formula symbol explanation: `P(A|B) is conditional probability of A given B`


## Joint Probability

Various explanations and descriptions for understanding:

* Joint probability refers to probability containing multiple conditions where all conditions hold simultaneously, denoted as P(X=a,Y=b) or P(a,b), some books also habitually denote as P(ab), but I'm not used to this notation, so below uses comma-separated notation. Must note that all conditions hold simultaneously!

* Probability of intersection of two or more events

![Figure 12](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/134caf5fa4c114e6825b4e32eb93a1187310e208764246a05043523aad78cbec.png)  


> Example: Probability of drawing a red 4 from a deck of cards is P(red 4) = 2/52 = 1/26. (A deck has 52 cards, want to draw heart 4 and diamond 4).

## Conditional Probability

* Conditional probability is probability of one (or some) event(s) occurring given that another (or some) event(s) has already occurred. Conditional probability of event A occurring given event B has occurred is written as P(A|B).

* Conditional probability represents probability of X=a given condition Y=b holds, denoted as P(X=a|Y=b) or P(a|b),

> Example: Given we drew a red card, probability this card is 4 is P(4|red) = 2/26 = 1/13 (A deck has 52 cards, 26 red, 26 black. Now because we already drew a red card, we know our selection range is 26 cards, so first divisor is 26).

## Difference Between Joint Probability and Conditional Probability

### Explanation 1: 
P(AB) Joint probability: Pool hasn't changed.

P(A|B) Conditional probability: Pool has shrunk!!!!!!!

So if using conditional probability to calculate joint probability: Pool cannot shrink, multiply it back!!!!

P(A|B) x P(B) = P(AB)


### Explanation 2: 

When we want to know probability of drawing a red 4 card (joint probability of red and 4), I want you to imagine placing all 52 cards face down, then randomly selecting one. Among these 52 cards, 2 are red and also number 4 (heart 4 and diamond 4). So joint probability is 2/52 = 1/26.

When we want to know probability of drawing number 4 given we drew a red card, i.e., conditional probability P(4|red), I want you to imagine 52 cards again. However, before randomly drawing a card, you sorted all cards and selected all 26 red cards. Now you place these 26 cards face down, then randomly select one card. Similarly, among these red cards there are two with number 4, so conditional probability is 2/26 = 1/13

### Formula Description
![Figure 13](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d6562409852e71d9261a5a2f423d9f03249fb7869fe6dc51d64bba002de1e9ba.png)  



## Marginal Probability

Explanation:

* For discrete random variables, we can get P(x) by summing joint probability P(x, y) over y. For continuous random variables, we can derive probability P(x) by integrating (infinite sum) joint probability P(x, y) over y. At this time, we call P(x) marginal probability.

* Marginal probability corresponds to joint probability, P(X=a) or P(Y=b), probabilities related only to a single random variable are called marginal probabilities



## Bayes' Theorem

British mathematician Thomas Bayes (Thomas Bayes) first proposed this theorem in a paper published in 1763. This paper was published by a friend after his death. In this paper, he proposed Bayes' theorem to solve an "inverse probability" problem.

Before Bayes wrote this article, people could already calculate "forward probability", for example, Durex held a lottery, lottery bucket has 10 balls, 2 white, 8 black, drawing white ball means you win. You reach in and randomly draw 1 ball, what's probability of drawing winning ball. According to frequency probability calculation formula, you can easily know winning probability is 2/10.

### What is Bayes' Theorem Used For?

With limited information, can help us predict probability.

Bayes' theorem can be seen everywhere probability prediction is needed, especially, Bayes is one of core methods of machine learning. For example, spam filtering, Chinese word segmentation, AIDS testing, liver cancer testing, etc.

### Bayes' Theorem Formula

![Figure 14](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/16d3e3d035ade0092b4f170b6c4b53b22499c38cc3aa77303e37fae087af35b0.png)  






## References

https://www.jianshu.com/p/f1458f478487

https://www.zhihu.com/question/278117164

https://zhuanlan.zhihu.com/p/37768413

https://zhuanlan.zhihu.com/p/53005534

https://www.pianshen.com/article/7751693391/

https://time.geekbang.org/column/article/80393

