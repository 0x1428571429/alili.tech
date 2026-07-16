---
title: Node.js http Module GET and POST Requests
categories: [Backend]
tags: [Node.js]
slug: 59cf5417
keywords: Node.js,http,get,post,Request
date: 2017-02-16 20:32:05
---

In front-end, we often need to use ajax to get and submit data to the server.
The server can also initiate the same request to another server.

Today, let's talk about how Node.js initiates requests to another server.

## GET Request

Writing is quite simple, a bit similar to angular's $http.get.
```javascript
    var http = require('http');
    http.get("http://baidu.com", function(response) {
    console.log(response)
    });
})
```
<!-- more -->
## POST Request
Compared to get, post writing is much more cumbersome.

Although the process is clear, after getting used to various front-end framework encapsulated ajax, it's still hard to accept.
```javascript
var http = require('http');
var querystring = require('querystring');
// Convert json to string
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
    res.on('data', function (chunk) {  // Concatenate data
        console.log("body: " + chunk);
    });
    res.on('end',function(chunk){
        console.log("body: " + chunk);
    })
});
req.write(data);
req.end();
```

