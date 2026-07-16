---
title: React系列之父组件如何传递Props给this.props.children
categories: [Frontend]
tags: [React]
slug: 7aed82f9
keywords: react,props,单项数据流,children
date: 2017-09-08 19:33:33
---

### 问题
React使用router之后,以下形式会经常出现.

```javascript
this.props.children
```
可是这样渲染出来的组件,父组件如何传递props给它呢?

### 解决


我们可以这样传递porps给子组件:

```javascript
{ 
    React.cloneElement(this.props.children,{A:xxx,B:xxx2,C:xxx3}) 
    
 }
```

