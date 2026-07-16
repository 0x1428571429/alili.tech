---
title: Git系列之关于add命令的一些事
categories: [DevOps]
tags: [Git]
slug: 638cc3cd
keywords: git,add,解决方案
date: 2017-09-10 19:33:33
---


## 基本用法
通常是通过git add <path>的形式把<path>添加到索引库中，

<path>可以是文件也可以是目录:
```
git add <path>
```


如果有很多改动,可以用以下命令来一次添加所有改变的文件:
```
 git add -A .
```


将所有修改添加到暂存区,包括添加新文件和编辑过的文件不包括删除的文件:
```
$ git add .  
```

表示添加所有内容:
```
git add -A
```

表示添加编辑或者删除的文件，不包括新添加的文件:
```
git add -u
```

如果不小心执行了以下命令:
```
git add * -f(force) //添加被忽略的文件。
```

可以吃一个后悔药:

```
git reset HEAD
```