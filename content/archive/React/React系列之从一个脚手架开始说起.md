---
title: 'React系列之从一个脚手架开始说起:create-react-app'
categories: [Frontend]
tags: [React]
slug: 7a6daf6e
keywords: react,脚手架,create-react-app
date: 2017-07-12 19:33:33
---

React的全家桶实在太过于庞大。如果初学者想直接品味React的魅力，这里介绍一个官方的脚手架。使用方法特别简单。



## create-react-app

### 大概使用方法

安装
```
npm install -g create-react-app
```

创建一个app
```
create-react-app my-app
cd my-app/
```


文件结构：

```
my-app
├── README.md
├── node_modules
├── package.json
├── .gitignore
├── public
│   └── favicon.ico
│   └── index.html
│   └── manifest.json
└── src
    └── App.css
    └── App.js
    └── App.test.js
    └── index.css
    └── index.js
    └── logo.svg
    └── registerServiceWorker.js
```


启动应用：

```
npm start
```

用浏览器打开 http://localhost:3000/ 就可以直接看到你的应用了。

![](https://camo.githubusercontent.com/506a5a0a33aebed2bf0d24d3999af7f582b31808/687474703a2f2f692e696d6775722e636f6d2f616d794e66434e2e706e67)

如果你想打包你的应用：

```
npm run build
```


## 特点

- 不需要配置；
- 对 React, JSX, ES6 和 Flow 可以直接编译；
- 开发服务器；
- 浏览器热加载的功能；
- JavaScript 文件中可以直接 import CSS 和图片；
- 自动处理 CSS 的兼容问题，无需添加 -webkit 前缀；
- 集成好了编译命令，编译后直接发布成产品，包含 sourcemaps。




哎哟，路边又捡了一个叫 create-react-native-app 的脚手架:

[create-react-native-app](https://github.com/react-community/create-react-native-app/)