---
title: Math - Tree Depth-First Search and Breadth-First Search (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: 5g1oligl91
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice,Depth-First Search
date: 2020-09-11 00:00:00
---

## How to Implement Depth-First Search Using Recursion and Stack?

The process of depth-first search is logically consistent with recursive calls.

### Write a TreeNode Class Code Supporting Node Insertion

```js
class TreeNode {
    constructor(key){
        this.key = key;
        this.sons = []
    }
    insert(key){
        let node = new TreeNode(key);
        this.sons.push(node)  
        return node
    }
}
```

### Try Creating a Tree

```js
let str = 'hello word'
let str2 = 'abcdefg'

// Root node
let root = new TreeNode("root")

createTree(str,root)

createTree(str2,root)

function createTree(strs,parent){
    if(strs.length !==0){
        let found = parent.sons.find((item)=>item.key === strs[0])
        if(found){
            let newStrs = strs.slice(1)
            createTree(newStrs,parent)
        }else{
            let node = parent.insert(strs[0])
            let newStrs = strs.slice(1)
            createTree(newStrs,node)
        }
      
    }else if(strs.length === 0){
        console.log('Creation complete',root)
        return root
    }
}
```

## Start Depth-First Search

```js
// Use stack to implement depth-first search
// General idea is to push all nodes into an array, then take the last one to process, delete while processing.
// Continue until none remain
function dfsByStack(root) {
    let stack = []; 
      // Create stack object, js uses array instead of stack, where each element is TreeNode type
    stack.push(root);    // During initialization, push the root node
    while (stack.length) {  // As long as there are nodes in the stack, continue
    // Get the node just pushed in
    let node = stack.pop();  // Pop the top node of the stack, get the first node that went in
    if (node.sons.length == 0) {
      // Already reached a leaf node, output
        console.log('Reached leaf node',node.key)
    } else {
      // Non-leaf node, traverse each of its child nodes
      // Note, a temporary stack stackTemp is used here
      // This is to maintain traversal order, consistent with recursive traversal order
      // If consistency is not required, can directly push to stack
      let stackTemp = []
      for (let index = 0; index < node.sons.length; index++) {
          const son = node.sons[index];
          console.log(son.key)
          stackTemp.push(son)
      }
      //   Sort the nodes and put them in the stack
      //   Reverse the order
      while (stackTemp.length) {
        stack.push(stackTemp.pop());
      }
    }
    }
  }  
```

## Breadth-First Search (BFS)

Breadth-First Search BFS (Breadth First Search) is also called width-first search. It is a strategy that expands nodes in the order they are generated.

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/6bb7a63d95beaa9f89748a7b84c0195974d741b7055e6da9cbfaa5516a465233.png)  

## Start Breadth-First Search

```js
bfs(root.sons)
function bfs(queue){
    if(queue.length === 0){console.log('Finished');return;}
    let tmpQueue = []
    for (let index = 0; index < queue.length; index++) {
        const element = queue[index];
        console.log(element.key)
        if(element.sons && element.sons.length){
           // Prepare data needed for next search
            tmpQueue.push(...element.sons)
        }
    }
    bfs(tmpQueue)
}
```

