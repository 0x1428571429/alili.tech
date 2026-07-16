---
title: MongoDB - 文档的基本操作 (一)
categories: [Database]
tags: [MongoDB]
slug: 9e29eec0
keywords: MongoDB,基本概念,数据库,Database,Collection,Table,关系型数据库
date: 2018-05-12 00:00:00
---

## 文档增删

~~~bash
# 创建集合
> db.createCollection("posts");

# 插入一条数据
> db.posts.insert(
... {
...     title: "我的第一篇博客",
...     content: "已经开始写博客了，太激动了。"
... }
... );

# 查询数据
> db.posts.find();

# 插入另一条数据
> db.posts.insert(
... {
...     title: "我的第二篇博客",
...     content: "写点什么好呢？",
...     tag: ["未分类"]
... }
... );



# 使用js for 来循环插入数据
> for(var i = 3; i <=10; i++ ) {
...     db.posts.insert({
...         title: "我的第" + i + "篇博客"
...     });
... }

# 查询数据
> db.posts.find();

# 查看数据count
> db.posts.count();

# 删除集合所有数据
> db.posts.remove({});

> db.posts.find();
~~~

## 文档带条件查询

```bash
# 查询tag 为game的数据
> db.posts.find({"tag": "game"});

# 查询 rank大于或等于4的数据
> db.posts.find({"rank": {$gte: 4}});

# 查询 rank大于或等于4的数据
> db.posts.find({"rank": {$gt: 4}});

# 查询 rank小于或等于4的数据
> db.posts.find({"rank": {$lte: 4}});

# 查询 rank小于4的数据
> db.posts.find({"rank": {$lt: 4}});

# 正则查询
> db.posts.find({"title": /u/});

# 多条件查询
> db.posts.find({"title": /u/, "rank":{$gte:5} });

# $or 或条件查询
> db.posts.find({$or: [{"title": /u/}, {"rank":{$gte:4}}] });

# $in 包含, 查询rank中又3,4的数据
> db.posts.find({"rank": {$in: [3,4]} });

# 判断是否存在
> db.posts.find({"istop": {$exists: true} });

# 查询文章中有三个标签的数据
> db.posts.find({'tag': {$size: 3}});

# 获取所有的tag类型,distinct作用是获取集合中指定字段的不重复值，并以数组的形式返回
> db.posts.distinct("tag");

```

### MongoDB 与 RDBMS Where 语句比较
|操作	|格式	|范例	|RDBMS中的类似语句
| -------------    |-------------|-------------|-------------|
|等于	|{<key>:<value>}	|db.col.find({"by":"test"}).pretty()	|where by = 'test'
|小于	|{<key>:{$lt:<value%}}	|db.col.find({"likes":{$lt:50}}).pretty()	|where likes < 50
|小于或等于	|{<key>:{$lte:<value%}}	|db.col.find({"likes":{$lte:50}}).pretty()	|where likes <= 50
|大于	|{<key>:{$gt:<value%}}	|db.col.find({"likes":{$gt:50}}).pretty()	|where likes > 50
|大于或等于	|{<key>:{$gte:<value%}}	|db.col.find({"likes":{$gte:50}}).pretty()	|where likes >= 50
|不等于	|{<key>:{$ne:<value%}}	|db.col.find({"likes":{$ne:50}}).pretty()	|where likes != 50


## 指定抽出字段
> 语法: db.[collection_name].find({}, {field1: true, field2: 1})

```bash
# true与1为返回, false与0为不返回
# 查出所有数据,返回指定个数的数据
> db.posts.find({}, {title:true, rank:1});
# _id 不带
> db.posts.find({}, {title:true, rank:1, _id:0});

```

## 文档的方法
* sort() 排序
* limit() 指定返回数量
* skip() 跳过n条取值

```bash
> use aliliblog;

# 升序排序
> db.posts.find({}, {_id:0}).sort({rank:1}); 

# 降序排序
> db.posts.find({}, {_id:0}).sort({rank:-1});

# 取出三条
> db.posts.find({}, {_id:0}).limit(3);

# 降序排序 抽出前三条
> db.posts.find({}, {_id:0}).sort({rank:-1}).limit(3);

# 抽出第一条
> db.posts.findOne({}, {_id:0});


# 跳过前三条,取456条,可以轻松做翻页
> db.posts.find({}, {_id:0}).skip(3).limit(3);
```