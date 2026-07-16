---
title: Math - Permutation, Solve Tianji Horse Racing and Password Cracking Problems (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 9kfvaensryf
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-07 00:00:00
---

## Tianji Horse Racing Story

Tianji was a famous general of Qi, often raced horses with King of Qi, but always lost, very unhappy. Sun Bin wanted to help Tianji. He divided these horses into upper, middle, lower three grades. He let Tianji use his lower grade horse to fight King's upper grade horse, use upper grade horse to fight King's middle grade horse, use middle grade horse to fight King's lower grade horse. After three matches, Tianji only lost first match, won last two matches, finally won entire match with King.

## Permutation Concept

From n different elements, take m (1≤m≤n) different elements, arrange them in a sequence according to certain order, this process is called `Permutation`.

When m=n this special case appears, this is `All Permutation`

## Tianji Horse Racing Permutation Diagram

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/de799500620468a7d1fcf9a4941166f975385c21a75a39ab66eab8791557d1d1.png)  

### Final Permutation Count

Permutation total calculation 3x2x1=6

* For n elements' all permutations, all possible permutation count is `nx(n-1)x(n-2)x…x2x1`, which is n!
  
* For n elements taking `m (0<m≤n)` elements' non-repeating permutation count is `nx(n-1)x(n-2)x…x(n - m + 1)`, which is n!/(n-m)!

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
  * @Description:  Use function recursion (nesting) calls to find all possible horse battle orders
  * @param horses-How many horses currently not yet battled, result-Save currently battled horses and order
  * @return void
  */

function permutate(horses, result) {
  // All horses have battled, judge which side wins, output result
  if (horses.length == 0) {
    // console.log(result);
    compare(result, q_horses);
    return;
  }

  for (let i = 0; i < horses.length; i++) {
    // From remaining unbattled horses, choose one, add to result
    let new_result = [].concat(result)
    new_result.push(horses[i])

    // Remove selected horse from unbattled list
    let rest_horses = [].concat(horses);
    rest_horses.splice(i, 1)

    // Recursive call, continue generating permutations for remaining horses
    // Equivalent to nested for loops with self, scramble order
    permutate(rest_horses, new_result);
  }
}


function compare(t, q) {
  // Tianji's race times
  let t_won_cnt = 0;
  for (let i = 0; i < t.length; i++) {
    if (t_horses_time[t[i]] < q_horses_time[q[i]]) t_won_cnt++;
  }

  // Time comparison, this time is best of three
  if (t_won_cnt > (t.length / 2)) {
    console.log("Tianji wins!")
  } else {
    console.log("King wins!")
  }
}

// Start calculation
permutate(t_horses, [])
```

Tianji's winning probability is 1/6

## How Does Brute Force Password Cracking Use Permutation Thinking?

Brute force cracking is to try all possible passwords once

Assume there's a 4-letter password, each digit is lowercase letter between a～e. Can you write code to brute force crack this password? (Hint: According to repeatable permutation rule, generate all possible 4-letter passwords.)

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


Permutation can help us generate many possibilities. Because of this characteristic, permutation's most use is exhaustive method, i.e., list all possible situations, verify one by one, then see which situations meet conditions for solution.

