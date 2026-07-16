---
title: Enable Gzip Mode for Express, Egg.js, Koa.js
categories: [Backend]
tags: [Node.js]
slug: enable-gzip-express-egg-koa
keywords: Enable,Express,Egg.js,Koa.js,Gzip,nodejs,http
date: 2017-12-13 20:32:05
---
To reduce download size of APIs and static files, we can enable Gzip when server resources are sufficient.

### Express
Express version below 4.0
```javascript
var express = require('express');
var app = express();
app.use(express.compress()); //Mainly this line
```

Express version 4.0 and above (including 4.0)
``` javascript
var compression = require('compression');
var express = require('express');
var app = express();
app.use(compression());
```

### Egg.js
``` javascript
// app/middleware/compress.js
// koa-compress exposed interface (`(options) => middleware`) matches framework's middleware requirements
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

