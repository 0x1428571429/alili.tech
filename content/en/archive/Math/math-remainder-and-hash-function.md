---
title: Math - Remainder and Hash Function (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: jvh7xaof84
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-02 00:00:00
---

## Remainder

### Example 1:

Today is Wednesday, you want to know what day it will be 50 days later, you can calculate like this, divide 50 by 7 (because a week has 7 days), remainder is 1, finally add one day to today, this way you can know 50 days later is Thursday

### Example 2:
If you want to display 1123 records, 10 per page, how to calculate total pages? I think you definitely divide 1123 by 10, finally get quotient 112, remainder 3, so your total pages is 112+1=113, and final remainder is extra data that can't fill a page.


> Remainder is always within a fixed range


## Congruence Theorem

Mathematically, two integers divided by same integer, if get same remainder, then two integers are congruent

### How to Understand

In 100 days, all Mondays are congruent, all Tuesdays are congruent, similarly, Wednesdays, Thursdays, etc. are all congruent


## Hash 

Compress input of arbitrary length to output of fixed length through hash algorithm

Think about week concept:
![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/fb46f02c67b2c960e4508d742017fda08a61c36c80c9ffb177b2505f9f95de41.png)  



Take remainder of data
![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d6f4f7d47fddefdb2498b24200aee9d4cb5e8c89cc0077acd50d6964c4bd63fe.png)  


> ps. size refers to number of finite spaces not size

In this formula, x represents value waiting to be converted, and size represents number of finite storage spaces, mod represents remainder operation. Through remainder, you can convert any value to a value within finite range, then according to this new value, determine where to store data.

![Figure 6](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/fe3564b8d6dcaa4e3147f270c00a0d6672c751eb270d366f583d032fd7cfa8cc.png)  

Assume there are two records, their record numbers are 1 and 101. We store those with remainder 1 after mod 100, into first available space. Similarly, store those with remainder 2 like 2, 102, 202, etc., into second available space, store 100, 200, 300, etc. into 100th available space.

![](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/43f4278f979a39f5678d0a80ed6d92dc704812101c053537bcb3705c46f4fa22.png)  

More complex
![Figure 4](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/3fd8f07c1314585e5ad2a8294f60af0832debbd8b602d142c6503e6b93eb4f4b.png)  


We assume random number MAX is 590199, then we recalculate for record numbered 1, final calculation result is 0, and for record numbered 101, if random number MAX is 627901, corresponding result should be 2. This way two records previously assigned to space 1, under new formula, will be assigned to different available spaces.

