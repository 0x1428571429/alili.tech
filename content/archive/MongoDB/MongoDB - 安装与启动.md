---
title: MongoDB - 安装与启动
categories: [Database]
tags: [MongoDB]
slug: f82d8042
keywords: MongoDB,基本概念,数据库,Database,Collection,Table,关系型数据库
date: 2018-05-09 00:00:00
---

什么是MongoDB？
==============

MongoDB是一个面向文档的免费数据库，多用于数据采集和分散处理(Map/Reduce)，特别是在大数据处理方面比较擅长。

MongoDB 是一个基于分布式文件存储的数据库。由 C++ 语言编写。旨在为 WEB 应用提供可扩展的高性能数据存储解决方案。

MongoDB 是一个介于关系数据库和非关系数据库之间的产品，是非关系数据库当中功能最丰富，最像关系数据库的。


## macOS OS安装与启动

### 安装
最简单的是通过 brew 安装
```bash

brew update

# 就这样mac上就安装好了
brew install mongodb

# 如果你需要最新的开发版本
brew install mongodb --devel
```

### 启动
```bash
#新建默认数据文件夹
mkdir -p /data/db

# 直接启动
mongod

# 指定路径启动
mongod --dbpath <path to data directory>

# 连接默认端口数据库
mongo

#指定端口连接数据库
mongo --host 127.0.0.1:27017
```

## centOS安装与启动

### 安装

新建一个文件 `/etc/yum.repos.d/mongodb-org-4.0.repo `
```bash
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
```


通过yum安装数据库
```bash
# 就这么简单就安装成功了
sudo yum install -y mongodb-org
```
### 启动

启动
```bash
sudo service mongod start
```

验证服务是否启动
```bash
sudo chkconfig mongod on
```

停止
```bash
sudo service mongod stop
```

重启
```bash
sudo service mongod restart
```

## 其他
以一个前端的方式来启动数据库
```bash
pm2 start mongo
```