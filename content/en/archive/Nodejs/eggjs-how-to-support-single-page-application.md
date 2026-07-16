---
title: How Egg.js Supports Single Page Application
categories: [Backend]
tags: [Node.js]
slug: 524de824
keywords: Eggjs,Node.js,Single Page Application
date: 2017-12-01 22:30:05
---

 1. Enable ejs in config/plugin.js // Other template engines also work
```javascript
exports.ejs = {
  enable: true,
  package: 'egg-view-ejs',
};
```

2. Configure static directory
```javascript
//config/config.{env}.js

    config.static = {
      prefix: '/',
      dir: path.join(appInfo.baseDir, 'app/view/')
    }
```

3. Template configuration
```javascript
//config/config.{env}.js

 config.view = {
      defaultExt: '.html',
      mapping: {
        '.ejs': 'ejs',
        '.html': 'ejs',
      }
    }
```

4. Configure root directory route mapping
```javascript
// app/router.js

module.exports = app => {
  app.router.get('/', app.controller.home.index);
}

```
5. Configure route corresponding controller
```javascript
// app/controller/home.js

const { Controller } = require('egg');
class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    // render index.html
    await ctx.render('index');
  }
}
module.exports = HomeController;

```

> After completing the above configuration, you can combine with single page application

