---
title: MongoDB - 数据库与集合的基本操作
categories: [Database]
tags: [MongoDB]
slug: 3a26a4b
keywords: MongoDB,基本概念,数据库,Database,Collection,Table,关系型数据库
date: 2018-05-11 00:00:00
---

数据库基本操作
=============

```bash
# 进入命令行
$ mongo

#帮助
> help

#退出
> exit

#显示所有数据库
> show dbs;

#进入或者创建集合
> use aliliblog;

#查看当前数据库状态
> db.stats();

# 删除数据库
> db.dropDatabase();
```

操作集合（Collection）
=====================

~~~bash


# 查看集合
> show collections;

# 创建集合
> db.createCollection("users");

# 集合重命名
> db.users.renameCollection("staff"); // users -> staff

# 集合删除
> db.staff.drop();
~~~