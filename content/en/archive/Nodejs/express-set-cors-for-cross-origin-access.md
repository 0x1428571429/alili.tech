---
title: 'Express Set CORS to Allow Browsers to Cross-Origin Access Your Server'
categories: [Backend]
tags: [Node.js]
slug: e06698c9
keywords: Express,CORS,Cross-Origin,Server
date: 2017-02-18 21:32:05
---

Speaking of front-end cross-origin, it really makes many front-end developers nervous.

Cross-origin solutions are like eight immortals crossing the sea. Various black technologies, various black magic. Makes people stare in amazement. (If you don't understand, you can search)

But none are perfect solutions, all can do this but not that.

What we're talking about today is the ultimate cross-origin solution (IE8 and lower versions of IE browsers don't support)

## Cross-Origin Resource Sharing (CORS);

```javascript
var express = require('express');  
var app = express();  
// Set CORS
app.all('*', function(req, res, next) {  
    res.header("Access-Control-Allow-Origin", "*");  
    // Second parameter is an asterisk, meaning pages from any domain can request this server;
    // Set specific domain:
    //res.header("Access-Control-Allow-Origin", "http://baidu.com");
    // This way, web pages under baidu.com can ajax request your server


    res.header("Access-Control-Allow-Headers", "X-Requested-With");  


    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");  
    // Second parameter is which HTTP request methods the other party can use to request your server, set according to your situation


    res.header("X-Powered-By",' 3.2.1')  
    res.header("Content-Type", "application/json;charset=utf-8");  
    next();  
});  
  
app.get('/', function(req, res) {  
    res.send("You have successfully accessed this server");  
});  
  
app.listen(3000);
```

