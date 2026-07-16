---
title: npm, yarn Package Manager Switch to Taobao Registry
categories: [Backend]
tags: [Node.js]
slug: npm-yarn-switch-taobao-registry
keywords:  Node.js,npm,cnpm,yarn,Taobao Registry
date: 2017-07-01 20:32:05
---
Due to some special reasons, package management software like npm, Yarn always downloads a bit slow in China.
Can switch to Taobao registry, directly pull from domestic servers.
Here's a note:

## NPM
```
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```
If the above configuration doesn't work happily, can try the following method:
```
npm config set registry http://registry.cnpmjs.org
npm info underscore 
//(If above configuration is correct, this command will have string response)
```

## yarn
```
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global
```

If EACCES: permission denied permission error appears,
Fix /usr/local directory ownership:

```
sudo chown -R `whoami` /usr/local
```

