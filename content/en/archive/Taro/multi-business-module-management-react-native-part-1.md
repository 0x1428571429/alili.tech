---
title: 'Taro Cross-Platform Development - Multi-Business Module Management React Native (Part 1)'
categories: [Cross-Platform]
tags: [Taro,Cross-platform-Development,Front-end-Architecture]
slug: w650d9ok34i
keywords: Taro,Multi-platform Isomorphism,Front-end-Architecture,Multi-platform Development Skills,Cross-platform Development
date: 2020-08-21 22:17:36
---

## How Can Native RN Projects and Taro Coexist?

Our team started practicing native React Native projects early on, for a long time,

All business modules were developed and maintained in one project. Over time, this project became a behemoth.

Plus later we introduced RN projects based on Taro development. To ensure native and Taro RN coexistence,

Whether it's native RN projects or Taro projects, the main export index file format in package.json files is consistent.

We use the following solution to maintain our code.

## Use npm to Manage Our Business Modules

### Main Project for RN Business

This is my initial practice solution. First, we create a project as the main project for RN.

It has no business code, only a business index file index.js in the root directory.

It's roughly like this:

```js

import { AppRegistry} from 'react-native';
import Module1 from 'Module1';
import Module2 from 'Module2';
import Module3 from 'Module3';
AppRegistry.registerComponent('Module1', () => Module1);
AppRegistry.registerComponent('Module2', () => Module2);
AppRegistry.registerComponent('Module3', () => Module3);
```

I mentioned in a previous article that all our module dependencies are unified and versions are locked.

If interested, you can click to view:

[Taro Cross-Platform Development - Dependency Management](https://time-friend.com/archive/h8gasmt9u5c/)

So my main project dependencies are consistent with business module dependencies.

### Use NPM to Manage Business Modules

We treat all business modules as npm packages to manage, because npm has many lifecycle hooks.

After unifying npm script commands, it's easy to manage them uniformly.

Of course, we won't publish these business modules to npm servers, because business code changes frequently. If every commit needs to be uploaded to npm servers, it naturally adds development cost (publishing npm packages is annoying)

So we use `npm + git` addresses to pull our business modules.

For example:

#### Main Project package.json

```json

{
"name": "base",
"version": "0.0.6",
"scripts": {
"build":"RN related operations"
},
"dependencies": {
"Common dependency package": "1.0.0",
"Module1": "http://xxx.com/webfront/Module1.git",
"Module2": "http://xxx.com/webfront/Module2.git",
"Module3": "http://xxx.com/webfront/Module3.git",
}
}

```

#### Business Module package.json

Business modules add postinstall. After successfully pulling business modules using npm, business modules will build their own projects in `node_modules`, providing main project's `index.js` to use

```json
{
"name": "buz",
"version": "0.0.1",
"main": "main.js", // main field should point to RN index file
"scripts": {
"build":"RN related operations",
"postinstall":"npm run build"
},
"dependencies": {
"Common dependency package": "1.0.0"
}
}

```

#### Unified External Output main.js File

```js

"use strict";

// Judge what file to output externally based on platform environment variable

if (process.env.TARO_ENV === 'weapp' || process.env.TARO_ENV === 'h5') {
module.exports = require('./dist/index');
module.exports.default = module.exports
} else {
// Taro projects, standard external output
Object.defineProperty(exports, "__esModule", {
value: true
});
function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }
var _app = _interopRequireDefault(require("./rn_temp/app"));
exports.APP = _app.default;
}

```

### Inter-module Debugging Between Business Modules

There will definitely be situations where businesses need to debug with each other. With the above solution, business modules can only run their own code independently. When we want to navigate to other RN pages, that won't work.

Actually, we can make all business modules like the main module, introduce all business modules during development and debugging.

This way all business code can run. The only difference is other business modules are in `node_modules`, code cannot be modified.

### Advantages and Disadvantages of This Solution

This solution is recommended for medium-sized projects

Advantages:

1. Can coexist native RN and Taro, as long as external export main specification is consistent, main project can serve as unified module registration

2. All business modules are maintained separately, avoiding behemoth projects

3. Businesses can also navigate to each other, a single business module can also launch a complete RN project

Disadvantages:

1. npm install project will be very time-consuming, because not only need to install dependencies, business modules will also build projects during postinstall.

2. After business modules are updated, must re-run npm install

## Afterword

This solution targets medium-sized RN projects. If you have dozens of business modules being developed simultaneously like me, it will bring greater challenges.

Subsequent articles will introduce the ultimate management method for RN based on Taro.

It will also solve all the above disadvantages.

