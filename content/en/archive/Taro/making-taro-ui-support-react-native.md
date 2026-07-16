---
title: 'Making Taro UI Support React Native'
categories: [Cross-Platform]
tags: [Taro,Cross-platform-Development,Front-end-Architecture]
slug: wwfw2u086as
keywords: Taro,Multi-platform Isomorphism,Front-end-Architecture,Multi-platform Development Skills,Cross-platform Development
date: 2020-08-27 22:17:36
---

## The Dilemma of Taro UI Not Supporting RN

Taro UI documentation mentioned early on that it might support RN, but it's been over a year, and due to manpower issues in the Taro UI team, it hasn't been compatible with RN yet.

Business is urgent, we can't wait for that day. Do it yourself and you'll have everything you need.

## Problems with Traditional Taro Component Packaging on RN

Generally, after a component library is packaged, the dist/index.js file will look like this.

Distinguish which component library to import based on runtime environment variables.
```js
if (process.env.TARO_ENV === 'weapp') {
      module.exports = require('./weapp/ui')
      module.exports.default = module.exports
    } else if (process.env.TARO_ENV === 'h5') {
      module.exports = require('./h5/ui')
      module.exports.default = module.exports
    } else {
      module.exports = require('./weapp/ui')
      module.exports.default = module.exports
    }
```

In ideal mode, just add an RN environment check to enable RN component library import.
```js
if (process.env.TARO_ENV === 'weapp') {
      module.exports = require('./weapp/ui')
      module.exports.default = module.exports
    } else if (process.env.TARO_ENV === 'h5') {
      module.exports = require('./h5/ui')
      module.exports.default = module.exports
    } else if (process.env.TARO_ENV === 'rn') {
      // Ideal mode, just add this section
      module.exports = require('./rn/ui')
      module.exports.default = module.exports
    } else {
      module.exports = require('./weapp/ui')
      module.exports.default = module.exports
    }
```

But reality isn't like this. If RN imports the component library's index file, which is dist/index.js, it will pre-execute all code from all platforms in advance.

Before the code actually runs, it errors out because code from other platforms is incompatible. So this hardcore import method is not feasible.

## RN Component Library Code Completely Isolated from Other Platform Code

### Changes to ui.js File
There's a ui.js file under src, roughly like this:

```js
import Taro from '@tarojs/taro'
import './style/index.scss'
export { default as AActionSheet } from './components/action-sheet'
export { default as AActionSheetItem } from './components/action-sheet/body/item'
export { default as AText } from './components/text'
export { default as AToast } from './components/toast'
export { default as AButton } from './components/button'

// Other components...

```

To better make RN compatibility on the original component library, we can use Taro's feature of distinguishing platforms by file suffix.
Need to create a new `ui.rn.js`

Content and function are basically the same as ui.js, the only difference is that some component paths need to add rn suffix.

```js
import Taro from '@tarojs/taro'
import './style/index.scss'

export { default as AActionSheet } from './components/action-sheet/index.rn'
export { default as AActionSheetItem } from './components/action-sheet/body/item/index.rn'
export { default as AText } from './components/text'
export { default as AToast } from './components/toast/index.rn'  // Components compatible with RN
export { default as AButton } from './components/button/index'  // Components compatible with all platforms

```

### Changes to Component Library Index File

Normally, after RN packaging, an `rn_temp` folder will be generated, which contains pure RN code.
The code here doesn't need to be generated to the dist directory like other platforms.

My component library index file, which is the main in packages.json, just needs to point to an RN component library exclusive index file.

I named it: `main.rn.js`
RN component library index file:
```js
"use strict";
module.exports = require('./rn_temp/ui.rn.js');
module.exports.default = module.exports
```

For other platforms, just point to the dist directory
h5 and various mini-program platforms
```js
"use strict";
module.exports = require('./dist/index');
module.exports.default = module.exports
```

### Component Library Packaging and Publishing

Mini-program and h5 component libraries still follow the original packaging and publishing mode.
But for RN, we need to modify the package.json content when publishing.

I provide a simple publishing script here:

```js
const { execSync } = require('child_process');
const fse = require('fs-extra');
const path = require('path');

// Upgrade version number
execSync("npm version patch");
const pkgPath = path.relative(process.cwd(),'package.json')
var packageData = fse.readJsonSync(pkgPath);
// h5 mini-program component library

console.log("Starting to build mini-program component library")
packageData.name = 'taro-ui'
packageData.main = 'main.js'
fse.outputJsonSync(pkgPath, packageData,{spaces:2});
execSync(`npm run build:component && crgt publish;`);


// Modify npm package name, republish a package
console.log("Starting to build RN component library")
packageData.name = 'taro-ui-rn'
packageData.main = 'rn_temp/ui.rn.js'
fse.outputJsonSync(pkgPath, packageData,{spaces:2});
execSync('npm run build:rn && crgt publish;');

// Restore name
packageData.name = 'taro-ui'
packageData.main = 'main.js'
fse.outputJsonSync(pkgPath, packageData,{spaces:2});
execSync('git push');

```

Here you should notice that when I publish the component library, I publish two npm packages.

As someone with OCD, don't worry too much about this. Many Taro dependencies do this too.

## How to Use Such Component Library
In business development, code can directly import the taro-ui npm package.

### But What About RN Business?
Here we learn from Taro's way of handling official dependencies, just replace the package name `taro-ui` with `taro-ui-rn` during code compilation.

So we need to simply modify Taro's source code. We're using version 1.3.X, if it's a higher version, there should be other ways to modify.

In version 1.3.x, we need to modify tarojs/cli code.

In the rn module of cli, there's a `transformJS` file. Search for `source.value = PACKAGES['@tarojs/components-rn']` in this file, find the location of this line of code.

This code roughly means that when traversing the AST, if the imported package name is `@tarojs/components`, replace it with `@tarojs/components-rn`.

So we follow the same logic, add one more else if

```js
else if (value === PACKAGES['@tarojs/components']) {
    source.value = PACKAGES['@tarojs/components-rn']
// Add the next section of judgment
}else if (value === 'taro-ui') {
  source.value = 'taro-ui-rn'
}
```
This way, we can import the correct npm package during normal development.

