---
title: MongoDB - Basic Concepts and Comparison with Other Databases
categories: [Database]
tags: [MongoDB]
slug: 1f77f611
keywords: MongoDB,Basic Concepts,Database,Database,Collection,Table,Relational Database
date: 2018-05-10 00:00:00
---

Basic Concepts
=============
## NoSql

In NoSql databases, data operations are all completed through commands or programming languages.

In MongoDB uses JavaScript and JSON data structures to operate and manage data.

## MongoDB Database vs Relational Database Comparison

| MongoDB          | Relational Database    |
| -------------    |-------------|
| Database (Database) | Database (Database) |
| Collection (Collection)| Table (Table)    |
| Document (Document)  | Record (Record)     |



## MongoDB vs RDBMS Corresponding Terms

|MongoDB  |RDBMS|
| ---   |---|
|Database  |Database|
|Collection   |Table|
|Document	    |Row	|
|Field	    |Column	|
|Embedded Document	|Table Join|
|Primary Key (MongoDB provides key as _id )	|Primary Key|
## MongoDB Data Types

|Data Type|	Description|
| ---   |---|
|String	|String. Common data type for storing data. In MongoDB, UTF-8 encoded strings are legal.|
|Integer	|Integer value. Used to store numeric values. Depending on server you adopt, can be 32-bit or 64-bit.|
|Boolean	|Boolean value. Used to store boolean values (true/false).|
|Double	|Double precision floating point value. Used to store floating point values.|
|Min/Max keys	|Compare a value with BSON (binary JSON) element's lowest and highest values.|
|Array	|Used to store arrays or lists or multiple values as one key.|
|Timestamp	|Timestamp. Records document modification or addition specific time.|
|Object	|Used for embedded documents.|
|Null	|Used to create empty values.|
|Symbol	|Symbol. This data type basically equals string type, but difference is, it's generally used for languages using special symbol types.|
|Date	|Date time. Uses UNIX time format to store current date or time. You can specify your own date time: create Date object, pass year month day information.|
|Object ID	|Object ID. Used to create document's ID.|
|Binary Data	|Binary data. Used to store binary data.|
|Code	|Code type. Used to store JavaScript code in documents.|
|Regular expression	|Regular expression type. Used to store regular expressions.|

