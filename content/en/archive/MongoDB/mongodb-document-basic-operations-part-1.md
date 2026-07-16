---
title: MongoDB - Document Basic Operations (Part 1)
categories: [Database]
tags: [MongoDB]
slug: 9e29eec0
keywords: MongoDB,Basic Concepts,Database,Database,Collection,Table,Relational Database
date: 2018-05-12 00:00:00
---

## Document Add/Delete

~~~bash
# Create collection
> db.createCollection("posts");

# Insert one data
> db.posts.insert(
... {
...     title: "My First Blog",
...     content: "Started writing blog, so excited."
... }
... );

# Query data
> db.posts.find();

# Insert another data
> db.posts.insert(
... {
...     title: "My Second Blog",
...     content: "What should I write?",
...     tag: ["Uncategorized"]
... }
... );



# Use js for loop to insert data
> for(var i = 3; i <=10; i++ ) {
...     db.posts.insert({
...         title: "My " + i + "th Blog"
...     });
... }

# Query data
> db.posts.find();

# View data count
> db.posts.count();

# Delete all collection data
> db.posts.remove({});

> db.posts.find();
~~~

## Document Conditional Query

```bash
# Query data with tag as game
> db.posts.find({"tag": "game"});

# Query data with rank greater than or equal to 4
> db.posts.find({"rank": {$gte: 4}});

# Query data with rank greater than 4
> db.posts.find({"rank": {$gt: 4}});

# Query data with rank less than or equal to 4
> db.posts.find({"rank": {$lte: 4}});

# Query data with rank less than 4
> db.posts.find({"rank": {$lt: 4}});

# Regular expression query
> db.posts.find({"title": /u/});

# Multi-condition query
> db.posts.find({"title": /u/, "rank":{$gte:5} });

# $or OR condition query
> db.posts.find({$or: [{"title": /u/}, {"rank":{$gte:4}}] });

# $in contains, query data with rank containing 3,4
> db.posts.find({"rank": {$in: [3,4]} });

# Check if exists
> db.posts.find({"istop": {$exists: true} });

# Query data with three tags in article
> db.posts.find({'tag': {$size: 3}});

# Get all tag types, distinct function is to get non-duplicate values of specified field in collection, return as array
> db.posts.distinct("tag");

```

### MongoDB vs RDBMS Where Statement Comparison
|Operation	|Format	|Example	|Similar Statement in RDBMS
| -------------    |-------------|-------------|-------------|
|Equal	|{<key>:<value>}	|db.col.find({"by":"test"}).pretty()	|where by = 'test'
|Less than	|{<key>:{$lt:<value%}}	|db.col.find({"likes":{$lt:50}}).pretty()	|where likes < 50
|Less than or equal	|{<key>:{$lte:<value%}}	|db.col.find({"likes":{$lte:50}}).pretty()	|where likes <= 50
|Greater than	|{<key>:{$gt:<value%}}	|db.col.find({"likes":{$gt:50}}).pretty()	|where likes > 50
|Greater than or equal	|{<key>:{$gte:<value%}}	|db.col.find({"likes":{$gte:50}}).pretty()	|where likes >= 50
|Not equal	|{<key>:{$ne:<value%}}	|db.col.find({"likes":{$ne:50}}).pretty()	|where likes != 50


## Specify Extract Fields
> Syntax: db.[collection_name].find({}, {field1: true, field2: 1})

```bash
# true and 1 means return, false and 0 means don't return
# Query all data, return specified number of data
> db.posts.find({}, {title:true, rank:1});
# Without _id
> db.posts.find({}, {title:true, rank:1, _id:0});

```

## Document Methods
* sort() Sort
* limit() Specify return count
* skip() Skip n records

```bash
> use aliliblog;

# Ascending sort
> db.posts.find({}, {_id:0}).sort({rank:1}); 

# Descending sort
> db.posts.find({}, {_id:0}).sort({rank:-1});

# Get three records
> db.posts.find({}, {_id:0}).limit(3);

# Descending sort get first three
> db.posts.find({}, {_id:0}).sort({rank:-1}).limit(3);

# Get first record
> db.posts.findOne({}, {_id:0});


# Skip first three, get 456 records, can easily do pagination
> db.posts.find({}, {_id:0}).skip(3).limit(3);
```

