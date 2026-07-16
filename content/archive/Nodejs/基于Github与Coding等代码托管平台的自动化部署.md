---
title: 基于Github与Coding等代码托管平台的自动化部署
categories: [Backend]
tags: [Node.js]
slug: ff76a1bd
keywords:  Node.js,自动化,webhook,网络,github,coding
date: 2017-02-14 22:30:05
---

自从玩起了树莓派,每天都要经常把代码更新到树莓派上.

但是次数太频繁了,重复的事情就要做一遍又一遍.非常的浪费时间.

发现Github跟Codeing都有webhook功能,

于是我便有了一个想法:

想每次git push 更新代码的时候,
利用托管平台的webhook通知我的树莓派,
接收到通知后,自动更新托管平台的最新代码,并且自动重启.

这样不就节约很多时间了吗?
<!-- more -->
在npmjs.com上搜索有没有相关功能的模块,果然有:

[github-webhook-handler](https://www.npmjs.com/package/github-webhook-handler)

[coding-webhook-handler](https://www.npmjs.com/package/coding-webhook-handler)

接下来我们以coding为例,来写一个自动部署的小程序.

先准备一段树莓派接受到通知后,运行的一段sh代码

``` sh
#! /bin/bash
cd /home/pi/workspace/xxx  //打开项目所在的目录
git reset --hard origin/master
git clean -f
git pull origin master //拉取并且合并代码
cnpm install           //安装模块
pm2 reload app         //pm2 重新启动程序
```


下面是js代码

``` javascript
const http = require("http");
const spawn =require('child_process').spawn;
const createHandler = require("coding-webhook-handler");
const handler = createHandler({  //配置好coding的参数
    path: "/",
    token: "dsdsdsdsds"
});

http.createServer((req, res) => {  //开启一个服务,接收托管平台发送过来的通知
    handler(req, res, (err) => {
        res.statusCode = 404;
        res.end("no such location")
    })
    console.log("Hi!")
}).listen(7878);

const runCommand = (cmd, args, callback) => {  
    const child = spawn(cmd, args);  //运行sh代码

    let response = "";  //接收托管平台发送过来的内容
    child.stdout.on("data", buffer => response += buffer.toString());
    child.stdout.on("end", () => {
        callback(response)
    })
}

handler.on("error", (err) => {
    console.error('Error:', err.message) //输出错误信息
})


handler.on('*', function (event) {
    console.log(event.event)
    console.log(event.payload)
    console.log(event.protocol)
    console.log(event.host)
    console.log(event.url)
})


handler.on("push", (event) => { //push事件
    console.log('event:', event.event); 

    runCommand('sh', ['./auto_build.sh'], txt => {  //运行sh代码
        console.log(txt)   //输出托管平台发来的信息
    })
})

```






