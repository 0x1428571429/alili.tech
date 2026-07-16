---
title: Math - Recursion, Decompose Complex Problems (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: ru7lce72gge
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-05 00:00:00
---

## Recursion and Loops

Theoretically all recursion can do, loops can achieve.

Recursion and loops are actually implementations of iterative method, and in certain situations, their implementations can be converted to each other.

## Why Use Recursion

> Since recursive function value return process is consistent with loop-based iterative method, why not just use iterative method directly, why still use recursive mathematical thinking and programming methods?


### How to Find All Possible Summation Methods Under Limited Total?

> Assume there are four denominations of currency, 1 yuan, 2 yuan, 5 yuan and 10 yuan, want to reward someone 10 yuan, can reward 1 ten yuan note, or 10 one yuan notes, or 5 one yuan notes plus 1 five yuan note, etc. How many schemes total?


![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/685328b2212b37eeb3e874636dd38d7cc2fee83886cc07741a9f5a5f9a82aa8c.png)  


## How to Simplify Complex Problems?

```js
// Denominations
var rewards = [1, 2, 5, 10];


  /**
    * @Description:  Use function recursion (nesting) calls to find all possible reward combinations
    * @param totalReward-Total reward amount, result-Save current solution
    * @return void
    */
function get(totalReward,result){

  // If all rewards given out
  if (totalReward == 0) { 
      // Got result meeting conditions, output
    console.log(result); 
    return; 
  }

  // If reward money exceeds originally planned reward (gave too much money),
  // Then not result we want
  if (totalReward < 0) { return; }

        //Trigger recursion based on different denominations
        for (let i = 0; i < rewards.length; i++) {
          let newResult = [].concat(result)  // Because there are 4 cases, need to clone current solution and pass to called function
          newResult.push(rewards[i]);  // Record current choice

          // totalReward - rewards[i] means how much money still not given
          // Leave to next recursion to solve how much to give problem
          get(totalReward - rewards[i], newResult);    // Remaining problem, leave to nested call to solve
        }
}

// Give 10 yuan different schemes
get(10,[])
```

If using loops to solve such problems, relatively not as concise?

* Recursion's core thinking is similar to mathematical induction, and more universal. Similarities between these two: decompose current problem into two parts: one current step taken and another simpler problem.

* Recursion uses computer function nested calls. Function calls themselves can save many intermediate states and variable values, therefore greatly convenient for programming processing.

## Afterword

Nothing is difficult, as long as willing to decompose

