---
title: How to Optimize Bundle Size for Quick Apps Developed with Taro
categories: [Cross-Platform]
tags: [Taro,Cross-platform-Development,Front-end-Architecture]
slug: n1j1l1fvzbb
keywords: Taro,Multi-platform Isomorphism,Front-end-Architecture,Multi-platform Development Tips,Cross-platform Development
date: 2020-12-15 22:17:36
---

## Quick App Duplicate Bundling Issue

When developing quick apps with Taro, there's one issue that absolutely cannot be ignored: bundle size.

Due to the bundling characteristics of quick apps (below version 1080), if a third-party library is repeatedly used across multiple pages, that library's code will be bundled into each page, causing the same code to exist in multiple pages.

Because quick app version 1080 is not yet widely deployed. If you rashly upgrade your quick app's minimum platform version to 1080,
you will lose a large number of users on lower versions.

## Official Solution (Versions Below 1080)

Of course, the quick app official team has also recognized this problem and provided an early solution.

That is, mount all code that multiple pages depend on to global variables when the quick app initializes.

Other pages can directly reference global variables when using them.

```js
// Entry file
import day from 'day';

const globalRef = Object.getPrototypeOf(global) || global;
globalRef.day = day;
```

```js
// Page usage
const globalRef = Object.getPrototypeOf(global) || global
const day = globalRef.day

day()
```

## Analyzing Which Common Code the Project Uses

Duplicate bundling content, npm dependencies will account for the majority, and it could also be your own common code.

### Which npm dependencies does our project use?

After Taro builds, the build artifacts under `dist/quickapp` will separately place all npm packages that the project can use into the `src/npm/` directory.

### Common Code Analysis

As long as a js file is referenced by multiple pages, it will definitely cause duplicate bundling issues.

## Using Taro's Alias Feature to Solve Duplicate Bundling Issues

Alias is a feature for applying path aliases. Its implementation principle is simple: define path replacement rules in the config file.

When Taro builds, it directly replaces application paths with the correct application paths.

```js
{    
  '@src': 'src',
  '@plugin': 'src/plugin',
  '@components': 'src/components',
}
```

### How to Use Alias to Solve Our Bundling Problem

Since alias has the feature of replacing application paths, plus our third-party libraries only need to be mounted to global variables for all pages to use.

The solution combining these two features is as follows.

#### Step 1: Modify npm alias

Why do this? You'll understand after seeing step 2.

> The classnames.ex file is the mapping file for classnames.

```js
{
    'classnames': 'src/replacement/classnames.ex',
    'prop-types': 'src/replacement/prop-types.ex',
    'mobx': 'src/replacement/mobx.ex',
}
```

#### Step 2: Create Replacement Dependencies

1. Copy the contents of `dist/quickapp/src/npm` to `src/replacement/npm`.
2. Create a new `index.js` file under `src/replacement` with content roughly as follows:

```js
import crypt from './npm/crypt/crypt'
import classnames from './npm/classnames'


const globalRef = Object.getPrototypeOf(global) || global

globalRef.classnames = classnames;
globalRef.crypt = crypt;
```

3. Create npm dependency mapping files

At this step, you should understand why alias replaces normal npm dependency paths with a mapping file.

All page references to classnames will be retrieved from global variables.
```js
// src/replacement/classnames.ex
const globalRef = Object.getPrototypeOf(global) || global;
export default globalRef.classnames;
```

#### Step 3: Reference `replacement` in app.js

```js
import Taro, { Component } from '@tarojs/taro';

import './replacement';
// The reference to replacement must be placed after the @tarojs/taro import
// Be sure to initialize your own code first.
// Avoid reference order issues that prevent other third-party libraries from using dependencies normally

```

This way we can perfectly bypass the duplicate bundling issue.

## Official Support for Independent JS Bundling in Version 1080+

The official team provides a method for independent JS bundling in version 1080+.

For specific usage methods, please refer to the official documentation, which won't be detailed here.

https://doc.quickapp.cn/framework/js-split.html
