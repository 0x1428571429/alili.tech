---
title: Math - Recursion, Divide and Conquer, From Merge Sort to MapReduce (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: zr4ve5abfzg
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-06 00:00:00
---

Teacher Huang Shen's title is really too good, can't find better title to describe today's learning content. Haha~

## Divide and Conquer Thinking in Merge Sort

> Problem: Sort a pile of messy unordered numbers according to rules from small to large or large to small

#### Ordered Case
Try merging ordered arrays {1, 2, 5, 8} and {3, 4, 6} process.
![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/ba8272d5cbead0e8168ecf222e0ddc87bd2a089a7ffb236f5b6b9c38b435723d.png)  


#### Unordered Case

Try to continuously simplify problem, i.e., continuously simplify sequence, until only 1 number remains. 1 number itself is ordered,

Simplify sequence of length n to sequence of length n-1 each time, until length 1. However, such processing has no parallelism, need n-1 merge operations, but efficiency will be very low.

![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/a4e5044079ca4e287a13e3f34d81f1bd712222c31aae713439cb9c4afb449e99.png)  


#### Introduce Divide and Conquer Thinking

Divide and Conquer, we usually abbreviate as divide and conquer. Its thinking is, decompose a complex problem into two or even multiple subproblems of same or similar scale, then further subdivide these subproblems, until final subproblems become very simple, easily solvable, then this complex problem is solved.


An array's sorting
![Figure 3](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/561575b5a08832ca432284406d793732de813a010178fa24246130241575c2c8.png)  


Two arrays sorted then merged

![Figure 4](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4d11bc859f11b67592da63cb7335032a6d94d283191b15ad36130aff960d34ae.png)  

Most important thinking is how to decompose problem
![Figure 5](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4af4e60683c72eb81042cad628130719a794e454987742f2ed6ac090bfb5be4e.png)  


Different stages of merge sort

![Figure 6](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/695f43d5f338aa5f49fe970a32bd9d5cff4ab39a763b2eb407474fa3a0dc5b91.png)  



### Use Recursive Method to Implement Above Thinking

```js
      // Recursively split array
      function merge_sort(to_sort) {
        // Invalid data, directly return []
        if (!to_sort) return [];
        
        // If decomposed to only one number, return that number
        if (to_sort.length == 1) return to_sort;
        
        // Decompose array into left and right halves
        let mid = to_sort.length / 2;

        // splice in js will modify original array content,
        // After taking first half, second half directly take original array variable reference
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
    
    // a,b array indices
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
    
    // Put remaining numbers from some array into merged array
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

When array to sort is very large (like reaching 1024GB), we can't stuff all this data into one ordinary machine's memory. What to do? One method, we can decompose this super large dataset into multiple smaller datasets (like 16GB or smaller), then distribute to multiple machines, let them process in parallel.



![Figure 8](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/fd13bf6e97bf69b66382e8fae79c7b279efdb2fae25cc092ab552c367fb217ca.png)  


### MapReduce Architecture
![Figure 9](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/f135ad47d8e85e37b3e13a5e0c6fcd3a75d0b37cf1c1731a16a723089673876c.png)  


#### Three Steps Use Divide and Conquer Thinking

##### Data Segmentation and Mapping Segmentation

Refers to segmenting data source, and sending segments to Mapper. Mapping refers to Mapper according to application needs, storing content according to key-value matching into hash structure.

##### Reduction
Reduction refers to receiving a set of key-value pairs, if pairs have same key content, merge their values. This is similar to local recursive call then return result process

##### Merge
To improve shuffle stage efficiency, can choose to reduce key-value pairs sent to reduction stage. Specific method is add merge process between data mapping and shuffle, perform one local reduction on each Mapper node first. Then only send merged results to shuffle and reduction stages. This is similar to local recursive call then return result process


## Afterword

Recursion, decompose complex problems into simple problems,

Then preset all failure situations you can think of (emergency plan), handle them.

A recursive algorithm comes out.

