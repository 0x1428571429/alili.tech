---
title: 'Express设置CORS,让浏览器可以跨域访问你的服务器'
categories: [Backend]
tags: [Node.js]
slug: e06698c9
keywords: Express,CORS,跨域,服务器
date: 2017-02-18 21:32:05
---
说到前端跨域,确实让很多前端宝宝们捏了一把汗.

跨域的解决方法可谓是八仙过海.各种黑科技,各种黑魔法.让人看的目瞪口呆.(不了解的,可以去搜)

但是都没有相当完美的解决方案,都是可以这样却不能那样.

今天要说的就是目前跨域的终极解决方案(IE8以及更低版本的IE浏览器不支持)

## Cross-Origin Resource Sharing (简称 CORS);


``` javascript
var express = require('express');  
var app = express();  
//设置CORS
app.all('*', function(req, res, next) {  
    res.header("Access-Control-Allow-Origin", "*");  
    //第二个参数,是一个*号,表示任意域名下的页面都可以都可以请求请求这台服务器;
    //设置指定域名:
    //res.header("Access-Control-Allow-Origin", "http://baidu.com");
    //这样,baidu.com下面的网页,就可以ajax请求你的服务器了


    res.header("Access-Control-Allow-Headers", "X-Requested-With");  


    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");  
    //第二个参数,为对方可以以哪种HTTP请求方式请求你的服务器,根据自己的情况酌情设置


    res.header("X-Powered-By",' 3.2.1')  
    res.header("Content-Type", "application/json;charset=utf-8");  
    next();  
});  
  
app.get('/', function(req, res) {  
    res.send("你已经成功访问该服务器");  
});  
  
app.listen(3000);
```