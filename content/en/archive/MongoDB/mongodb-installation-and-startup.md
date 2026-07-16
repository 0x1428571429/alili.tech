---
title: MongoDB - Installation and Startup
categories: [Database]
tags: [MongoDB]
slug: f82d8042
keywords: MongoDB,Basic Concepts,Database,Database,Collection,Table,Relational Database
date: 2018-05-09 00:00:00
---

What is MongoDB?
==============

MongoDB is a document-oriented free database, often used for data collection and distributed processing (Map/Reduce), especially good at big data processing.

MongoDB is a database based on distributed file storage. Written in C++ language. Aims to provide scalable high-performance data storage solutions for WEB applications.

MongoDB is a product between relational databases and non-relational databases, is the most feature-rich among non-relational databases, most like relational databases.


## macOS OS Installation and Startup

### Installation
Simplest is through brew installation
```bash

brew update

# This way MongoDB is installed on Mac
brew install mongodb

# If you need latest development version
brew install mongodb --devel
```

### Startup
```bash
# Create default data folder
mkdir -p /data/db

# Direct startup
mongod

# Specify path startup
mongod --dbpath <path to data directory>

# Connect to default port database
mongo

# Specify port connect to database
mongo --host 127.0.0.1:27017
```

## centOS Installation and Startup

### Installation

Create a file `/etc/yum.repos.d/mongodb-org-4.0.repo `
```bash
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
```


Install database through yum
```bash
# This simple installation succeeds
sudo yum install -y mongodb-org
```
### Startup

Start
```bash
sudo service mongod start
```

Verify service started
```bash
sudo chkconfig mongod on
```

Stop
```bash
sudo service mongod stop
```

Restart
```bash
sudo service mongod restart
```

## Other
Start database in a front-end way
```bash
pm2 start mongo
```

