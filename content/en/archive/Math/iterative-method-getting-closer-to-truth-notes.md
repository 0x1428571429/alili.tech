---
title: Math - Iterative Method, Making Each Calculation Closer to the Truth (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 35dkyj5swxr
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-03 00:00:00
---

## What is the Iterative Method?

It's continuously using old variable values to recursively calculate new variable values.

### Short Story:

> An ancient Indian king loved chess and planned to heavily reward the inventor of chess, Prime Minister Sissa ben Dahir. This clever minister pointed to the chessboard and said to the king: "Your Majesty, I don't want any other reward. Please place 1 grain of wheat in the first small square of this chessboard, 2 grains in the second small square, 4 grains in the third small square, and so on. Each small square has twice as many wheat grains as the previous small square, until all 64 squares are filled. Then give all the wheat grains on the chessboard to your servant!" The king thought it was a trivial matter and readily agreed. However, when they started placing wheat grains, the king discovered that before reaching the twentieth square, one bag of wheat was already empty. As bag after bag of wheat was placed into the chessboard squares, the king quickly realized that even bringing all of India's grain couldn't fulfill his promise to Dahir.

Calculate the final number of wheat grains through a function.
![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/2ef3e94c5ea97c2db46680a3d0e8050b7ba122b31a9c14b75b9f7a0f9273b977.png)  

### Computer Languages Are Particularly Suitable

```js

function getNumberOfWheat(grid){
numberOfWheatInGrid = 0; // Number of wheat grains in current square 
let numberOfWheatInGrid = 1; // Number of wheat grains in first square 

// Place one grain first
sum += numberOfWheatInGrid; 

for (let i = 2; i <= grid; i ++) {         
    numberOfWheatInGrid *= 2;
    // Number of wheat grains in current square is 2 times the previous square 
    sum += numberOfWheatInGrid; 
    // Accumulate total wheat grains 
    } 
    return sum;
}

// Calculate quantity for 64 squares
console.log(getNumberOfWheat(64))

```

## Specific Applications?

* `Find exact or approximate solutions to numerical values`. Typical methods include the bisection method and Newton's iterative method.

* `Search for target values within a certain range`. Typical methods include binary search.

* `Iteration in machine learning algorithms`. There are many related algorithms or models, such as K-means clustering, PageRank's Markov chain, gradient descent, etc. The reason iterative methods are widely used in machine learning is because `often the process of machine learning is to find a local optimal solution based on known data and certain assumptions`. Iterative methods can help learning algorithms search step by step until they find such solutions.

### Practice Bisection Method to Find Exact or Approximate Solutions to Equations

Problem: Find the square root of 10

Approach: We need to first look at the middle value between 1 and 10, which is 11/2=5.5. The square of 5.5 is greater than 10, so we need a smaller value, look at 3.25 between 5.5 and 1. Since the square of 3.25 is also greater than 10, continue looking at the value between 3.25 and 1, which is 2.125. At this point, the square of 2.125 is less than 10, so look at the value between 2.125 and 3.25, continue until we find a number whose square is exactly 10

![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4771cedc9e0875af0010799178b6895af9b44724987c16f3e25186247745666b.png)  

```js

/** * 
 * @Description: Calculate square root of positive integer greater than 1 
 * @param n-Number to be calculated, deltaThreshold-Threshold of error, maxTry-Maximum number of binary searches
 * @return double-Solution of square root 
 * */

function getSqureRoot(n, deltaThreshold, maxTry) {
    // Parameters don't meet conditions, return -1
    if (n <= 1) { return -1.0; }

    let min = 1.0;
    let max = n;
    
    // Start using number of attempts and expected progress to iteratively search for results
    for (let i = 0; i < maxTry; i++) {
        // Take a middle number
        let middle = (min + max) / 2;
        // Start squaring
        let square = middle * middle;

        // See if square result meets our requirements
        // Math.abs takes absolute value
        let delta = Math.abs((square / n) - 1);

        // Progress meets requirements, return correct value
        if (delta <= deltaThreshold) {
            // Found square root that meets conditions
            return middle;
        } else {
            // Squared result is greater than number n to be calculated
            if (square > n) {
                // Redefine max
                max = middle;
            } else {
                // If less, redefine min
                min = middle;
            }
        }
    }
    // All iterations completed, no result return -2
    return -2.0;
}



// Start solving

  let number = 10;

  // Find square root of 10
  // Progress is 0.000001
  // Maximum 10000 iterations
  let squareRoot = getSqureRoot(number, 0.000001, 10000);


  if (squareRoot == -1) {
   console.log("Please enter an integer greater than 1");
  } else if (squareRoot == -2) {
   console.log("Solution not found");
  } else {
   console.log(`Square root of ${number} is ${squareRoot}`);
  }

```

## Story Ending

Square 1 has 1 grain of wheat

Square 2 has 2 grains of wheat 

Square 3 has 4 grains of wheat 

Square 4 has 8 grains of wheat 

Square 5 has 16 grains of wheat 

Square 6 has 32 grains of wheat 

Square 7 has 64 grains of wheat 

Square 8 has 128 grains of wheat 

Square 9 has 256 grains of wheat 

Square 10 has 512 grains of wheat 

Square 11 has 1024 grains of wheat 

Square 12 has 2048 grains of wheat 

Square 13 has 4096 grains of wheat 

Square 14 has 8192 grains of wheat 

Square 15 has 16384 grains of wheat 

Square 16 has 32768 grains of wheat 

Square 17 has 65536 grains of wheat 

Square 18 has 131072 grains of wheat 

Square 19 has 262144 grains of wheat 

Square 20 has 524288 grains of wheat 

Square 21 has 1048576 grains of wheat 

Square 22 has 2097152 grains of wheat 

Square 23 has 4194304 grains of wheat 

Square 24 has 8388608 grains of wheat 

Square 25 has 16777216 grains of wheat 

Square 26 has 33554432 grains of wheat 

Square 27 has 67108864 grains of wheat 

Square 28 has 134217728 grains of wheat 

Square 29 has 268435456 grains of wheat 

Square 30 has 536870912 grains of wheat 

Square 31 has 1073741824 grains of wheat 

Square 32 has 2147483648 grains of wheat 

Square 33 has 4294967296 grains of wheat 

Square 34 has 8589934592 grains of wheat 

Square 35 has 17179869184 grains of wheat 

Square 36 has 34359738368 grains of wheat 

Square 37 has 68719476736 grains of wheat 

Square 38 has 137438953472 grains of wheat 

Square 39 has 274877906944 grains of wheat 

Square 40 has 549755813888 grains of wheat 

Square 41 has 1099511627776 grains of wheat 

Square 42 has 2199023255552 grains of wheat 

Square 43 has 4398046511104 grains of wheat 

Square 44 has 8796093022208 grains of wheat 

Square 45 has 17592186044416 grains of wheat 

Square 46 has 35184372088832 grains of wheat 

Square 47 has 70368744177664 grains of wheat 

Square 48 has 140737488355328 grains of wheat 

Square 49 has 281474976710656 grains of wheat 

Square 50 has 562949953421312 grains of wheat 

Square 51 has 1125899906842624 grains of wheat 

Square 52 has 2251799813685248 grains of wheat 

Square 53 has 4503599627370496 grains of wheat 

Square 54 has 9007199254740992 grains of wheat 

Square 55 has 18014398509481984 grains of wheat 

Square 56 has 36028797018963968 grains of wheat 

Square 57 has 72057594037927936 grains of wheat 

Square 58 has 144115188075855872 grains of wheat 

Square 59 has 288230376151711744 grains of wheat 

Square 60 has 576460752303423488 grains of wheat 

Square 61 has 1152921504606846976 grains of wheat 

Square 62 has 2305843009213693952 grains of wheat 

Square 63 has 4611686018427387904 grains of wheat 

Square 64 has 9223372036854775808 grains of wheat 

The king gave a total of 18446744073709551615 grains of wheat

