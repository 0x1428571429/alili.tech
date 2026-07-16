---
title: Math - Joint Probability, Conditional Probability, Marginal Probability and Bayes' Theorem (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: haz1cu03hf
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-13 00:00:00
---

> Formula symbol explanation: `P(A|B) is the conditional probability of A given B`

## Joint Probability

Various explanations for better understanding:

* Joint probability refers to the probability that contains multiple conditions and all conditions are satisfied simultaneously, denoted as P(X=a,Y=b) or P(a,b). Some books also use P(ab), but I'm not used to this notation, so I'll use comma-separated notation below. It's important to note that all conditions must be satisfied simultaneously!

* The probability of the intersection of two or more events

![Figure 12](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/134caf5fa4c114e6825b4e32eb93a1187310e208764246a05043523aad78cbec.png)  

> Example: The probability of drawing a red 4 from a deck of cards is P(red 4) = 2/52 = 1/26. (A deck has 52 cards, and we want to draw the 4 of hearts and 4 of diamonds).

## Conditional Probability

* Conditional probability is the probability of one (or some) event(s) occurring given that another (or some) event(s) has already occurred. The conditional probability of event A occurring given that event B has occurred is written as P(A|B).

* Conditional probability represents the probability of X=a given that condition Y=b is satisfied, denoted as P(X=a|Y=b) or P(a|b).

> Example: Given that we've drawn a red card, the probability that this card is a 4 is P(4|red) = 2/26 = 1/13 (A deck has 52 cards, 26 red and 26 black. Now that we've drawn a red card, we know our selection range is 26 cards, so the first divisor is 26).

## Difference Between Joint Probability and Conditional Probability

### Explanation 1: 
P(AB) Joint probability: The pool hasn't changed.

P(A|B) Conditional probability: The pool has shrunk!!!!!!

So if using conditional probability to calculate joint probability: The pool can't shrink, multiply it back!!!!

P(A|B) × P(B) = P(AB)

### Explanation 2: 

When we want to know the probability of drawing a red 4 card (joint probability of red and 4), I want you to imagine placing all 52 cards face down and randomly selecting one. Among these 52 cards, 2 are red and also numbered 4 (4 of hearts and 4 of diamonds). So the joint probability is 2/52 = 1/26.

When we want to know the probability of drawing a card numbered 4 given that the drawn card is red, i.e., conditional probability P(4|red), I want you to imagine 52 cards again. However, before randomly drawing a card, you sorted all the cards and selected all 26 red cards. Now you place these 26 cards face down and randomly select one. Similarly, there are two cards numbered 4 among these red cards, so the conditional probability is 2/26 = 1/13.

### Formula Description
![Figure 13](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d6562409852e71d9261a5a2f423d9f03249fb7869fe6dc51d64bba002de1e9ba.png)  

## Marginal Probability

Explanation:

* For discrete random variables, we can obtain P(x) by summing the joint probability P(x, y) over y. For continuous random variables, we can derive probability P(x) by integrating (infinite summation) the joint probability P(x, y) over y. At this point, we call P(x) the marginal probability.

* Marginal probability corresponds to joint probability, P(X=a) or P(Y=b). This type of probability related only to a single random variable is called marginal probability.

## Bayes' Theorem

British mathematician Thomas Bayes (Thomas Bayes) first proposed this theorem in a paper published in 1763. This paper was published posthumously by one of his friends. In this paper, he proposed Bayes' theorem to solve an "inverse probability" problem.

Before Bayes wrote this article, people were already able to calculate "forward probability". For example, Durex held a lottery with 10 balls in a bucket, 2 white balls and 8 black balls. Drawing a white ball means you win. You reach in and randomly draw 1 ball. What's the probability of drawing a winning ball? According to the frequency probability formula, you can easily know the winning probability is 2/10.

### What is Bayes' Theorem Used For?

With limited information, it can help us predict probability.

Bayes' theorem can be seen everywhere probability prediction is needed. In particular, Bayes is one of the core methods of machine learning. For example, spam filtering, Chinese word segmentation, AIDS testing, liver cancer testing, etc.

### Bayes' Theorem Formula

![Figure 14](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/16d3e3d035ade0092b4f170b6c4b53b22499c38cc3aa77303e37fae087af35b0.png)  

## References

https://www.jianshu.com/p/f1458f478487

https://www.zhihu.com/question/278117164

https://zhuanlan.zhihu.com/p/37768413

https://zhuanlan.zhihu.com/p/53005534

https://www.pianshen.com/article/7751693391/

https://time.geekbang.org/column/article/80393

