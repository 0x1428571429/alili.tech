---
title: 使用verdaccio搭建更加简单的私有npm服务器
categories: [Backend]
tags: [Node.js]
slug: '9713e794'
keywords:  Node.js,ts,私有,服务器,typescript,verdaccio,npm,浏览器
date: 2018-04-10 22:30:05
---
 cnpm.org这种私有npm服务器搭建已经很简单了,
但是相对于verdaccio的简单那是完全没有办法比的.
因为verdaccio实在是太简单了.

### 介绍
verdaccio是一个轻量级的私有NPM的Registry（从 Sinopia fork过来的，sinopia最后一次更新是在几年前了）。最开始是打算使用cnpmjs这个来搭建私有的npm仓库但是搭建完成之后存在一些问题，所以使用了Sinopia;

接下来我将简单介绍一下 verdaccio的使用.

### 在你的服务器安装verdaccio
```bash
$ npm i verdaccio -g
```

### 启动

```bash
#直接输入 verdaccio 命令
$ verdaccio

// 如果启动成功会显示以下信息
 Verdaccio doesn‘t need superuser privileges. Don‘t run it und
 warn --- config file  - /root/.config/verdaccio/config.yaml
 warn --- http address - http://localhost:4873/ - verdaccio/
```

我们也可以用pm2启动 (也是我选择使用的方法)
```bash
$ pm2 start verdaccio
```


### 配置
系统默认的配置文件在 `/root/.config/verdaccio/config.yaml`
下面是我现在的配置,大家可以简单的参考一下.
基本上没有改什么.
```yaml
#
# This is the default config file. It allows all users to do anything,
# so don't use it on production systems.
#
# Look here for more config file examples:
# https://github.com/verdaccio/verdaccio/tree/master/conf
#

#这里是你默认存储的包的位置,我根据我自己的情况做了相应修改
#storage: /root/.local/share/verdaccio/storage
storage: /data01/verdaccio/storage

#端口号,地址要这样设置外面才好访问
listen: 0.0.0.0:4873
auth:
  htpasswd:
    file: ./htpasswd
    # Maximum amount of users allowed to register, defaults to "+inf".
    # You can set this to -1 to disable registration.
    #max_users: 1000

#npm设置我直接代理了淘宝的源
#这样我就不需要再去主动同步包了,本地请求不到的直接请求淘宝源
uplinks:
  npmjs:
    url: https://registry.npm.taobao.org

packages:
  '@*/*':
    # scoped packages
    access: $all
    publish: $authenticated
    proxy: npmjs

  '**':
    # allow all users (including non-authenticated users) to read and
    # publish all packages
    #
    # you can specify usernames/groupnames (depending on your auth plugin)
    # and three keywords: "$all", "$anonymous", "$authenticated"
    access: $all

    # allow all known users to publish packages
    # (anyone can register by default, remember?)
    publish: $authenticated

    # if package is not available locally, proxy requests to 'npmjs' registry
    proxy: npmjs

# log settings
logs:
  - {type: stdout, format: pretty, level: http}
  #- {type: file, path: verdaccio.log, level: info}
```