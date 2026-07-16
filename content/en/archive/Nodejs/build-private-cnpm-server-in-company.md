---
title: Build Private cnpm Server in Company
categories: [Backend]
tags: [Node.js]
slug: eed8d24e
keywords: Node.js,ts,Private,Server,typescript,verdaccio,npm,Browser,cnpm
date: 2017-11-24 22:30:05
---

There are more and more js projects now. If we open source our code, we'll publish these codes to npm.
But npm is public, company code after all won't be publicly available online.
So we need to build our own npm server. Publish company private code on the company's npm server.
This way we can conveniently download the code we want, and also not put this code on open source platforms

## Basic Installation Steps

1. Install mysql on linux
2. npm install cnpm.org download cnpm.org code
3. Configure cnpm.org database configuration
4. npm start

During installation, we only have these simple 4 steps. No matter where we encounter various problems, they won't deviate from these 4 steps.

## Let's Start
### Install mysql on linux
There are many related tutorials online, please search yourself. If needed I'll write another article about installation steps.
We assume here we created a user: root password: root1234
1. Create database
```
CREATE DATABASE cnpmjs
```
2. Create tables: 

In cnpm.org code, doc/db.sql file contains SQL statements for creating cnpm.org related tables
```
mysql> use cnpmjs;
mysql> source docs/db.sql
```

### Configure SQL Information in Code

Configure our database connection information in cnpm.org code's config/config.js.

Find mysqlServers related code, configuration roughly as follows:

```javascript
    mysqlServers: [
      {
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'root1234',  // This is the account and password we just created
      }
    ],
```

### Install cnpm.org Related js Dependencies (This is what jsers are most familiar with)
 
 Enter cnpm.org code directory

 ```
 npm install
 ``` 
 

 ### Final Step 
After js dependencies are installed, and cnpm.org database configuration is configured.
Run the following command in command line:

```
npm start
```

Alright, our cnpm server is simply built successfully.

* Default web port: 7002, when you enter this machine's ip plus port in browser, you can access cnpm.org application's web page.
  Local access: http://localhost:7002

* registry default port: 7001

> If you can't access your application from other machines. Please check your server firewall.

### Try Using
```
    npm install webpack -g --registry=http://192.168.0.100:7001 // IP is your server address, don't forget to add port number
```

If you think the above method is troublesome, you can set local npm default registry
```
npm config set registry http://192.168.0.100:7001
```

## cnpm.org Related Configuration

```javascript
{
enableCluster: Whether to enable cluster-worker mode to start service, default false, production environment recommended true;
registryPort: API dedicated registry service port, default 7001;
webPort: Web service port, default 7002;
bindingHost: Listening bound Host, default 127.0.0.1, if there's a local Nginx reverse proxy or Apache reverse proxy layer outside, recommended not to change;
sessionSecret: Salt for session;
logdir: Log directory;
uploadDir: Temporary upload file directory;
viewCache: Whether view template cache is enabled, default false;
enableCompress: Whether to enable gzip compression, default false;
admins: Admins, this is a JSON Object, corresponding key names are admin usernames, key values are their emails, default { fengmk2: 'fengmk2@gmail.com', admin: 'admin@cnpmjs.org', dead_horse: 'dead_horse@qq.com' };
logoURL: Logo address, but for someone like me who has already changed CNPM front-end beyond recognition, I've ignored this configuration;
adBanner: Ad Banner address;
customReadmeFile: Actually the long introduction in the middle of cnpmjs.org homepage we see is converted from a Markdown file, you can set this item to replace this file yourself;
customFooter: Custom footer template;
npmClientName: Default cnpm, if you have your own developed or forked npm client, please change to your own CLI command, this should replace in some page descriptions with what you wrote;
backupFilePrefix: Backup directory;
database: {
    // Database related configuration, as an object, default if not configured will be a ~/.cnpmjs.org/data.sqlite SQLite;
    db: Database name;
    username: Database username;
    password: Database password;
    dialect: Database adapter, optional "mysql", "sqlite", "postgres", "mariadb", default "sqlite";
    host: Database address;
    port: Database port;
    pool: {
        // Database connection pool related configuration, as an object;
        maxConnections: Maximum connections, default 10;
        minConnections: Minimum connections, default 0;
        maxIdleTime: Single connection maximum idle time, default 30000 milliseconds;
    }
    storage: Only valid for SQLite configuration, database address, default ~/.cnpmjs/data.sqlite;
},
nfs: Package file system processing object, as a Node.js object, default is fs-cnpm package, and configured in ~/.cnpmjs/nfs directory, meaning all synced packages will be placed in this directory by default; developers can use other file system plugins (like uploading to Youpai Cloud, etc.), or develop a logic layer themselves according to the interface, these are all for later;
registryHost: Haven't tried yet, I guess it's for Web page display, default r.cnpmjs.org;
enablePrivate: Whether to enable private mode, default false;
// If private mode, only admins can publish packages, others can only sync packages from source;
// If non-private mode, all logged-in users can publish packages;
scopes: Non-admin users can only publish packages with prefixes listed in scopes when publishing, if not set cannot publish, meaning this is a required field, default [ '@cnpm', '@cnpmtest', '@cnpm-test' ], according to Suqian's explanation, it's for easy management and letting company employees consciously publish as needed; more about NPM scope explanation please see npm-scope;
privatePackages: As the configuration item comment states, due to historical baggage reasons, some existing private packages (possibly previously installed via Git) are not named in namespace form, and such packages originally cannot be uploaded to CNPM, this configuration item array is used to add these exception whitelists, default empty array;
sourceNpmRegistry: Update source NPM registry address, default https://registry.npm.taobao.org;
sourceNpmRegistryIsCNpm: Whether source registry is CNPM, default true, if you use official NPM source, please set to false;
syncByInstall: If package not found when installing, try to sync from update source, default true;
syncModel: Update mode (though I think it's a typo), has the following modes to choose from, default "none";
// "none": Never sync, only manage private user uploaded packages, other source packages will be directly obtained from source;
// "exist": Timed sync packages already existing in database;
// "all": Timed sync all source packages;
syncInterval: Sync interval, default "10m" meaning ten minutes;
syncDevDependencies: Whether to sync devDependencies packages in each package, default false;
badgeSubject: Package badge display name, default cnpm;
userService: User verification interface, default null, meaning no user-related functionality, meaning cannot have users upload packages, this part needs to implement interface functionality yourself and configure, like interfacing with company's Gitlab, this is also for later;
alwaysAuth: Whether to always require user verification, even for $ cnpm install and other commands;
httpProxy: Proxy address settings, for when you're behind the wall and source is outside the wall.
}

```

Reference article:
[https://www.v2ex.com/t/292046](https://www.v2ex.com/t/292046)

