---
title: Build Simpler Private npm Server with verdaccio
categories: [Backend]
tags: [Node.js]
slug: '9713e794'
keywords: Node.js,ts,Private,Server,typescript,verdaccio,npm,Browser
date: 2018-04-10 22:30:05
---

Building private npm servers like cnpm.org is already quite simple,
but compared to verdaccio's simplicity, there's no comparison.
Because verdaccio is too simple.

### Introduction
verdaccio is a lightweight private NPM Registry (forked from Sinopia, Sinopia's last update was years ago). Initially planned to use cnpmjs to build private npm repository but after building there were some problems, so used Sinopia;

Next I'll briefly introduce verdaccio usage.

### Install verdaccio on Your Server
```bash
$ npm i verdaccio -g
```

### Start

```bash
# Directly enter verdaccio command
$ verdaccio

// If startup successful, will display the following information
 Verdaccio doesn't need superuser privileges. Don't run it under
 warn --- config file  - /root/.config/verdaccio/config.yaml
 warn --- http address - http://localhost:4873/ - verdaccio/
```

We can also start with pm2 (also the method I chose to use)
```bash
$ pm2 start verdaccio
```

### Configuration
System default configuration file is at `/root/.config/verdaccio/config.yaml`
Below is my current configuration, everyone can simply reference it.
Basically didn't change much.
```yaml
#
# This is the default config file. It allows all users to do anything,
# so don't use it on production systems.
#
# Look here for more config file examples:
# https://github.com/verdaccio/verdaccio/tree/master/conf
#

# Here is your default package storage location, I made corresponding modifications according to my situation
#storage: /root/.local/share/verdaccio/storage
storage: /data01/verdaccio/storage

# Port number, address needs to be set like this for external access
listen: 0.0.0.0:4873
auth:
  htpasswd:
    file: ./htpasswd
    # Maximum amount of users allowed to register, defaults to "+inf".
    # You can set this to -1 to disable registration.
    #max_users: 1000

# npm settings I directly proxied Taobao source
# This way I don't need to actively sync packages anymore, directly request Taobao source for local requests that can't be found
uplinks:
  npmjs:
    url: https://registry.npm.taobao.org

packages:
  '@*/*':
    # scoped packages
    access: $all
    publish: $authenticated
    proxy: npmjs

  '**':
    # allow all users (including non-authenticated users) to read and
    # publish all packages
    #
    # you can specify usernames/groupnames (depending on your auth plugin)
    # and three keywords: "$all", "$anonymous", "$authenticated"
    access: $all

    # allow all known users to publish packages
    # (anyone can register by default, remember?)
    publish: $authenticated

    # if package is not available locally, proxy requests to 'npmjs' registry
    proxy: npmjs

# log settings
logs:
  - {type: stdout, format: pretty, level: http}
  #- {type: file, path: verdaccio.log, level: info}
```

