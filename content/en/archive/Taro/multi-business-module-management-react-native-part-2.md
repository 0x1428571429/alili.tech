---
title: 'Taro Cross-Platform Development - Multi-Business Module Management React Native (Part 2)'
categories: [Cross-Platform]
tags: [Taro,Cross-platform-Development,Front-end-Architecture]
slug: j4ylxksvfa8
keywords: Taro,Multi-platform Isomorphism,Front-end-Architecture,Multi-platform Development Skills,Cross-platform Development
date: 2020-08-23 22:17:36
---

## Implement a Simple Module Management Tool to Solve the Problem of Slow npm Pulling of Business Modules

Using npm to pull git repositories, the speed is actually acceptable.
The main slowness is during `postinstall` when npm pulls git repositories, it needs to rebuild project code. Another point is that business modules also have dependencies, and npm install also needs to pull the same dependencies again.

These two steps can actually be omitted. The solution is to implement a simple module management tool to replace npm's handling of loading business modules.

### Create a Configuration File
```js
module.exports = {
    "Module1": {
        "url": "http://xxx1.git",
        "moduleName": [
            "Module Name"
        ],
        "branch": "develop",
        "type": "taro"
    },
    "Module2": {
        "url": "http://xxx2.git",
        "moduleName": [
            "Module Name"
        ],
        "branch": "develop",
        "type": "taro"
    }
}
```

Since every project will use this file, put this file on the server.
When business modules initialize, automatically pull and parse this file. Then use nodejs to pull the corresponding git repositories.

### Pull Git Repositories

Use `download-git-repo` to pull git repository code and put it in the node_modules directory.
This way in the project, I can reference the repository code like a normal npm package.

This is the address and usage of `download-git-repo`
https://www.npmjs.com/package/download-git-repo

### Simulate npm Lifecycle
After code is pulled down, we still need to use postinstall to build business code,
So we need to use nodejs to traverse business module directories, read each packages.json under the directory.

If there are npm hooks, execute the scripts inside.

Rough example code:

```js
// Example code, for reference only
const spawn = require('cross-spawn');
const fse = require('fs-extra');


const packageData = fse.readJsonSync('./packages.json');

if (packageData.scripts.preinstall) {
  spawn.sync('npm',['run','preinstall']);
}

if (packageData.scripts.postinstall) {
  spawn.sync('npm',['run','postinstall']);
}

```

### Concurrently Execute npm Hooks of Business Modules

When npm executes postinstall, it doesn't execute everything all at once.

When using yarn to install dependencies, at most 4 modules can execute simultaneously (npm install hasn't been specifically studied).
So when building business modules, there's always a situation of waiting one by one.

If using your own module management tool, you can remove this restriction (of course, I have no restriction).
If there are too many business modules and your computer can't handle it, you can appropriately adjust the number of concurrently executing npm hooks.

### Use Configuration File to Automatically Generate index.js

We mentioned above that we have a configuration file for managing business modules.
With this, we can automatically generate index.js content based on the configuration file.

```js
import { AppRegistry} from 'react-native';

// The following content can be automatically generated based on configuration file
import Module1 from 'Module1';
import Module2 from 'Module2';
import Module3 from 'Module3';


AppRegistry.registerComponent('Module1', () => Module1);
AppRegistry.registerComponent('Module2', () => Module2);
AppRegistry.registerComponent('Module3', () => Module3);
```

## Afterword

This article introduced how to remove npm restrictions and quickly initialize project business modules.

Next article, the final chapter, will introduce how our current RN project business modules do hot updates.
All business modules are decoupled. When developing a single business module, it won't depend on other business modules during local development.
Achieve independent development and independent deployment.

