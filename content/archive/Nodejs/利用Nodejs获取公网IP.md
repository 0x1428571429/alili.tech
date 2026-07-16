---
title: 利用Node.js获取公网IP
categories: [Backend]
tags: [Node.js]
slug: cdd27771
keywords:  Node.js,公网,ip,网络
date: 2017-02-15 21:30:05
---

因为树莓派放在家里,因为运营商的关系,公网ip是一直会变的.
那我们要怎么样才能快捷的拿到当前网络的公网ip呢?

今天介绍一个小工具,可以简单的获取到公网ip.

[public-ip](https://www.npmjs.com/package/public-ip)

### 安装

```
npm install --save public-ip
```
<!-- more -->

### 使用

```
const publicIp = require('public-ip');
 
publicIp.v4().then(ip => {  
    console.log(ip);
    //=> '46.5.21.123' 
});
 
publicIp.v6().then(ip => {
    console.log(ip);
    //=> 'fe80::200:f8ff:fe21:67cf' 
});

```

#### 设置HTTPS
如果使用https,会基于[ icanhazip.com ](https://github.com/major/icanhaz) 服务来查询的.

相对来说会安全一些,但是也会稍微的慢一些.
```

publicIp.v4({
    https:true   //默认false
}).then(ip => {  
    console.log(ip);
    //=> '46.5.21.123' 
});

```

#### 设置超时时间

```

publicIp.v4({
    timeout:5000   //默认5000毫秒
}).then(ip => {  
    console.log(ip);
    //=> '46.5.21.123' 
});

```