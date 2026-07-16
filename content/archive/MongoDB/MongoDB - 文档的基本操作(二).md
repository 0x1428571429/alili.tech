---
title: MongoDB - 文档的基本操作 (二)
categories: [Database]
tags: [MongoDB]
slug: 311875a2
keywords: MongoDB,基本概念,数据库,Database,Collection,Table,关系型数据库
date: 2018-05-13 00:00:00
---

## 文档更新

> 语法: update(<filter>, <update>, <options>)

```bash
#更新rank字段
> db.posts.update({"title":"怪物猎人世界评测"}, {$set: {"rank": 10} });

# 更新整条数据为:{"rank": 99}
> db.posts.update({"title":"怪物猎人世界评测"}, {"rank": 99});

# 更新多条记录multi: true,如果为false,则是更新查询到的第一条记录
> db.posts.update({"tag":"it"}, {$set: {"rank": 60}}, {multi: true});



```

## 操作文档字段的函数

* $inc:递加
* $mul:相乘
* $rename:改名
* $set:新增or修改
* $unset:字段删除

```bash
# 字段值递增,结果为: 字段值 + 1
> db.posts.update({title:"怪物猎人世界评测"}, {$inc: {rank: 1}});

# 字段值相乘操作,结果为: 字段值 * 2
> db.posts.update({title:"怪物猎人世界评测"}, {$mul: {rank: 2}});

# 字段重命名
> db.posts.update({title:"怪物猎人世界评测"}, {$rename: {"rank": "score"}});

# 设置或者添加字段
> db.posts.update({title:"怪物猎人世界评测"}, {$set: {"istop": true}});

# 删除istop 字段
> db.posts.update({title:"怪物猎人世界评测"}, {$unset: {"istop": true}});

```

# 文档特殊更新
* upsert:有则更新，无则追加
* remove:条件删除数据

```bash
$ mongo
# 更新整条数据
> db.posts.update({title:"其实创造比大志好玩"}, {title:"其实创造比大志好玩", "rank":5,"tag":"game"});

#更新或者添加数据
> db.posts.update({title:"其实创造比大志好玩"}, {title:"其实创造比大志好玩", "rank":5,"tag":"game"}, {upsert:true});

# 删除数据
> db.posts.remove({title:"其实创造比大志好玩"});
```

## 索引
* getIndexes() 获取索引
* createIndex({...}, {...}) 添加索引
* dropIndex({...}) 删除索引 

```bash
# 获取索引
> db.posts.getIndexes();

# 创建rank为降序索引
> db.posts.createIndex({rank:-1});

# 删除索引
> db.posts.dropIndex({rank:-1});

# 创建一个升序索引,并且不能重复,后续title重复则添加失败
> db.posts.createIndex({title:1}, {unique:true});

```