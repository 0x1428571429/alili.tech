---
title: Math - Dynamic Programming, Edit Distance Calculation (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: nfo3tlig7y
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-09 00:00:00
---

## Dynamic Programming (DP)

Many people abbreviate it as DP. Dynamic programming needs to derive the optimal solution of the final problem through the optimal solution of subproblems, so this method pays special attention to the transfer relationships between subproblems. We usually call these transfers between subproblems `state transitions`, and the expressions used to describe these state transitions are called `state transition equations`.

## Edit Distance (Levenshtein Distance)

Proposed in 1965 by Russian scientist Vladimir Levenshtein (graduated from the Department of Mathematics and Mechanics, Moscow State University). He won the IEEE Richard W. Hamming Medal in 2006 for his contributions to error-correcting code theory and information theory.

* Definition: Levenshtein distance, also called edit distance, refers to the minimum number of changes needed to edit text A into text B (each change can only add, delete, or modify one character).

* Uses: Can be used to calculate string similarity, text similarity, spelling correction, plagiarism detection, etc.

* Advantages: Very high accuracy. If the edit distance is small, text similarity is definitely high.

* Disadvantages: Low recall rate. Since edit distance is related to text order. When the text is the same but the order changes greatly, similarity becomes very low. For example, "正大光明" and "光明正大" actually mean the same thing. But the edit distance is 4, completely mismatched.

### Calculation Analysis:

First, define single-character edit operations, which are exactly three types:

Insertion

Deletion

Substitution

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/189c427b9aadfa7c501b025f85ca4186591db79eae686e3a3acabbc0cdbf5d11.png)  

### Application in Search Recommendation Keywords
Calculate the edit distance between `mouuse` and `mouse`

![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/1e9ab12ce6f3535ab43e7403c067b6fc2b4a972c129bf86731b0b54477f702a4.png)  

### Table Derivation

![Figure 3](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/39bfcba830d765875f8e29a1672e4d61b1d4891f0343f4da6d0390693cb64013.png)  

> The min function here has three parameters, corresponding to the edit distances of three situations: substitution, insertion, and deletion of characters.

### Code Implementation
```js

/**
  * @Description:  Use state transition equation to calculate edit distance between two strings
  * @param a-First string, b-Second string
  * @return let-Edit distance between them
  */
function getStrDistance( a,  b) {
    
    if (a == null || b == null) return -1;


  // Initialize 2D table for recording state transitions
    let d = []
  for (let index = 0; index <= a.length; index++) {
     d.push(new Array(b.length))
  }


    // If i is 0 and j >= 0, then d[i, j] is j
    for (let j = 0; j <= b.length; j++) {
      d[0][j] = j;
    }
    
    // If i >= 0 and j is 0, then d[i, j] is i
    for (let i = 0; i <= a.length; i++) {
      d[i][0] = i;
    }

    // Current state of 2D array
    //   [
    //   [0, 1, 2, 3,4, 5, 6  ],
    //   [ 1, <5 empty items> ],
    //   [ 2, <5 empty items> ],
    //   [ 3, <5 empty items> ],
    //   [ 4, <5 empty items> ],
    //   [ 5, <5 empty items> ],
    //   [ 6, <5 empty items> ]
    // ]

    // Implement state transition equation
    for (let i = 0; i < a.length; i++) {
      for (let j = 0; j < b.length; j++) {
        
        let r = 0;
        if (a.charAt(i) != b.charAt(j)) {
          r = 1;
        } 

        // Mark all cells as needed
        // Coordinates +1 to start recording data from the second cell
        let first_append = d[i][j + 1] + 1;
        let second_append = d[i + 1][j] + 1;


        // Current cell records differences from previous comparison
        let replace = d[i][j] + r;

        console.log(a.charAt(i) , b.charAt(j))
        console.log(first_append, second_append)

        // Find the minimum of first_append, second_append, replace
        // Respectively corresponding to edit distances of three situations: substitution, insertion, and deletion of characters
        let min = Math.min(first_append, second_append);
        min = Math.min(min, replace);

        // Accumulate all differences
        d[i + 1][j + 1] = min;
        
      }
    }

    // Current state of 2D array
    // [
    //   [0, 1, 2, 3, 4, 5, 6],
    //   [1, 0, 1, 2, 3, 4, 5],
    //   [2, 1, 1, 2, 3, 4, 5],
    //   [3, 2, 2, 2, 3, 4, 5],
    //   [4, 3, 3, 2, 2, 3, 4],
    //   [5, 4, 4, 3, 3, 2, 3],
    //   [6, 5, 5, 4, 4, 3, 2]
    // ]
    // Output the final accumulated value, which is their edit distance
    return d[a.length][b.length];
  }

```

## Afterword
This section is a bit confusing, recording it here to look up more materials for deeper understanding later.
Examples are understood okay, but when it comes to application, I'm stuck. Need to do more practice...

### References

* Levenshtein Distance: https://www.jianshu.com/p/4678d3f7b6f1
* Programmer's Mathematical Foundation Course: https://time.geekbang.org/column/article/76183

