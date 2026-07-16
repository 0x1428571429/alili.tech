---
title: Egg.js 如何支持单页面应用
categories: [Backend]
tags: [Node.js]
slug: 524de824
keywords: Eggjs,Node.js,单页面应用
date: 2017-12-01 22:30:05
---

 1. 在config/plugin.js 启用ejs //其他的模板引擎也行
``` javascript
exports.ejs = {
  enable: true,
  package: 'egg-view-ejs',
};
```

2. 配置静态目录
``` javascript
//config/config.{env}.js

    config.static = {
      prefix: '/',
      dir: path.join(appInfo.baseDir, 'app/view/')
    }
```

3. 模板配置
``` javascript
//config/config.{env}.js

 config.view = {
      defaultExt: '.html',
      mapping: {
        '.ejs': 'ejs',
        '.html': 'ejs',
      }
    }
```

4. 配置根目录路由映射
``` javascript
// app/router.js

module.exports = app => {
  app.router.get('/', app.controller.home.index);
}

```
5. 配置路由相应的控制器
``` javascript
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

> 完成以上配置，便可以与单页面应用作结合了