---
title: 以太坊开发之一切从脚手架truffle开始
categories: [Blockchain]
tags: [Blockchain]
slug: bc28cb6c
keywords: 区块链,以太坊,remix-ide,Solidity,truffle
date: 2018-04-19 19:33:33
---

这个礼拜开始学习区块链开发,为了公司区块链项目开始之前有一定的知识储备.
在博客做一下知识复盘.


## truffle是什么
Truffle是针对基于以太坊的Solidity语言的一套开发框架。本身是基于JavaScript实现的。
虽然是使用我们熟悉的JavaScript实现,
但是truffle主要还只是一个编译与发布`智能合约`的一个工具(当然还有其他的功能).

## Solidity是什么
在区块链应用的开发中,Solidity语言你或许大致的可以理解为编写后台的一种语言. 在专业术语里,这种后台代码叫做 `智能合约`


## truffle的主要作用
Truffle在区块链应用的开发中,主要是提供两个重要的功能.
1. 编译智能合约
2. 发布智能合约


## 安装
跟普通的npm包一样,用npm直接安装
```bash
# 全局安装truffle
$ npm i truffle -g
```

## 初始化你的项目

```bash
# 我们新建一个目录 
$ mkdir myproject
$ cd myproject

#初始化
$ truffle init
# 执行命令后
Downloading...
Unpacking...
Setting up...
Unbox successful. Sweet!

Commands:
# truffle的其他操作 编译,发布,测试
  Compile:        truffle compile
  Migrate:        truffle migrate
  Test contracts: truffle test
```

完成之后你会看到以下目录
```
    contract/ - 智能合约Solidity代码
    migrations/ - 智能合约发布的脚本
    test/ - 测试文件
    truffle.js - Truffle的配置文件
```
下面是初始化自动生成的Solidity代码,以后一部分开发工作主要就是写这东西.
编译完成之后,再使用前端js调用这些方法.
```javascript
pragma solidity ^0.4.17;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
```

## 编译 Solidity 
```bash
$ truffle compile
```
执行命令后会多出一个 build文件夹
里面就是我们编译完成的Solidity代码,最终会是json形式.

```
build/
  contracts/
    Migrations.json
```
这个json文件就是我们以后经常能用到的`智能合约`了
在区块链的前端开发中,会在前端代码里引入这个json文件,并且调用里面的方法.