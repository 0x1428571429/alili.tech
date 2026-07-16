---
title: AngularJS的按需加载(3)
slug: f9c22b08
date: 2016-06-01 23:55:35
keywords: AngularJS,按需加载,解决方案
categories: [Frontend]
tags: [AngularJS]
---

上一篇大概的描述了一下Angular的启动过程,

如果想要在自己的项目里,异步的加载第三方模块,就是按照上一篇的主要逻辑再跑一遍.

这样子,第三方的模块的方法才能全部加载到angular里.

<!-- more -->

```javascript
app.config([
  '$controllerProvider',
  '$compileProvider',
  '$filterProvider',
  '$provide',
  '$injector',
  function($controllerProvider, $compileProvider, $filterProvider, $provide, $injector) {

    //像第一篇说的那样,把内部方法暴露出来
    app.controller = $controllerProvider.register;
    app.directive = $compileProvider.directive;
    app.filter = $filterProvider.register;
    app.factory = $provide.factory;
    app.service = $provide.service;
    app.provider = $provide.provider;
    app.value = $provide.value;
    app.constant = $provide.constant;
    app.decorator = $provide.decorator;


    //并且定义一个全局的函数,方便以后随便调用
    //加载三方模块下的代码,
    window.addModule=function(moduleName){
      var module = angular.module(moduleName);
        var ngProviders = {
          '$controllerProvider': $controllerProvider,
          '$compileProvider': $compileProvider,
          '$filterProvider': $filterProvider,
          '$provide': $provide
        };

      if (module.requires) {
          for (var i = 0; i < module.requires.length; i++) {
              addModule(module.requires[i]);
          }
      }
      angular.forEach(module._invokeQueue, function(args) {
          var provider = ngProviders[args[0]] || $injector.get(args[0]);
          provider[args[1]].apply(provider, args[2]);
      });
      angular.forEach(module._configBlocks, function(args) {
          var provider = ngProviders.$injector.get(args[0]);
          provider[args[1]].apply(provider, args[2]);
      });
      angular.forEach(module._runBlocks, function(args) {
          $injector.invoke(args);
      });
    }

  }
]);
```
