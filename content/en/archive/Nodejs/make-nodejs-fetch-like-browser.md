---
title: Make Node.js Fetch Like Browser
categories: [Backend]
tags: [Node.js]
slug: 5bc12a97
keywords: Fetch,nodejs
date: 2017-02-17 20:32:05
---

Previous article briefly introduced Node.js http module's get and post methods,
but because post configuration is still quite cumbersome, today recommend a module:

[node-fetch](https://www.npmjs.com/package/node-fetch)

## Installation

```
npm install node-fetch --save
```

<!-- more -->
## Usage

```javascript
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
 


// When network error occurs
fetch('http://domain.invalid/')
    .catch(function(err) {
        console.log(err);
    });
 


// stream
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
 


// POST request  
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
 



// post form data
 
var FormData = require('form-data');
var form = new FormData();
form.append('a', 1);
fetch('http://httpbin.org/post', { method: 'POST', body: form })
    .then(function(res) {
        return res.json();
    }).then(function(json) {
        console.log(json);
    });
 




// post form data and modify header 
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

Returns a Promise object

### About url
Must be an absolute path, e.g.: http://www.baidu.com/

