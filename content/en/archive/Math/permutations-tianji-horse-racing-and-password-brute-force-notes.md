---
title: Math - Permutations, Solving Tianji Horse Racing and Password Brute Force Problems (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 9kfvaensryf
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-07 00:00:00
---

## The Story of Tianji Horse Racing

Tianji was a famous general of the State of Qi. He often raced horses with the King of Qi, but always lost, which made him very unhappy. Sun Bin wanted to help Tianji. He divided these horses into upper, middle, and lower classes. He had Tianji use his lower-class horse to compete against the King's upper-class horse, use his upper-class horse to compete against the King's middle-class horse, and use his middle-class horse to compete against the King's lower-class horse. After three races, Tianji only lost the first race and won the next two, ultimately winning the entire match against the King.

## Permutation Concept

Selecting m (1≤m≤n) different elements from n different elements and arranging them in a certain order is called `Permutation`.

When the special case m=n occurs, this is `All Permutation`.

## Permutation Diagram of Tianji Horse Racing

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/de799500620468a7d1fcf9a4941166f975385c21a75a39ab66eab8791557d1d1.png)  

### Final Number of Permutations

Calculation of total permutations: 3×2×1=6

* For all permutations of n elements, all possible permutation counts are `n×(n-1)×(n-2)×…×2×1`, which is n!
  
* For non-repetitive permutations of m (0<m≤n) elements taken from n elements, the count is `n×(n-1)×(n-2)×…×(n - m + 1)`, which is n!/(n-m)!

## Use Code to Calculate Various Situations of Tianji Horse Racing

```js
// King's horses and speeds
let q_horses_time = {
  q1: 1,
  q2: 2,
  q3: 3
}

// Tianji's horses and speeds
let t_horses_time = {
  t1: 1.5,
  t2: 2.5,
  t3: 3.5
}

// Their horse names
let q_horses = ["q1", "q2", "q3"]

let t_horses = ["t1", "t2", "t3"]


/**
  * @Description:  Use recursive (nested) function calls to find all possible horse racing orders
  * @param horses-How many horses are left without racing, result-Save currently racing horses and order
  * @return void
  */

function permutate(horses, result) {
  // All horses have raced, determine winner, output result
  if (horses.length == 0) {
    // console.log(result);
    compare(result, q_horses);
    return;
  }

  for (let i = 0; i < horses.length; i++) {
    // From remaining unraced horses, select one, add to result
    let new_result = [].concat(result)
    new_result.push(horses[i])

    // Remove selected horse from unraced list
    let rest_horses = [].concat(horses);
    rest_horses.splice(i, 1)

    // Recursive call, continue generating permutations for remaining horses
    // Equivalent to nested for loops with itself, shuffling order
    permutate(rest_horses, new_result);
  }
}


function compare(t, q) {
  // Tianji's racing times
  let t_won_cnt = 0;
  for (let i = 0; i < t.length; i++) {
    if (t_horses_time[t[i]] < q_horses_time[q[i]]) t_won_cnt++;
  }

  // Time comparison, this is best of three
  if (t_won_cnt > (t.length / 2)) {
    console.log("Tianji wins!")
  } else {
    console.log("King wins!")
  }
}

// Start calculation
permutate(t_horses, [])
```

Tianji's probability of winning is 1/6

## How Does Password Brute Force Use Permutation Thinking?

Brute force is to try all possible passwords once.

Suppose there's a 4-letter password, each digit is a lowercase letter between a～e. Can you write code to brute force this password? (Hint: Generate all possible 4-letter passwords based on the rule of repeatable permutations.)

```js
let words = ['a','b','c','d','e']
let passwords = []

function getPassword(words,result){
  // Enough 4, this branch ends
  if(result.length == 4){
    passwords.push(result)
    console.log(result);
    return;
  }

  // Not enough 4, continue taking
  for (let index = 0; index < words.length; index++) {
    let a = [].concat(words);
    let b = [].concat(result);
    b.push(a[index])
    a.splice(index,1)
    getPassword(a,b)
  }
}

getPassword(words,[])
console.log(passwords)
```

Permutations can help us generate many possibilities. Due to this characteristic, the most common use of permutations is exhaustive method, that is, list all possible situations, verify them one by one, and see which situations meet the conditions for solutions.

