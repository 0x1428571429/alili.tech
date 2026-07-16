---
title: Math - Iterative Method, Make Each Calculation Closer to Truth (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 35dkyj5swxr
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-03 00:00:00
---

## What is Iterative Method?

Continuously use old variable values to recursively calculate new variable values.

### Short Story:

> Ancient Indian King Shah loved chess, planned to heavily reward chess inventor Prime Minister Sissa Ben Dahir. This clever minister pointed at chessboard and said to king: "Your Majesty, I don't want other rewards, please put one grain in first small square of this chessboard, two grains in second small square, four grains in third small square, and so on, each small square has double grains of previous small square, until 64 squares filled, then give all grains on chessboard to your servant me!" King thought it trivial, happily agreed. But, when started putting grains, king discovered, before reaching twentieth square, one bag of wheat already empty. Then, bag after bag of wheat put into chessboard squares, king quickly realized, even bringing all India's grain, couldn't fulfill promise to Dahir.


Calculate final wheat quantity through a function.
![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/2ef3e94c5ea97c2db46680a3d0e8050b7ba122b31a9c14b75b9f7a0f9273b977.png)  

### Very Suitable for Computer Languages

```js

function getNumberOfWheat(grid){
numberOfWheatInGrid = 0; // Current number of grains in grid 
let numberOfWheatInGrid = 1; // Number of grains in first grid 

// Put one grain first
sum += numberOfWheatInGrid; 

for (let i = 2; i <= grid; i ++) {         
    numberOfWheatInGrid *= 2;
    // Current number of grains in grid is 2 times previous grid 
    sum += numberOfWheatInGrid; 
    // Accumulate total grains 
    } 
    return sum;
}

// Calculate quantity for 64 grids
console.log(getNumberOfWheat(64))

```




## Specific Applications?

* `Find precise or approximate solutions of values`. Typical methods include Bisection method and Newton's iterative method.

* `Find target values within certain range`. Typical methods include binary search.

* `Iteration in machine learning algorithms`. Related algorithms or models are many, like K-means algorithm (K-means clustering), PageRank's Markov chain (Markov chain), Gradient descent method (Gradient descent), etc. Iterative method widely applied in machine learning because `many times machine learning process is, according to known data and certain assumptions, find a local optimal solution`. Iterative method can help learning algorithms gradually search, until discover such solution.


### Practice Bisection Method to Find Precise or Approximate Solutions of Equations

Problem: Find square root of 10

Idea: We need to first look at middle value between 1 and 10, which is 11/2=5.5. Square of 5.5 is greater than 10, so we want a smaller value, look at 3.25 between 5.5 and 1. Because square of 3.25 is also greater than 10, continue looking at value between 3.25 and 1, which is 2.125. At this time, square of 2.125 is less than 10, so look at value between 2.125 and 3.25, continue until discover some number's square is exactly 10

![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4771cedc9e0875af0010799178b6895af9b44724987c16f3e25186247745666b.png)  


```js

/** * 
 * @Description: Calculate square root of positive integer greater than 1 
 * @param n-Number to find, deltaThreshold-Error threshold, maxTry-Maximum times for binary search
 * @return double-Square root solution 
 * */

function getSqureRoot(n, deltaThreshold, maxTry) {
    // Parameters don't meet conditions, return -1
    if (n <= 1) { return -1.0; }

    let min = 1.0;
    let max = n;
    
    // Start using attempt times and expected progress to iteratively find result
    for (let i = 0; i < maxTry; i++) {
        // Take a middle number
        let middle = (min + max) / 2;
        // Start squaring
        let square = middle * middle;

        // Check if square result meets our needs
        // Math.abs is to get absolute value
        let delta = Math.abs((square / n) - 1);

        // Progress meets, return correct value
        if (delta <= deltaThreshold) {
            // Found square root meeting conditions
            return middle;
        } else {
            // Squared result greater than number n to find
            if (square > n) {
                // Redefine max
                max = middle;
            } else {
                // Less than then redefine min
                min = middle;
            }
        }
    }
    // All iterations run, no result return -2
    return -2.0;
}



// Start solving

  let number = 10;

  // Find square root of 10
  // Progress is 0.000001
  // Maximum iterate 10000 times
  let squareRoot = getSqureRoot(number, 0.000001, 10000);


  if (squareRoot == -1) {
   console.log("Please enter integer greater than 1");
  } else if (squareRoot == -2) {
   console.log("Could not find solution");
  } else {
   console.log(`${number}'s square root is${squareRootString}`);
  }

```



## Story Ending

Grid 1 has 1 grain

Grid 2 has 2 grains 

Grid 3 has 4 grains 

Grid 4 has 8 grains 

Grid 5 has 16 grains 

Grid 6 has 32 grains 

Grid 7 has 64 grains 

Grid 8 has 128 grains 

Grid 9 has 256 grains 

Grid 10 has 512 grains 

Grid 11 has 1024 grains 

Grid 12 has 2048 grains 

Grid 13 has 4096 grains 

Grid 14 has 8192 grains 

Grid 15 has 16384 grains 

Grid 16 has 32768 grains 

Grid 17 has 65536 grains 

Grid 18 has 131072 grains 

Grid 19 has 262144 grains 

Grid 20 has 524288 grains 

Grid 21 has 1048576 grains 

Grid 22 has 2097152 grains 

Grid 23 has 4194304 grains 

Grid 24 has 8388608 grains 

Grid 25 has 16777216 grains 

Grid 26 has 33554432 grains 

Grid 27 has 67108864 grains 

Grid 28 has 134217728 grains 

Grid 29 has 268435456 grains 

Grid 30 has 536870912 grains 

Grid 31 has 1073741824 grains 

Grid 32 has 2147483648 grains 

Grid 33 has 4294967296 grains 

Grid 34 has 8589934592 grains 

Grid 35 has 17179869184 grains 

Grid 36 has 34359738368 grains 

Grid 37 has 68719476736 grains 

Grid 38 has 137438953472 grains 

Grid 39 has 274877906944 grains 

Grid 40 has 549755813888 grains 

Grid 41 has 1099511627776 grains 

Grid 42 has 2199023255552 grains 

Grid 43 has 4398046511104 grains 

Grid 44 has 8796093022208 grains 

Grid 45 has 17592186044416 grains 

Grid 46 has 35184372088832 grains 

Grid 47 has 70368744177664 grains 

Grid 48 has 140737488355328 grains 

Grid 49 has 281474976710656 grains 

Grid 50 has 562949953421312 grains 

Grid 51 has 1125899906842624 grains 

Grid 52 has 2251799813685248 grains 

Grid 53 has 4503599627370496 grains 

Grid 54 has 9007199254740992 grains 

Grid 55 has 18014398509481984 grains 

Grid 56 has 36028797018963968 grains 

Grid 57 has 72057594037927936 grains 

Grid 58 has 144115188075855872 grains 

Grid 59 has 288230376151711744 grains 

Grid 60 has 576460752303423488 grains 

Grid 61 has 1152921504606846976 grains 

Grid 62 has 2305843009213693952 grains 

Grid 63 has 4611686018427387904 grains 

Grid 64 has 9223372036854775808 grains 

King gave total 18446744073709551615 grains

