---
title: 'Apache, Nginx, Express, Egg.js Support Frontend HTML5 History Mode'
categories: [Backend]
tags: [Node.js]
slug: 6eff5ac9
keywords: Apache,Nginx,Express,Egg.js,Frontend HTML5,History,Mode
date: 2017-12-02 22:30:05
---

When you use history mode, URLs look like normal URLs, e.g. http://xxx.com/user/id.

To perfectly support this mode, backend configuration support is also needed. When the application is a single-page client application, if the backend is not correctly configured, when users directly access http://xxx.com/user/id in the browser, it will return 404.

Backend support examples:
### Apache
```XML
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
If using Express, you can use connect-history-api-fallback
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

