---
title: Math - Relationship Between Data Structures, Programming Statements, Basic Algorithms and Mathematics (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 97enyq3a3m
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-15 00:00:00
---

Many people say data structures and algorithms cannot be counted as mathematics.

> Different data structures are products of applying mathematical thinking in programming.
> Each data structure has its own characteristics, helping us more conveniently implement certain specific mathematical models.

## Data Structures

> Don't underestimate these data structures, they are actually "models" for solving problems

### Array

Characteristics: Can directly locate required data through index, suitable for random access. Often combined with loop statements to implement iterative methods, such as binary search, Fibonacci sequence, etc.

Disadvantages: Arrays are only effective for dense sequences. If sequence is very sparse, many array elements are invalid values, wasting storage space. In addition, insertion and deletion of array elements is also troublesome, requiring batch data movement.

How to solve sparse sequence problem: `Linked List`


### Linked List

Nodes in linked list store data, and connection relationships between linked list nodes are implemented through object references in `JavaScript` language.

Characteristics: Cannot directly access data through index, must read sequentially according to storage structure

Advantages: Don't need to specify data quantity in advance, no longer need to save invalid values, can more effectively utilize storage space when representing sparse sequences, also conducive to dynamic insertion and deletion of data

Disadvantages: Compared to arrays, linked lists cannot support fast random access, read and write operations take more time

### Hash Table

Hash tables can be constructed through arrays and linked lists. Previously we implemented hash tables through `remainder`.

Advantages: If key is known, access speed is extremely fast, insertion is fast

Disadvantages: Deletion is slow, if key unknown then access is very slow, storage space usage is not efficient, hash collisions will occur


### Tree

Advantages: Fast search, insertion, deletion, tree is always balanced. Similar trees are useful for disk storage, hash collisions won't occur

Disadvantages: Complex algorithms

### Graph

Graph is another nonlinear data structure. In graph structure, data nodes are generally called vertices, and edges are ordered pairs of vertices. If an edge exists between two vertices, it means these two vertices have an adjacent relationship

### Stack

First in last out. When we perform function recursion, function call and return order is also first in last out, so stack embodies recursive thinking, can implement recursion-based programming

### Queue

First in first out data structure, elements entering queue first get processed first.

In message queues, implements loose coupling between producers and consumers, protects consumers, making them less likely to be overwhelmed by data flood.



## Programming Statements

### Boolean Expressions
Embodies concepts of logic and sets in logical algebra

```js
if(expression) {function body 1} else {function body 2} // If expression is true, execute function body 1, otherwise execute function body 2.
```

## Loop Statements

Loop statements embody `iterative method (Newton's method)`

## Function Calls

Can call itself, can also call other different functions. If continuously calling itself, this embodies `recursion` thinking.


### Join Operations in SQL Language

Join has multiple types, each type actually corresponds to a `set operation`.



## Basic Algorithms

### Algorithm Complexity Analysis

`Four arithmetic operations`, `distinguish primary and secondary`, `proceed side by side`, `permutation and combination`, `one picture worth a thousand words` and `time-space exchange`.

These rules embody mathematical thinking such as `operation priority`, `order of magnitude`, `multivariate variables`, `graph theory`, etc.


## Summary

When learning programming, you can think more from mathematical perspective, think about mathematical models behind it.

This not only helps you integrate existing knowledge, but also helps you optimize data structures and algorithms

