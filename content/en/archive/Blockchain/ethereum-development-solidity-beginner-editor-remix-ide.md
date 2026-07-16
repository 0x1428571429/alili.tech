---
title: Ethereum Development - Solidity Beginner Editor -- remix-ide
categories: [Blockchain]
tags: [Blockchain]
slug: ecce3d6
keywords: Blockchain,Ethereum,remix-ide,Solidity,truffle
date: 2018-04-20 19:33:33
---

In Ethereum application development, smart contract development is unavoidable.
Currently, remix-ide I found is the most beginner-friendly development tool.
Doesn't need any other environment, can directly deploy and debug.
If I find more friendly ones, I'll recommend in future blogs.

## Installation
remix is just an ordinary npm package
```
$ npm i remix-ide -g
```

## Startup
```
$ remix-ide
```
Default will start local port 8080, open browser `http://localhost:8080`

![](https://static.alili.tech/images/localhost_8080_.png)


## Usage
1. First we need to check auto compile
![](https://static.alili.tech/images/Jietu20180421-180045.jpg)

2. Switch to Run, environment select javascript VM
![](https://static.alili.tech/images/Jietu20180421-180308.jpg)

## Deploy Your Program
Click create button, can deploy your smart contract.
As shown below, is what deployed smart contract looks like, because each deployment consumes corresponding balance.
So this user's balance changed from previous `100` ether to now `99.999999999...`
![](https://static.alili.tech/images/Jietu20180421-180547.jpg)

## Debug Your Program
After deployment completes, we find below appeared buttons and input boxes with function names.
Input box can fill function parameters. Click function name, can execute the function.
Execution results will display in console below middle.
![](https://static.alili.tech/images/Jietu20180421-182023.jpg)


Click detail button of console information, can see function detailed output information

![](https://static.alili.tech/images/Jietu20180421-182131.jpg)

