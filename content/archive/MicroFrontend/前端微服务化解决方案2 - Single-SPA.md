---
title: 前端微服务化解决方案2 - Single-SPA
categories: [Architecture]
tags: ['Micro-Frontend', 'Front-end-Architecture']
slug: 11052bf4
keywords: 微前端,前端微服务化,前端自动化,解决方案,前端难题,Single,SPA
date: 2018-09-02 22:17:36
---

# 技术选型

经过各种技术调研我们最终选择的方案是基于 [Single-SPA](https://single-spa.js.org/) 来实现我们的前端微服务化.

<video style="width:100%" src="https://static.alili.tech/data/video/Single-Spa%20Intro.mp4" controls="controls">
你的浏览器不支持视频
</video>

# Single-SPA

> 一个用于前端微服务化的 JavaScript 前端解决方案

使用 Single-SPA 之后,你可以这样做:

- (兼容各种技术栈)在同一个页面中使用多种技术框架(React, Vue, AngularJS, Angular, Ember 等任意技术框架),并且不需要刷新页面.
- (无需重构现有代码)使用新的技术框架编写代码,现有项目中的代码无需重构.
- (更优的性能)每个独立模块的代码可做到按需加载,不浪费额外资源.
- 每个独立模块可独立运行.

下面是一个微前端的演示页面 (你可能需要科学的上网)
[https://single-spa.surge.sh/](https://single-spa.surge.sh/)

> 以上是官方例子,但是官方例子中并没有解决一个问题.就是各种技术栈的路由实现方式大相径庭,如何做到路由之间的协同?
> 后续文章会讲解,如何解决这样的问题.

## 单体应用对比前端微服务化

### 普通的前端单体应用

![](https://static.alili.tech/images/micro/current.png)

### 微前端架构

![](https://static.alili.tech/images/micro/mf.png)

# Single-SPA 的简单用法

## 1.创建一个 HTML 文件

```html
<html>
  <body>
    <div id="root"></div>
    <script src="single-spa-config.js"></script>
  </body>
</html>
```

## 2.创建 single-spa-config.js 文件

```js
// single-spa-config.js
import * as singleSpa from "single-spa";

// 加载react 项目的入口js文件 (模块加载)
const loadingFunction = () => import("./react/app.js");

// 当url前缀为 /react的时候.返回 true (底层路由)
const activityFunction = (location) => location.pathname.startsWith("/react");

// 注册应用
singleSpa.registerApplication("react", loadingFunction, activityFunction);

//singleSpa 启动
singleSpa.start();
```

## 封装 React 项目的渲染出口文件

我们把渲染 react 的入口文件修改成这样,便可接入到 single-spa

```javascript
import React from 'react'
import ReactDOM from 'react-dom'
import singleSpaReact from 'single-spa-react'
import RootComponent from './root.component'

if (process.env.NODE_ENV === 'development') {
  // 开发环境直接渲染
  ReactDOM.render(<RootComponent />, document.getElementById('root'))
}

//创建生命周期实例
const reactLifecycles = singleSpaReact({
  React,
  ReactDOM,
  rootComponent: RootComponent
  domElementGetter: () => document.getElementById('root')
})

// 项目启动的钩子
export const bootstrap = [
  reactLifecycles.bootstrap,
]
// 项目启动后的钩子
export const mount = [
  reactLifecycles.mount,
]
// 项目卸载的钩子
export const unmount = [
  reactLifecycles.unmount,
]

```

> 这就是 single-spa 的简单使用,
> 当我们的浏览器 url 的前缀有`/react`的时候,程序就可以正常渲染这个应用
> 所以,所以我们这个 react 应用的所有路由前缀都得有`/react`
> 未完待续 ...

# 相关文章

[前端微服务化解决方案 1 - 思考](http://time-friend.com/archive/ea599f7c/)

[前端微服务化解决方案 2 - Single-SPA](http://time-friend.com/archive/11052bf4/)

[前端微服务化解决方案 3 - 模块加载器](http://time-friend.com/archive/1a60cede/)

[前端微服务化解决方案 4 - 消息总线](http://time-friend.com/archive/a9a1f81b/)

[前端微服务化解决方案 5 - 路由分发](http://time-friend.com/archive/5ff0b366/)

[前端微服务化解决方案 6 - 构建与部署](http://time-friend.com/archive/ffb0c5ab/)

[前端微服务化解决方案 7 - 静态数据共享](http://time-friend.com/archive/5e00e43d/)

[前端微服务化解决方案 8 - 二次构建](http://time-friend.com/archive/ce685b9f/)

# Demo

[前端微服务化 Micro Frontend Demo](http://microfrontend.alili.tech/)

[微前端模块加载器](https://github.com/Num142857/lotus-scaffold-micro-frontend-portal)

[微前端 Base App 示例源码](https://github.com/Num142857/microfrontend-base-demo)

[微前端子项目示例源码](https://github.com/Num142857/microfrontend-submodule-demo)
