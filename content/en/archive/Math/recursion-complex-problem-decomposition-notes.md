---
title: Math - Recursion, Complex Problem Decomposition (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: ru7lce72gge
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-05 00:00:00
---

## Recursion and Loops

Theoretically, everything recursion can do, loops can also achieve.

Recursion and loops are both implementations of iterative methods, and in certain situations, their implementations can be converted to each other.

## Why Use Recursion?

> Since the function value return process of recursion is consistent with loop-based iterative methods, why not just use iterative methods directly? Why do we need to use recursive mathematical thinking and programming methods?

### How to Find All Possible Summation Methods Under a Limited Total?

> Suppose there are four denominations of currency: 1 yuan, 2 yuan, 5 yuan, and 10 yuan. To reward someone 10 yuan, you can give 1 ten-yuan note, or 10 one-yuan notes, or 5 one-yuan notes plus 1 five-yuan note, etc. How many schemes will there be in total?

![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/685328b2212b37eeb3e874636dd38d7cc2fee83886cc07741a9f5a5f9a82aa8c.png)  

## How to Simplify Complex Problems?

```js
// Denominations
var rewards = [1, 2, 5, 10];


  /**
    * @Description:  Use recursive (nested) function calls to find all possible reward combinations
    * @param totalReward-Total reward amount, result-Save current solution
    * @return void
    */
function get(totalReward,result){

  // If all rewards are given out
  if (totalReward == 0) { 
      // Got a result that meets conditions, output
    console.log(result); 
    return; 
  }

  // If reward money exceeds the originally planned reward (too much money given),
  // Then it's not the result we want
  if (totalReward < 0) { return; }

        // Triggered by different denominations, let them start recursion
        for (let i = 0; i < rewards.length; i++) {
          let newResult = [].concat(result)  // Since there are 4 situations, need to clone current solution and pass to called function
          newResult.push(rewards[i]);  // Record current choice

          // totalReward - rewards[i] means how much money hasn't been given yet
          // Leave it to the next recursion to solve how much to give
          get(totalReward - rewards[i], newResult);    // Leave remaining problem for nested calls to solve
        }
}

// Different schemes for giving 10 yuan
get(10,[])
```

If using loops to solve such problems, wouldn't it be relatively less concise?

* The core idea of recursion is similar to mathematical induction and is more extensive. The similarity between these two is reflected in: decomposing the current problem into two parts: one is the step currently taken, and the other is a simpler problem.

* Recursion uses nested function calls in computers. Function calls themselves can save many intermediate states and variable values, thus greatly facilitating programming processing.

## Afterword

Nothing is difficult if you're willing to break it down.

