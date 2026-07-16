---
title: 让Node.js像浏览器一样Fetch你想要的
categories: [Backend]
tags: [Node.js]
slug: 5bc12a97
keywords: Fetch,nodejs
date: 2017-02-17 20:32:05
---

上一篇简单的介绍了Node.js http模块的get与post方式,
但是因为post的配置还是比较繁琐,今天推荐一个模块:

[node-fetch](https://www.npmjs.com/package/node-fetch)

## 安装

```
npm install node-fetch --save
```

<!-- more -->
## 使用

``` javascript
var fetch = require('node-fetch');

// HTML 
fetch('https://github.com/')
    .then(function(res) {
        return res.text();
    }).then(function(body) {
        console.log(body);
    });
 


// JSON  
fetch('https://api.github.com/users/github')
    .then(function(res) {
        return res.json();
    }).then(function(json) {
        console.log(json);
    });
 


// 当网络发生错误
fetch('http://domain.invalid/')
    .catch(function(err) {
        console.log(err);
    });
 


// stream 流
var fs = require("fs")
fetch('https://assets-cdn.github.com/images/modules/logos_page/Octocat.png')
    .then(function(res) {
        var dest = fs.createWriteStream('./octocat.png');
        res.body.pipe(dest);
    });
 


// buffer  
var fileType = require('file-type');
fetch('https://assets-cdn.github.com/images/modules/logos_page/Octocat.png')
    .then(function(res) {
        return res.buffer();
    }).then(function(buffer) {
        fileType(buffer);
    });
 

// meta  
fetch('https://github.com/')
    .then(function(res) {
        console.log(res.ok);
        console.log(res.status);
        console.log(res.statusText);
        console.log(res.headers.raw());
        console.log(res.headers.get('content-type'));
    });
 


// POST请求  
fetch('http://httpbin.org/post', { method: 'POST', body: 'a=1' })
    .then(function(res) {
        return res.json();
    }).then(function(json) {
        console.log(json);
    });
 


// post with stream from resumer  
var resumer = require('resumer');
var stream = resumer().queue('a=1').end();
fetch('http://httpbin.org/post', { method: 'POST', body: stream })
    .then(function(res) {
        return res.json();
    }).then(function(json) {
        console.log(json);
    });
 



// post 表单数据
 
var FormData = require('form-data');
var form = new FormData();
form.append('a', 1);
fetch('http://httpbin.org/post', { method: 'POST', body: form })
    .then(function(res) {
        return res.json();
    }).then(function(json) {
        console.log(json);
    });
 




// post 表单数据并且修改header 
var FormData = require('form-data');
var form = new FormData();
form.append('a', 1);
fetch('http://httpbin.org/post', { method: 'POST', body: form, headers: form.getHeaders() })
    .then(function(res) {
        return res.json();
    }).then(function(json) {
        console.log(json);
    });
 


// node 0.12+, yield with co  
var co = require('co');
co(function *() {
    var res = yield fetch('https://api.github.com/users/github');
    var json = yield res.json();
    console.log(res);
});

```


## API 

### fetch(url, options)

返回一个 Promise 对象

### 关于 url
必须是一个绝对路径, 例如: http://www.baidu.com/


