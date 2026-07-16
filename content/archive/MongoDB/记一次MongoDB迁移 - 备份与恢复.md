---
title: 记一次MongoDB迁移 - 备份与恢复
categories: [Database]
tags: [MongoDB]
slug: 7815p445rtf
keywords: MongoDB,基本概念,数据库,Database,Collection,Table,关系型数据库
date: 2019-03-27 00:00:00
---

最近对自己的的爬虫数据库做了一次迁移,所以在这里记录一下mongodb的备份与恢复

## MongoDB数据备份

```bash
mongodump -h dbhost -d dbname -o dbdirectory
```
* -h： MongDB所在服务器地址，例如：127.0.0.1，如果没有改的话一般是：127.0.0.1:27017

*  -d： 需要备份的数据库名字，例如：test

*  -o： 备份的数据存放位置，例如：/home/root/xxx，



## MongoDB数据恢复
```bash
mongorestore -h <hostname><:port> -d dbname <path>
```

* --host <:port>, -h <:port>： MongoDB所在服务器地址，默认为： localhost:27017

* --db , -d ： 需要备份的数据库名字，例如：test

* --drop： 先删除现有的数据,再恢复数据

* <path>： 指定备份文件的目录


* --dir： 指定备份文件的目录,不能同时指定 <path> 和 --dir 选项。




