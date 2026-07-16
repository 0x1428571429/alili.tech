---
title: Math - Recursion, Divide and Conquer, from Merge Sort to MapReduce (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: zr4ve5abfzg
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-06 00:00:00
---

Teacher Huang Shen's title is really great, can't find a better title to describe what I learned today. Haha~

## Divide and Conquer Thinking in Merge Sort

> Problem: Sort a pile of chaotic unordered numbers according to rules from small to large or large to small

#### Ordered Case
Try merging ordered arrays {1, 2, 5, 8} and {3, 4, 6}.
![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/ba8272d5cbead0e8168ecf222e0ddc87bd2a089a7ffb236f5b6b9c38b435723d.png)  

#### Disordered Case

Try to continuously simplify the problem, that is, continuously simplify the sequence until only 1 number remains. 1 number itself is ordered.

Simplify a sequence of length n to length n-1 each time, until length 1. However, this approach has no parallelism, requiring n-1 merge operations, but efficiency will be very low.

![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/a4e5044079ca4e287a13e3f34d81f1bd712222c31aae713439cb9c4afb449e99.png)  

#### Introduce Divide and Conquer Thinking

Divide and Conquer. Its idea is to decompose a complex problem into two or more subproblems of the same or similar scale, then further subdivide these subproblems until the final subproblems become very simple and easy to solve, thus solving this complex problem.

Sorting one array
![Figure 3](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/561575b5a08832ca432284406d793732de813a010178fa24246130241575c2c8.png)  

Merging two sorted arrays

![Figure 4](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4d11bc859f11b67592da63cb7335032a6d94d283191b15ad36130aff960d34ae.png)  

The most important idea is how to decompose the problem
![Figure 5](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4af4e60683c72eb81042cad628130719a794e454987742f2ed6ac090bfb5be4e.png)  

Different stages of merge sort

![Figure 6](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/695f43d5f338aa5f49fe970a32bd9d5cff4ab39a763b2eb407474fa3a0dc5b91.png)  

### Use Recursion to Implement the Above Approach

```js
      // Recursively split array
      function merge_sort(to_sort) {
        // Invalid data, return [] directly
        if (!to_sort) return [];
        
        // If decomposed to only one number, return that number
        if (to_sort.length == 1) return to_sort;
        
        // Split array into left and right halves
        let mid = to_sort.length / 2;

        // splice in js operates on original array content,
        // After taking out the first half, the second half can directly use the original array variable reference
        let left = [].concat(to_sort.splice(0,mid))
        let right = [].concat(to_sort)

        // Nested calls, sort both halves separately
        left = merge_sort(left);
        right = merge_sort(right);
        
        // Merge sorted halves
        let merged = merge(left, right);
        
        return merged;
      }


// Array merge sort
function merge(a, b) {
    if (!a) a = [];
    if (!b) b = [];
    
    // Will push results to this array later
    let merged_one = []
    
    // Indexes for a, b arrays
    let ai = 0;
    let bi = 0;
    
    // Alternately take smaller values from two arrays, put into merged array
    while (ai < a.length && bi < b.length) {
     if (a[ai] <= b[bi]) {
        merged_one.push(a[ai])
      ai ++;
     } else {
        merged_one.push(b[bi])
      bi ++;
     }
    }
    
    // Put remaining numbers from one array into merged array
    if (ai < a.length) {
     for (let i = ai; i < a.length; i++) {
      merged_one.push(a[i])
     }
    } else {
     for (let i = bi; i < b.length; i++) {
      merged_one.push(b[i])
     }
    }
    
    return merged_one;
   }


let arr = [2,5,3,1,4,6,7,8,9]

console.log('Sort result',merge_sort(arr))
// Sort result [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
```

## Divide and Conquer Thinking in Distributed Systems

When the array to be sorted is very large (e.g., reaching 1024GB), we cannot fit all this data into the memory of an ordinary machine. What to do? One approach is to decompose this super large dataset into multiple smaller datasets (e.g., 16GB or smaller), then distribute them to multiple machines for parallel processing.

![Figure 8](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/fd13bf6e97bf69b66382e8fae79c7b279efdb2fae25cc092ab552c367fb217ca.png)  

### MapReduce Architecture
![Figure 9](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/f135ad47d8e85e37b3e13a5e0c6fcd3a75d0b37cf1c1731a16a723089673876c.png)  

#### Three Steps Using Divide and Conquer Thinking

##### Data Splitting and Mapping

Refers to splitting the data source and sending fragments to Mappers. Mapping refers to Mappers storing content in hash structures according to key-value matching based on application requirements.

##### Reduction
Reduction refers to receiving a set of key-value pairs. If pairs have the same key content, merge their values. This is similar to the process of returning results after local recursive calls.

##### Combining
To improve the efficiency of the shuffle stage, we can choose to reduce key-value pairs sent to the reduction stage. Specifically, add a combining process between data mapping and shuffle, performing a local reduction first on each Mapper node. Then only send combined results to shuffle and reduction stages. This is similar to the process of returning results after local recursive calls.

## Afterword

Recursion, splitting complex problems into simple problems.

Then preset all failure situations you can think of (contingency plans) and handle them.

A recursive algorithm emerges.

