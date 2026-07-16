---
title: MongoDB - Database and Collection Basic Operations
categories: [Database]
tags: [MongoDB]
slug: 3a26a4b
keywords: MongoDB,Basic Concepts,Database,Database,Collection,Table,Relational Database
date: 2018-05-11 00:00:00
---

Database Basic Operations
=============

```bash
# Enter command line
$ mongo

# Help
> help

# Exit
> exit

# Show all databases
> show dbs;

# Enter or create collection
> use aliliblog;

# View current database status
> db.stats();

# Delete database
> db.dropDatabase();
```

Collection Operations
=====================

~~~bash


# View collections
> show collections;

# Create collection
> db.createCollection("users");

# Collection rename
> db.users.renameCollection("staff"); // users -> staff

# Collection delete
> db.staff.drop();
~~~

