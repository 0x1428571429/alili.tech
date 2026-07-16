---
title: MongoDB - Document Basic Operations (Part 2)
categories: [Database]
tags: [MongoDB]
slug: 311875a2
keywords: MongoDB,Basic Concepts,Database,Database,Collection,Table,Relational Database
date: 2018-05-13 00:00:00
---

## Document Update

> Syntax: update(<filter>, <update>, <options>)

```bash
# Update rank field
> db.posts.update({"title":"Monster Hunter World Review"}, {$set: {"rank": 10} });

# Update entire data to: {"rank": 99}
> db.posts.update({"title":"Monster Hunter World Review"}, {"rank": 99});

# Update multiple records multi: true, if false, then update first record found
> db.posts.update({"tag":"it"}, {$set: {"rank": 60}}, {multi: true});



```

## Document Field Operation Functions

* $inc: Increment
* $mul: Multiply
* $rename: Rename
* $set: Add or modify
* $unset: Field delete

```bash
# Field value increment, result: field value + 1
> db.posts.update({title:"Monster Hunter World Review"}, {$inc: {rank: 1}});

# Field value multiply operation, result: field value * 2
> db.posts.update({title:"Monster Hunter World Review"}, {$mul: {rank: 2}});

# Field rename
> db.posts.update({title:"Monster Hunter World Review"}, {$rename: {"rank": "score"}});

# Set or add field
> db.posts.update({title:"Monster Hunter World Review"}, {$set: {"istop": true}});

# Delete istop field
> db.posts.update({title:"Monster Hunter World Review"}, {$unset: {"istop": true}});

```

# Document Special Updates
* upsert: Update if exists, append if not
* remove: Conditional delete data

```bash
$ mongo
# Update entire data
> db.posts.update({title:"Actually Creation is More Fun than Taishi"}, {title:"Actually Creation is More Fun than Taishi", "rank":5,"tag":"game"});

# Update or add data
> db.posts.update({title:"Actually Creation is More Fun than Taishi"}, {title:"Actually Creation is More Fun than Taishi", "rank":5,"tag":"game"}, {upsert:true});

# Delete data
> db.posts.remove({title:"Actually Creation is More Fun than Taishi"});
```

## Index
* getIndexes() Get indexes
* createIndex({...}, {...}) Add index
* dropIndex({...}) Delete index 

```bash
# Get indexes
> db.posts.getIndexes();

# Create rank descending index
> db.posts.createIndex({rank:-1});

# Delete index
> db.posts.dropIndex({rank:-1});

# Create an ascending index, and cannot duplicate, subsequent title duplicates will fail to add
> db.posts.createIndex({title:1}, {unique:true});

```

