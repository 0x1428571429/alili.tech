---
title: Math - Tree Concepts (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: rakfaq9whbo
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-10 00:00:00
---

## Basic Concepts of Trees

A tree is a data structure composed of nodes or vertices and edges (possibly nonlinear) that does not contain any cycles. A tree without nodes is called an empty (null or empty) tree. A non-empty tree includes a root node and (likely) multiple additional nodes, all nodes forming a multi-level hierarchical structure.

> A tree is a special type of graph (graphs will be mentioned in subsequent articles).


### Prefix Tree (Trie)

![Figure 8](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/dc55d3f7c58c5e38030f58b6a11af37a8535c56b0dfd02b2b9401da912c11247.png)  



### Directed Tree
Its edges have direction. And a tree is a connected graph without simple cycles.

![Figure 4](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d338189fc4a8f481e78f1b2dfc233092a86de06c3cde4aa1b4b66c0bbc4d0974.png)  

The number of edges starting from node v is called v's `out-degree`. The number of edges ending at v is called v's `in-degree`. In the figure above, node v2's in-degree is 1, out-degree is 2.

![Figure 6](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/ef20833f4e203927f14b2cd38fb4aa4a745189edcd2a9bb7f718cf3ccbe724fc.png)  


### Cycles and Connectivity

![Figure 5](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/78550e24c117088c62a2ccb3a770704d8f6a1aa3c0b8335f5f3e45ff2c9d40a3.png)  


### Height and Nodes
![Figure 7](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/eee7e70c2d8c6917c8315cc3d6d57e183450a66161268acd129933c0d50a70c3.png)  



## Binary Tree
Binary trees are further divided into: perfect binary tree, complete binary tree, full binary tree

### Perfect Binary Tree (Full Binary Tree)
Every node except leaf nodes has two child nodes, every level (including the last level) is completely filled
![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/4bf41f860a4d23494c030df8f4bba58a7e13fd76d6a1c865d719bd1408907e2a.png)  


### Complete Binary Tree
A complete binary tree satisfies perfect binary tree from root node to second-to-last level, the last level can be incompletely filled, its leaf nodes are all left-aligned
![Figure 2](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/36856163c4ab4de51257b6a164490c7fa91b36850273ece7db420fea7b25cd5d.png)  

### Full Binary Tree
All non-leaf nodes have degree 2
In other words: as long as you have children, you must have two children.
![Figure 3](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/2cf115b05053cd1f809651a82255731d9bc1d5a0269ca7228de1ecefccba5a0e.png)  


