---
title: Math - Mathematical Induction, Injecting Soul into Computers (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: fexppeuk3m
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-04 00:00:00
---

## What is Mathematical Induction?

The rule for placing wheat grains on a chessboard is: place 1 grain in the first square, 2 grains in the second square, and so on. Each small square has twice as many wheat grains as the previous small square, until all 64 squares are filled. You find that the wheat grains in squares 1 to 8 are: 1, 2, 4, 8, 16, 32, 64, 128.

### Finding Patterns
![Figure 9](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/873afd7eccb11857ce37c70086e24e186089ea2e8e93daf7ea8677ee5746460e.png)  

For problems involving infinite sequences like this, we usually use `Mathematical Induction` to prove.

## Steps of Mathematical Induction

* Prove whether the base case (usually when n=1) holds;
* Assume n=k−1 holds, then prove n=k also holds (k is any natural number greater than 1).

Compared to calculations using iterative methods, the biggest characteristic of mathematical induction lies in the word "induction". It has already summarized the pattern. As long as we can prove this pattern is correct, there's no need for step-by-step calculations, saving a lot of time and resources.

### Code Example
```js

  let grid = 63;
  console.time('Induction time')
  console.log(`King gave this many grains: ${  Math.pow(2, grid) - 1 }`)
  console.timeEnd('Induction time')

```
> The code for recursive calls is consistent with the logic of mathematical induction, but the running time of mathematical induction implementation is almost 0.

Mathematical induction requires us to make reasonable proposition assumptions before we can prove them.

