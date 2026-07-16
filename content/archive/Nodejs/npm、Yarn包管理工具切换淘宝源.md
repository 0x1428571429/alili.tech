---
title: npm、yarn包管理工具切换淘宝源
categories: [Backend]
tags: [Node.js]
slug: 99619c4e
keywords:  Node.js,npm,cnpm,yarn,淘宝源
date: 2017-07-01 20:32:05
---
因为一些特殊原因，npm、Yarn等包管理软件在国内下载总是有一点慢。
可以切换为淘宝源，直接从国内的服务器直接拉取。
这里做一个笔记：

## NPM
```
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```
如果不能开心的使用以上配置,可以尝试以下方法:
```
npm config set registry http://registry.cnpmjs.org
npm info underscore 
//（如果上面配置正确这个命令会有字符串response）
```

## yarn
```
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global
```

如果出现EACCES: permission denied这样的权限报错，
修复/usr/local目录的所有权：

```
sudo chown -R `whoami` /usr/local
```
