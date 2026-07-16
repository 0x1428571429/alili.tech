---
title: 'Apache,Nginx,Express,Egg.js 支持前端HTML5 History 模式'
categories: [Backend]
tags: [Node.js]
slug: 6eff5ac9
keywords: Apache,Nginx,Express,Egg.js,前端HTML5,History,模式
date: 2017-12-02 22:30:05
---
当你使用 history 模式时，URL 就像正常的 url，例如 http://xxx.com/user/id。

想要完美支持这种模式，还需要后台配置支持。当应用是个单页客户端应用，如果后台没有正确的配置，当用户在浏览器直接访问 http://xxx.com/user/id 就会返回 404。

后端支持案例：
### Apache
``` XML
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /index.html [L]
</IfModule>
```

### nginx
```
location / {
  try_files $uri $uri/ /index.html;
}
```

### Node.js (Express)
如果是Express 可以使用connect-history-api-fallback
[https://github.com/bripkens/connect-history-api-fallback]()


### Egg.js
```javascript
// app/middleware/history_fallback.js
module.exports = () => {
  return async function historyFallback(ctx, next) {
    await next();
    if (ctx.status === 404 && !ctx.body) {
      if (ctx.acceptJSON) {
        ctx.body = { error: 'Not Found' };
      } else {
        ctx.render('index')
      }
    }
  };
};
```

```javascript
// config/config.default.js
module.exports = {
  middleware: [ 'historyFallback' ],
};
```
