---
title: Get Public IP with Node.js
categories: [Backend]
tags: [Node.js]
slug: cdd27771
keywords: Node.js,Public,ip,Network
date: 2017-02-15 21:30:05
---

Because Raspberry Pi is placed at home, due to ISP reasons, public IP keeps changing.
How can we quickly get the current network's public IP?

Today introduce a small tool that can simply get public IP.

[public-ip](https://www.npmjs.com/package/public-ip)

### Installation

```
npm install --save public-ip
```
<!-- more -->

### Usage

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

#### Set HTTPS
If using https, it will query based on [icanhazip.com](https://github.com/major/icanhaz) service.

Relatively safer, but also slightly slower.
```

publicIp.v4({
    https:true   // Default false
}).then(ip => {  
    console.log(ip);
    //=> '46.5.21.123' 
});

```

#### Set Timeout

```

publicIp.v4({
    timeout:5000   // Default 5000 milliseconds
}).then(ip => {  
    console.log(ip);
    //=> '46.5.21.123' 
});

```

