---
title: 'Taro Cross-Platform Development - Multi-Business Module Management React Native (Final)'
categories: [Cross-Platform]
tags: [Taro,Cross-platform-Development,Front-end-Architecture]
slug: 2f9lla2yjb5
keywords: Taro,Multi-platform Isomorphism,Front-end-Architecture,Multi-platform Development Skills,Cross-platform Development
date: 2020-08-25 22:17:36
---

## React Native Hot Update Solution

RN business is becoming increasingly large, and more teams are collaborating. RN's dynamic capabilities must be put on the agenda.
For RN hot updates, the first problem is code splitting.

RN's base library is very large, plus we depend on many third-party libraries. This code must be separated during code splitting.
Business packages should be relatively pure, containing only business code. This ensures business packages are smaller, ensuring speed during hot updates.

### Using Metro for Code Splitting

React Native's metro comes with code splitting functionality. We've been using metro all along, just provide corresponding packaging rules when metro packages.
This can achieve RN code splitting.

Example: iOS packaging

```bash
node ./node_modules/react-native/local-cli/cli.js bundle --platform ios --dev false --entry-file rn入口文件.js --bundle-output ./xxx/ --assets-dest ./xxx/ --config /{你的绝对路径}/你的metro配置文件.js
```
### Metro Key API Introduction

The options we need for code splitting are mainly two:

* createModuleIdFactory: This function takes the absolute path of the module file to be packaged, returns the id generated when this module is packaged.

* processModuleFilter: This function takes module information, returns a boolean value, false means this file won't be packaged into the current bundle.

### Main Project Code Splitting
Previously we mentioned we have a project that's the main project, containing no business code. Only all dependencies needed for code to run.

We need to collect all dependencies. When business modules are packaged, if a local dependency is found, we can use the `processModuleFilter` method to exclude it.

Because our main project and business project dependency versions are highly unified.
So dependency package paths under node_modules are completely consistent.

[Taro Cross-Platform Development - Dependency Management](https://time-friend.com/archive/h8gasmt9u5c/)

Main project metro configuration file example:
```js
function createModuleIdFactory() {
    return path => {
        // Here we get the dependency file path,
        // We need to collect paths in this function block and generate files from this data
        // Deploy to our intranet server
        // When business modules need packaging, whether to package code will be based on this file
      return path;
    };
}

module.exports = {
    serializer: {
      createModuleIdFactory:createModuleIdFactory
    }
};
```

Main project entry file example:
```js
// This file will import all RN dependencies we need to use, because these don't update often.
// When metro packages, it will collect paths of these dependencies
// Ensure business package packaging won't duplicate them
import React, {Component} from'react';
import { DeviceEventEmitter,Platform, NativeEventEmitter, NativeModules } from 'react-native';
import { SmartAssets } from "react-native-smartassets";
import 'moment/locale/zh-cn';
import 'react-navigation';
import '@tarojs/components-rn';
import '@tarojs/taro-router-rn';
import '@tarojs/taro-rn';
import '@tarojs/async-await';
import "@tarojs/mobx-rn";
import "dayjs";
import "querystring";
import "react-native-check-box";
import "classnames";
import "lodash.orderby";
import "react-native-swipe-list-view";

SmartAssets.initSmartAssets();
DeviceEventEmitter.addListener('sm-bundle-changed',
	(bundlePath)=>{
		SmartAssets.setBundlePath(bundlePath);
	});

if(Platform.OS != 'android') {//ios
	const {BundleloadEventEmiter} = NativeModules;

	const bundleLoadEmitter = new NativeEventEmitter(BundleloadEventEmiter);

	// eslint-disable-next-line no-unused-vars
	const subscription = bundleLoadEmitter.addListener(
		'BundleLoad',
		(bundleInfo) => {
			console.log('BundleLoad==' + bundleInfo.path);
			SmartAssets.setBundlePath(bundleInfo.path);
		}
	);
}

require('react-native/Libraries/Core/checkNativeVersion');
```

### Business Module Code Splitting

Business module packaging mainly excludes main module dependencies.

Business module metro configuration file example:
```js
const pathSep = require('path').sep;
const platformMap = require('业务包的打包数据');

let entry;

function postProcessModulesFilter(module) {
  const projectRootPath = __dirname;
  // If business package has no data, process exits directly,
  // Avoid packaging unnecessary code
  if (platformMap == null || platformMap.length == 0) {
    console.log('Please build base package first');
    process.exit(1);
    return false;
  }
  const path = module['path']

  // Special modules also need to be excluded
  if (path.indexOf("__prelude__") >= 0 ||
    path.indexOf("/node_modules/react-native/Libraries/polyfills") >= 0 ||
    path.indexOf("source-map") >= 0 ||
    path.indexOf("/node_modules/metro/src/lib/polyfills/") >= 0) {
    return false;
  }

  if (module['path'].indexOf(pathSep + 'node_modules' + pathSep) > 0) {
    if ('js' + pathSep + 'script' + pathSep + 'virtual' == module['output'][0]['type']) {
      return true;
    }else if(platformMap.includes(name)){
     // If modules already packaged by main project before, exclude and return false
      return false;
    }
  }
  // No special circumstances, can package normally
  return true;
}

function createModuleIdFactory() {
  const projectRootPath = __dirname;
  return path => {
    let name = getModuleId(projectRootPath,path,entry,true);
    return name;
  };
}

function getModulesRunBeforeMainModule(entryFilePath) {
  entry = entryFilePath;
  return [];
}

module.exports = {
  serializer: {
    createModuleIdFactory: createModuleIdFactory,
    processModuleFilter: postProcessModulesFilter,
    getModulesRunBeforeMainModule:getModulesRunBeforeMainModule
    /* serializer options */
  }
};


```

## Code Splitting Deployment and Client Distribution

After all types of packages are built, we compress them into zip packages and deploy to CDN.
When the client detects a module has been updated, it will pull the corresponding code package from CDN.

We learned from the following project for client-related loading solutions:
https://github.com/smallnew/react-native-multibundler

## Client Loading Order
The client must load main project code first before loading business packages.
This is a necessary condition, otherwise it will crash directly.

## Client Hot Update Error Handling

To ensure the client can run normally at any time, we will package all split packages into the client when the client is released. When client hot update fails, it will roll back to the code initially packaged into the client.

The following are scenarios that may cause update failures, we will all roll back rendering:

* Code package fetch timeout

* When MD5 doesn't match

* When code decompression fails

* Code package version number is invalid

* Crashes on first entry

There are many more scenarios, not listed here one by one.
But this part must be absolutely emphasized, once an error occurs, it will cause the client to crash directly.

## Afterword
To ensure independent development and independent deployment, our CI/CD has done a lot of customization and development based on this packaging solution. I won't expand on this here. Code splitting is actually simple, the most important thing is client stability.

Users' phones will have many unexpected extreme environments. How to ensure runtime stability.

This requires everyone to think carefully.

