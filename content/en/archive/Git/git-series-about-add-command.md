---
title: Git Series - About the Add Command
categories: [DevOps]
tags: [Git]
slug: git-series-about-add-command
keywords: git,add,solution
date: 2017-09-10 19:33:33
---


## Basic Usage
Usually add `<path>` to the index library through the form `git add <path>`,

`<path>` can be a file or a directory:
```
git add <path>
```


If there are many changes, you can use the following command to add all changed files at once:
```
 git add -A .
```


Add all modifications to the staging area, including new files and edited files, excluding deleted files:
```
$ git add .  
```

Means add all content:
```
git add -A
```

Means add edited or deleted files, excluding newly added files:
```
git add -u
```

If you accidentally executed the following command:
```
git add * -f(force) //Add ignored files.
```

You can take a "regret pill":

```
git reset HEAD
```

