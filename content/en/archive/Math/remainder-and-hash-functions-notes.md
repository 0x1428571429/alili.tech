---
title: Math - Remainder and Hash Functions (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: jvh7xaof84
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-02 00:00:00
---

## Remainder

### Example 1:

Today is Wednesday, you want to know what day of the week it will be 50 days from now. You can calculate like this: divide 50 by 7 (because there are 7 days in a week), then the remainder is 1, finally add one day to today, so you can know that 50 days from now is Thursday.

### Example 2:
If you want to display 1123 pieces of data, 10 per page, how do you calculate the total number of pages? I think you would divide 1123 by 10, get a quotient of 112 and a remainder of 3, so your total number of pages is 112+1=113, and the final remainder is the extra data that doesn't make up a full page.

> Remainder is always within a fixed range.

## Congruence Theorem

Mathematically, two integers divided by the same integer, if they yield the same remainder, then the two integers are congruent.

### How to Understand

In 100 days, all Mondays are congruent, all Tuesdays are congruent, similarly, Wednesdays, Thursdays, etc. are all congruent.

## Hash

Compress input of arbitrary length to output of a fixed length through hash algorithms.

Think about the concept of weeks:
![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/fb46f02c67b2c960e4508d742017fda08a61c36c80c9ffb177b2505f9f95de41.png)  

Take remainder of data
![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d6f4f7d47fddefdb2498b24200aee9d4cb5e8c89cc0077acd50d6964c4bd63fe.png)  

> ps. size refers to the number of finite spaces, not the size.

In this formula, x represents the value waiting to be converted, and size represents the number of finite storage spaces, mod represents the remainder operation. Through remainder, you can convert any value into a value within a finite range, then determine where to store the data based on this new value.

![Figure 6](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/fe3564b8d6dcaa4e3147f270c00a0d6672c751eb270d366f583d032fd7cfa8cc.png)  

Suppose there are two records with record numbers 1 and 101. We store those with remainder 1 after modulo 100 in the first available space. Similarly, store those with remainder 2 (2, 102, 202, etc.) in the second available space, store 100, 200, 300, etc. in the 100th available space.

![](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/43f4278f979a39f5678d0a80ed6d92dc704812101c053537bcb3705c46f4fa22.png)  

A bit more complex
![Figure 4](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/3fd8f07c1314585e5ad2a8294f60af0832debbd8b602d142c6503e6b93eb4f4b.png)  

We assume the random number MAX is 590199, then we recalculate for record number 1, the final calculation result is 0. For record number 101, if random number MAX is 627901, the corresponding result should be 2. In this way, the two records previously assigned to space 1, under the action of the new calculation formula, will be assigned to different available spaces.

