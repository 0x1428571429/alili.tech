---
title: 在Webpack与Systemjs中构建你的Single-SPA微前端应用
categories: [Architecture]
tags: ['Micro-Frontend']
keywords: '微前端,前端微服务化,前端自动化,解决方案,前端难题,Single,SPA'
slug: 1a4f2dcf
date: 2018-10-31 01:00:00
---

这里给大家介绍一下基于Single-SPA编写的微前端应用在各种当下流行的构建工具中的使用方法.

# Webpack 2+
在Webpack 2+版本中,支持import（）做代码分片. 在其他项目中 webpack2+的使用已经相当的广泛,这里就不做过多赘述.

```js
import {registerApplication} from 'single-spa';

registerApplication('app-name', () => import('./my-app.js'), activeWhen);

function activeWhen() {
    return window.location.pathname.indexOf('/my-app') === 0;
}

```

# SystemJS
在之前我们的项目中使用的就是SystemJS,方便部署应用后的二次构建.用起来页非常的方便.

```js
import {registerApplication} from 'single-spa';

// Import the registered application with a SystemJS.import call
registerApplication('app-name-1', () => SystemJS.import('./my-app.js'), activeWhen);

// Alternatively, use the more out-of-date System.import (instead of SystemJS.import)
registerApplication('app-name-2', () => System.import('./my-other-app.js'), activeWhen);

function activeWhen() {
    return window.location.pathname.indexOf('/my-app') === 0;
}
```


# Webpack 1

Webpack 1 不支持基于Promise的代码拆分.

想要按需加载,就必须在使用中用Promise二次的包装一次require.ensure

```js
import {registerApplication} from 'single-spa';

 //app1 不使用按需加载与代码拆分 :(
import app1 from './app1';

// 不用按需加载与代码拆分,直接注册 :(
registerApplication('app-1', () => Promise.resolve(app1), activeWhen);


// app-2使用依赖加载方法
registerApplication('app-2', app2InPromise, activeWhen);

// 重新包装一次
function app2InPromise() {
    return new Promise((resolve, reject) => {
        require.ensure(['./app-2.js'], require => {
            try {
                resolve(require('./app-2.js'));
            } catch(err) {
                reject(err);
            }
        });
    });
}

function activeWhen() {
    return window.location.pathname.indexOf('/my-app') === 0;
}
```