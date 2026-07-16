---
title: 以太坊开发之Solidity初学者的编辑器 -- remix-ide
categories: [Blockchain]
tags: [Blockchain]
slug: ecce3d6
keywords: 区块链,以太坊,remix-ide,Solidity,truffle
date: 2018-04-20 19:33:33
---
在以太坊应用的开发中智能合约的开发是避不开的.
就目前来说,我发现的remix-ide是对新人最有好的开发工具了.
不需要其他任何的环境,就可以直接部署调试.
如果我发现了更加友好的,我会在以后的博客里推荐.

## 安装
remix就是一个普通的npm包
```
$ npm i remix-ide -g
```

## 启动
```
$ remix-ide
```
默认会启动本地8080端口,打开浏览器 `http://localhost:8080`

![](https://static.alili.tech/images/localhost_8080_.png)


## 使用
1. 首先我们要勾选自动编译
![](https://static.alili.tech/images/Jietu20180421-180045.jpg)

2. 切换到 Run ,环境选择 javascript VM
![](https://static.alili.tech/images/Jietu20180421-180308.jpg)

## 部署你的程序
点击create按钮,就可以部署你的智能合约了.
如下图,便是部署了智能合约的样子,因为每次部署都会消耗掉相应的余额.
所以这个用户的余额从刚才的 `100`以太币变成了现在的 `99.999999999...`
![](https://static.alili.tech/images/Jietu20180421-180547.jpg)

## 调试你的程序
部署完成之后,我们发现下面出现了一个有函数名称的按钮与输入框.
输入框内可填写该函数的参数.点击一下函数名,便可执行该函数了.
执行结果,会在中间下面的控制台显示.
![](https://static.alili.tech/images/Jietu20180421-182023.jpg)


点击一下控制台信息的detail按钮,便可看到函数详细的输出信息

![](https://static.alili.tech/images/Jietu20180421-182131.jpg)