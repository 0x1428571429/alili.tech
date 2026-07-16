---
title: 一个两年前.gitattributes文件导致的bug
categories: [DevOps]
tags: [Git]
slug: zift8zkisnf
keywords: git
date: 2019-01-24 19:33:33
---

# 起因

一时兴起,我打开了我两年前写的一个前端项目开始代码审查.
这个项目我一个人写了两年,大概十几万行代码的样子.

发现这个项目的git居然把所有的代码文件都识别成了二进制文件.
这个问题,之前困扰了我很久,却一直找不到原因.导致我的代码没有对比记录.

> 再顽固的问题也有水落石出的一天

说巧不巧,今天偏偏找到了问题的源头.

# .gitattributes

最后发现是因为`.gitattributes`文件有一行配置因为换行问题.导致所有text的文件都识别成了二进制文件.

## .gitattributes的作用

.gitattributes文件是一个简单的text文本文件，它的作用是重新定义指定文件的属性, 指定非文本文件的对比合并方式

### 编写规则

```
pattern    attr1 attr2 ...
```

### 示例

```
*.ttf binary
*.woff binary
*.eot binary
*.otf binary
* text=auto
```
上面这段代码表示,将一些字体文件指定为二进制文件,当提交代码的时候git不会diff这些文件的变动详情.
他只会告诉你,文件变动了,但是不会告诉你具体哪里变了.