---
title: Math - Combinations, Solving Schedule Planning and Natural Language Processing (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: yraotmb3ot
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-08 00:00:00
---

## Combinations

Combination is a mathematical term. Generally, selecting m (m≤n) elements as a group from n different elements is called a combination of m elements taken from n different elements. We call problems related to finding the number of combinations combination problems.

For the complete set of combinations for all m values, we can call it All Combination. For example, for the set {1, 2, 3}, the all combination is {empty set, {1}, {2}, {3}, {1, 2}, {1,3} {2, 3}, {1, 2, 3}}.

## How to Arrange World Cup Schedule

Want all 32 teams to play one home and away game against every other team.

A team cannot play against itself. In non-repetitive arrangements, the home team has 32 choices, and the away team has 31 choices. So how many games need to be played? Simple, it's `32×31=992` games!

In actual situations, schedule design doesn't do this.

This is why all 32 teams are divided into 8 groups first for group stage matches. Once divided into groups, each group's matches are (4×3)/2=6 games. All group stage matches are 6×8=48 games.

Plus starting from the round of 16, elimination system is adopted, eliminating in pairs, so 8+4+2+2=16 elimination matches are needed (the last +2 is because there's also the 3rd and 4th place final), so the entire World Cup final stage is 48+16=64 matches.

How did I calculate these pairwise match counts? Let me introduce today's concept, Combination.

## Let Computers Combine Teams

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/b7fab79358476b5a14b566571c7e5ff1915189b170274e1c706005069e43b3df.png)  

```js
/*
    * @Description:  Use recursive (nested) function calls to find all possible team combinations
    * @param teams-How many teams are left without participating in combination, result-Save currently combined teams
    * @return void
    */
  let teams = ["t1", "t2", "t3"];
  combine(teams,[],2)


   function combine(teams,result,m) {
    // Finished selecting m elements, output result
    if (result.length == m) {
       console.log(result)
      return;
    }

    for (let i = 0; i < teams.length; i++) {
      // From remaining teams, select one team, add to result
      let newResult = [].concat(result)
      newResult.push(teams[i]);

      // Only consider all teams after current selection
      let rest_teams = teams.slice(i + 1, teams.length)

      // Recursive call, continue generating combinations for remaining teams
      combine(rest_teams, newResult, m);
    }
  }

```

Notice that this algorithm is very similar to the password brute force idea from the previous article.

## Using Combinations to Efficiently Process Phrases

Each very long article is separated into individual words, then each word is indexed for future queries. But often, having only individual words is not enough, we also need to consider phrases composed of multiple words. For example, phrases like "red bluetooth mouse".

A common approach is `n-gram`. Merge nearby words to form a new phrase. For example, I can merge "red" and "bluetooth" into "red bluetooth", and also merge "bluetooth" and "mouse" into "bluetooth mouse".

If we only keep the original "red bluetooth mouse", we cannot match it with user input "bluetooth red mouse"

When multiple words appear, sort the phrase after each user input, for example:

"red bluetooth mouse", these three words sorted become "bluetooth,mouse,red", and "bluetooth red mouse" sorted also becomes "bluetooth,mouse,red", naturally they can match.

## Design a Lottery System

Suppose we need to design a lottery system. Need to sequentially select from 100 people: 10 third prizes, 3 second prizes, and 1 first prize. Please list all possible combinations, noting that each person can only be selected once at most.

* Approach 1: First run combine(100, 14), for each result run combine(14, 10), then for each updated result run combine(4, 3).

* Approach 2: Select 10 people from 100 for 3rd prize, combine(100, 10); then select 3 people from remaining 90 for 2nd prize, combine(90, 3); then select 1 person from remaining 87 for 1st prize, combine(87, 1)

> This value is too large, JavaScript cannot calculate it.

