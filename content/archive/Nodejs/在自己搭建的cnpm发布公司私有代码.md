---
title: 在自己搭建的cnpm发布公司私有代码
categories: [Backend]
tags: [Node.js]
slug: 7cb6734b
keywords:  Node.js,ts,私有,服务器,typescript,verdaccio,npm,浏览器
date: 2017-11-25 22:30:05
---

### 配置
1. 需要先将原先的 config/config.js 中添加一些配置属性：
``` javascript
    enablePrivate: false, // 任何人都可以发布包
    admins: {
      admin: 'test@company.com' // 管理员权限
    },
    scopes: ['@company'], // 私有包必须依附于 scope 下
```
### 重新启动 cnpm
进入cnpm目录
```
npm stop // 停止服务
npm start //启动服务
```
3.
在 package.json 文件中加入代码：
```
     "name": "@company/testjs", // 包名，之前必须加入 scope 名
```

### npm登陆
```
    npm login --registry=http://192.168.0.100:7001 // 注册之前的用户
    Username: admin // 管理员名
    Password: 1234 //你想要的密码
```
```
    npm publish --registry=http://192.168.80.130:7001
```
发布成功

### 安装刚刚发布的包
```
   npm install @company/test -registry=http://192.168.0.100:7001
```
