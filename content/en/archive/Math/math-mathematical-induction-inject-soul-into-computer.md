---
title: Math - Mathematical Induction, Inject Soul into Computer (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: fexppeuk3m
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-04 00:00:00
---

## What is Mathematical Induction?

Wheat grain placement rule on chessboard is, first square one grain, second square two grains, and so on, each small square has double grains of previous small square, until 64 squares filled. You discover grids 1 to 8's wheat quantities are: 1, 2, 4, 8, 16, 32, 64, 128.

### Find Pattern
![Figure 9](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/873afd7eccb11857ce37c70086e24e186089ea2e8e93daf7ea8677ee5746460e.png)  


For infinite sequence problems like this, we usually can use `Mathematical Induction` to prove


## Mathematical Induction Steps

* Prove basic case (usually when n=1) whether holds;
* Assume n=k−1 holds, then prove n=k also holds (k is any natural number greater than 1).


Compared to calculations using iterative method, mathematical induction's biggest feature is "induction". It has already summarized the pattern. As long as we can prove this pattern is correct, no need for step-by-step calculations, can save much time and resources.

### Code Example
```js

  let grid = 63;
  console.time('Induction Method Time')
  console.log(`King Shah gave this many grains: ${  Math.pow(2, grid) - 1 }`)
  console.timeEnd('Induction Method Time')

```
> Recursive call code and mathematical induction logic are consistent, but mathematical induction implementation running time is almost 0

Mathematical induction requires us to make reasonable proposition assumptions, then can proceed with proof.





