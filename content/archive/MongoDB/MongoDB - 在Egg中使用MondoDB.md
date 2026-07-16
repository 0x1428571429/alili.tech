---
title: MongoDB - 在Egg中使用MondoDB
categories: [Database]
tags: [MongoDB]
slug: c165a1d9
keywords: MongoDB,eggjs
date: 2018-05-18 00:00:00
---

 MongoDB官方有提供node操作数据库的 driver 及 API : [node-mongodb-native](https://github.com/mongodb/node-mongodb-native)


在egg社区也有基于该插件二次封装的egg插件 [egg-mongo-native](https://github.com/brickyang/egg-mongo-native)

对一些方法做了一些二次封装,也可以调用原版的方法.

## 配置
官方文档也有相关的配置说明,但是我在实际使用中碰到了一些问题.
下面我给出正确的配置方法,供大家使用.其他相关知识请参照该插件都官方文档.

```js
// {app_root}/config/config.default.js
export default (appInfo) => {
  const config = {};
  config.mongo = {
    client: {
      host: '127.0.0.1',
      port: '27017',
      name: 'dandelion'
    },
  }
  return config;
};

```

## 开启插件

```js
// config/plugin.js

const plugin = {
  mongo :{
    enable: true,
    package: 'egg-mongo-native',
  }
};
```

要跟以上配置一样,才能正确使用该插件.

其他复杂配置请参照该插件的官方文档.
[egg-mongo-native](https://github.com/brickyang/egg-mongo-native)