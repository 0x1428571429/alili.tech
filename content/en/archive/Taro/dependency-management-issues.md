---
title: 'Taro Cross-Platform Development - Dependency Management Issues'
categories: [Cross-Platform]
tags: [Taro,Cross-platform-Development,Front-end-Architecture]
slug: h8gasmt9u5c
keywords: Taro,Multi-platform Isomorphism,Front-end-Architecture,Multi-platform Development Skills,Cross-platform Development
date: 2020-08-20 22:17:36
---

Currently, the platforms we reach through Taro include:

* WeChat Mini Program
* QQ Mini Program
* Baidu Mini Program
* React Native
* H5
* Quick App

To quickly allow business to reach all platforms, each of our business modules is independent.

They are compatible with different platforms according to business needs, and then assembled into a complete project during build time.

To meet the above needs and enable flexible development, each business module can be independently developed and run, without depending on the main project.

Currently, the relationship between projects is already quite similar to `micro-frontend`.

Because most platforms (except `React Native`) cannot achieve hot updates, compared to micro-frontend architecture, mini programs cannot achieve `independent deployment`.

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d6454e7c0d292a7a302dc0d0bc9c8c48256752fc683e3f0e46b6591b201ad7b9.png)  

> Regarding Taro + React Native, there will be dedicated articles later introducing how we play with it.

Today I'll introduce the first problem we encountered in multi-business, multi-team, multi-platform code management: `Dependency Management Issues`

## Unified Dependency Management for All Projects

Because there are many business modules, our project differences must remain highly unified, including dependencies.

### Centralized Core Dependency Management

Now our team has developed dozens of cross-platform modules. For convenient management,

I've packaged all dependencies into an `npm package`, containing no business code, only stable dependencies.

All projects will introduce this core dependency to ensure all projects can run stably.

### Non-Core Dependency Version Management Issues

For non-core dependencies, we will use our self-developed `cli` tool to forcibly modify version numbers in package.json.

During continuous integration, all cross-platform projects will use this cli tool to modify project configuration before `npm install` executes. This includes our dependencies.

After we modify the `cli` tool, all cross-platform projects will update to the latest dependency configuration.

### Special Handling Methods for Individual Projects

After all project dependencies are unified, there will always be some special reasons why individual project dependencies will have some differences.

Here we must mention the `resolutions` property of `package.json`.

The `resolutions` field is used to resolve selective versions, allowing custom dependency versions through this feature.

This way npm will forcibly specify a certain version for multi-version coexisting versions, meeting specific needs of individual projects.

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/0a9ce7a425c583573c877efd0ce648a9c3992b90d4f272621a3850afa523cfa3.png)  

If I want to forcibly specify all `B` as version 2.0

Usage is as follows:

```json
// package.json 
// This way dependency library B is forcibly versioned
{
    "resolutions": {
        "B": "2.0.0"
    }
}
```

For explanations of resolutions, you can view more here:

https://classic.yarnpkg.com/zh-Hans/docs/selective-version-resolutions

Of course, you can also use this tool to forcibly specify dependency versions:

https://www.npmjs.com/package/npm-force-resolutions

## Third-Party Dependency Stability Issues

When developing front-end projects with long development cycles, we inevitably encounter dependency management problems.

When developing projects, we use many third-party libraries. These third-party dependency libraries update their code from time to time.

Third-party dependency library code updates can easily cause code runtime instability,

For example, a project that ran fine yesterday, another colleague who just took over reinstalled dependencies and the project completely won't run.

Or code that runs fine on your machine, thrown to the build machine and rebuilt, completely won't run.

Because too many third-party dependency libraries are used, often we can't quickly locate why the project won't run.

Especially when developing RN projects, a dependency update problem might take half a day to locate the culprit (I once wasted a lot of youth on this kind of thing).

## Lock NPM Dependency Versions

For those third-party npm packages you're not familiar with, or can't guarantee stability, my approach is to `directly lock version numbers`.

The earlier this is done, the better. Don't blindly believe third-party npm updates are always better performance.

It will make you suffer from time to time, wasting a lot of time finding out who affected your code's normal operation.

## How to Solve When Third-Party npm Packages Have Bugs?

### Upgrade Original npm Package Version
If you discover your third-party npm has a bug, don't blindly upgrade versions.

First step, you need to check this npm package's `changelog`. If it clearly fixes this bug,

then upgrade is recommended. But can't guarantee upgrading might bring other bugs.

### Fix Bug and Publish to Company Private Source

But I still recommend fixing this bug on the original version npm package, and modifying npm package name to company internal package, publish to company private npm source.

If npm version changes cause project instability, you can also narrow the investigation scope, quickly locate which npm library caused the problem.

For example: mobx => @company-source/mobx

### Tip: .npmrc Configuration

If you have third-party npm packages published to company private sources,

You can try modifying .npmrc file to use npm name scope to directly point to company private source

For example:

```bash
@company-source:registry=http://npm.xxx.com
@tarojs:registry=http://npm.xxx.com
```

## Development and Production Environments After Version Changes

If your current version changes are relatively frequent,

It's easy to produce inconsistencies between two environments after version changes, which might produce some subtle problems.

Here I still recommend: After each upgrade, completely delete the `node_modules` directory, reinstall dependencies. Especially on build machines.

The time spent installing dependencies, compared to the time spent investigating inexplicable problems, is actually `profitable`.

Of course, this is only when version changes are relatively frequent. If components start stabilizing,

Build machines are still recommended to start caching dependencies, which can reduce a lot of daily development time.

## About Dependency Installation Acceleration

Besides the well-known npm source switching, npm dependency executable file downloads will also slow down your dependency installation speed.

The following is our team's `.npmrc` configuration. For some npm dependency executable files,
You can use this configuration to accelerate your npm build speed.

You can also install `mirror-config-china` to accelerate your dependency installation speed

https://www.npmjs.com/package/mirror-config-china 

> .npmrc file location is in your home directory, you can also create this file in the project root directory.

This is our commonly used `.npmrc` configuration. We've integrated it into our cli tool. Every time cli executes, it updates its configuration.

Ensuring every teammate's development machine and build machine are consistent.

```
chromedriver-cdnurl=https://npm.taobao.org/mirrors/chromedriver
couchbase-binary-host-mirror=https://npm.taobao.org/mirrors/couchbase/v{version}
debug-binary-host-mirror=https://npm.taobao.org/mirrors/node-inspector
electron-mirror=https://npm.taobao.org/mirrors/electron/
flow-bin-binary-host-mirror=https://npm.taobao.org/mirrors/flow/v
fse-binary-host-mirror=https://npm.taobao.org/mirrors/fsevents
fuse-bindings-binary-host-mirror=https://npm.taobao.org/mirrors/fuse-bindings/v{version}
git4win-mirror=https://npm.taobao.org/mirrors/git-for-windows
gl-binary-host-mirror=https://npm.taobao.org/mirrors/gl/v{version}
grpc-node-binary-host-mirror=https://npm.taobao.org/mirrors
hackrf-binary-host-mirror=https://npm.taobao.org/mirrors/hackrf/v{version}
leveldown-binary-host-mirror=https://npm.taobao.org/mirrors/leveldown/v{version}
leveldown-hyper-binary-host-mirror=https://npm.taobao.org/mirrors/leveldown-hyper/v{version}
mknod-binary-host-mirror=https://npm.taobao.org/mirrors/mknod/v{version}
node-sqlite3-binary-host-mirror=https://npm.taobao.org/mirrors
node-tk5-binary-host-mirror=https://npm.taobao.org/mirrors/node-tk5/v{version}
nodegit-binary-host-mirror=https://npm.taobao.org/mirrors/nodegit/v{version}/
operadriver-cdnurl=https://npm.taobao.org/mirrors/operadriver
phantomjs-cdnurl=https://npm.taobao.org/mirrors/phantomjs
profiler-binary-host-mirror=https://npm.taobao.org/mirrors/node-inspector/
puppeteer-download-host=https://npm.taobao.org/mirrors
python-mirror=https://npm.taobao.org/mirrors/python
rabin-binary-host-mirror=https://npm.taobao.org/mirrors/rabin/v{version}
sass-binary-site=https://npm.taobao.org/mirrors/node-sass
sodium-prebuilt-binary-host-mirror=https://npm.taobao.org/mirrors/sodium-prebuilt/v{version}
sqlite3-binary-site=https://npm.taobao.org/mirrors/sqlite3
utf-8-validate-binary-host-mirror=https://npm.taobao.org/mirrors/utf-8-validate/v{version}
utp-native-binary-host-mirror=https://npm.taobao.org/mirrors/utp-native/v{version}
zmq-prebuilt-binary-host-mirror=https://npm.taobao.org/mirrors/zmq-prebuilt/v{version}
sentrycli_cdnurl=https://npm.taobao.org/mirrors/sentry-cli
```

## Afterword

Today I introduced how we manage dependencies.

Because we can unify all our project details, we've reduced too many unnecessary troubles during development.

This is also one of the most important steps for us to conveniently manage projects.

If everyone is interested in what functions our `cli` implements, I can write a separate article about it~

