---
title: MongoDB Migration - Backup and Restore
categories: [Database]
tags: [MongoDB]
slug: 7815p445rtf
keywords: MongoDB,Basic Concepts,Database,Database,Collection,Table,Relational Database
date: 2019-03-27 00:00:00
---

Recently did a migration of my crawler database, so here record MongoDB backup and restore

## MongoDB Data Backup

```bash
mongodump -h dbhost -d dbname -o dbdirectory
```
* -h: MongoDB server address, e.g.: 127.0.0.1, if not changed generally is: 127.0.0.1:27017

*  -d: Database name to backup, e.g.: test

*  -o: Backup data storage location, e.g.: /home/root/xxx,



## MongoDB Data Restore
```bash
mongorestore -h <hostname><:port> -d dbname <path>
```

* --host <:port>, -h <:port>: MongoDB server address, default: localhost:27017

* --db , -d : Database name to backup, e.g.: test

* --drop: Delete existing data first, then restore data

* <path>: Specify backup file directory


* --dir: Specify backup file directory, cannot specify <path> and --dir options simultaneously.



