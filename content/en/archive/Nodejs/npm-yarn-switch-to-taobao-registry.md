---
title: npm, Yarn Package Management Tools Switch to Taobao Registry
categories: [Backend]
tags: [Node.js]
slug: 99619c4e
keywords: Node.js,npm,cnpm,yarn,Taobao Registry
date: 2017-07-01 20:32:05
---

Due to some special reasons, npm, Yarn and other package management software downloads are always a bit slow in China.
You can switch to Taobao registry to directly pull from domestic servers.
Here's a note:

## NPM
```
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```
If you can't happily use the above configuration, you can try the following method:
```
npm config set registry http://registry.cnpmjs.org
npm info underscore 
// (If the above configuration is correct, this command will have a string response)
```

## yarn
```
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global
```

If you encounter EACCES: permission denied permission error,
Fix /usr/local directory ownership:

```
sudo chown -R `whoami` /usr/local
```

