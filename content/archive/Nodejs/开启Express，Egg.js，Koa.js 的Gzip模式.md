---
title: 开启Express，Egg.js，Koa.js 的Gzip模式
categories: [Backend]
tags: [Node.js]
slug: a8ce80b
keywords: 开启,Express,Egg.js,Koa.js,Gzip,nodejs,http
date: 2017-12-13 20:32:05
---
为了缩小接口与静态文件的下载体积，在服务器资源可观的情况下我们可以开启Gzip。

### Express
Express 4.0以下版本
```javascript
var express = require('express');
var app = express();
app.use(express.compress()); //主要是这句
```

Express 4.0以上版本(包含4.0)
``` javascript
var compression = require('compression');
var express = require('express');
var app = express();
app.use(compression());
```

### Egg.js
``` javascript
// app/middleware/compress.js
// koa-compress 暴露的接口(`(options) => middleware`)和框架对中间件要求一致
module.exports = require('koa-compress')
```

``` javascript
// config/config.default.js
module.exports = {
  middleware: [ 'compress' ],
  compress: {
    threshold: 2048,
  },
};
```

### Koa.js
``` javascript
const koa = require('koa');
const compress = require('koa-compress');

const app = koa();

const options = { threshold: 2048 };
app.use(compress(options));
```