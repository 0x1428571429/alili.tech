---
title: Node.js之http模块的get与post请求
categories: [Backend]
tags: [Node.js]
slug: 59cf5417
keywords:  Node.js,http,get,post,请求
date: 2017-02-16 20:32:05
---

在前端,经常要使用ajax获取,提交数据到服务端.
服务端当然也可以像另一个服务端发起同样的请求.

今天,说一下Node.js如何向另一个服务端发起请求.


## GET请求

写法还是相当简单,跟angular的$http.get有一点点的像.
``` javascript
    var http = require('http');
    http.get("http://baidu.com", function(response) {
    console.log(response)
    });
})
```
<!-- more -->
## POST请求
相对get,post的写法繁琐了很多.

虽然过程很清晰,但是对于写惯了各种前端框架封装的ajax后,还是难以接受的.
``` javascript
var http = require('http');
var querystring = require('querystring');
//json转换为字符串
var data = querystring.stringify({
    id:"1",
    text:"hello"
});
var options = {
    host: 'xxx.xxx.xxx',
    path:'/xxx/xxx/xxx/',
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': Buffer.byteLength(data)
    }
};

var req = http.request(options, function(res) {
    res.setEncoding('utf8');
    res.on('data', function (chunk) {  //拼接数据
        console.log("body: " + chunk);
    });
    res.on('end',function(chunk){
        console.log("body: " + chunk);
    })
});
req.write(data);
req.end();
```