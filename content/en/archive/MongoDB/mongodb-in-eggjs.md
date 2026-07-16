---
title: MongoDB - Using MongoDB in Egg
categories: [Database]
tags: [MongoDB]
slug: c165a1d9
keywords: MongoDB,eggjs
date: 2018-05-18 00:00:00
---

 MongoDB official provides node database operation driver and API: [node-mongodb-native](https://github.com/mongodb/node-mongodb-native)


In egg community there's also an egg plugin based on this plugin secondary encapsulation [egg-mongo-native](https://github.com/brickyang/egg-mongo-native)

Made some secondary encapsulation of some methods, can also call original methods.

## Configuration
Official documentation also has related configuration instructions, but I encountered some problems in actual use.
Below I provide correct configuration method for everyone to use. Other related knowledge please refer to this plugin's official documentation.

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

## Enable Plugin

```js
// config/plugin.js

const plugin = {
  mongo :{
    enable: true,
    package: 'egg-mongo-native',
  }
};
```

Must be same as above configuration to correctly use this plugin.

Other complex configurations please refer to this plugin's official documentation.
[egg-mongo-native](https://github.com/brickyang/egg-mongo-native)

