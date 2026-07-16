---
title: 在你的React项目中使用Decorator 装饰器
categories: [Frontend]
tags: [React]
slug: a280911b
keywords: react,脚手架,mobx,装饰器
date: 2017-11-01 19:33:33
---

## 使用装饰器
> 目前只支持Babel/Typescript两种预编译器

### Babel:
```
npm install  babel-plugin-transform-decorators-legacy --save-dev
```

在你的 .babelrc配置文件中开启,没有 .babelrc文件的话,可以新建一个.
```
{
  "presets": [
    "es2015",
    "stage-1"
  ],
  "plugins": ["transform-decorators-legacy"]
}
```

插件的顺序千万要注意,非常重要：transform-decorators-legacy 应该放在插件的第一个。

当使用react native的时候，下面这个预设可以代替 transform-decorators-legacy

```
{
  "presets": ["stage-2", "react-native-stage-0/decorator-support"]
}
```

## 在create-react-app中使用装饰器

```
npm run eject
```

安装相关插件:
```
//针对react
npm install babel-preset-stage-2 --save-dev
npm install babel-preset-react-native-stage-0 --save-dev
```


根目录下创建.babelrc
{
  "presets": ["react-native-stage-0/decorator-support"]
}

## TypeScript

如果你的项目已经开始使用TypeScript,那我们只需要在tsconfig.json文件中的 experimentalDecorators 设置为 true

这样,我们就可以使用ES7新特性装饰器了


## 在vscode 移除不支持decorator特性的语法警告提示
在项目根目录创建tsconfig.json

```
{
    "compilerOptions": {
        "experimentalDecorators": true,
        "allowJs": true
    }
}
```
重启你的vscode,你会发现语法警告没有了.