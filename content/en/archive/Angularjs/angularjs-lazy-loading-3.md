---
title: AngularJS Lazy Loading (3)
slug: angularjs-lazy-loading-3
date: 2016-06-01 23:55:35
keywords: AngularJS,Lazy Loading,Solution
categories: [Frontend]
tags: [AngularJS]
---

The previous article roughly described Angular's startup process,

If you want to asynchronously load third-party modules in your own project, you need to run through the main logic from the previous article again.

This way, all methods of third-party modules can be loaded into Angular.

<!-- more -->

```javascript
app.config([
  '$controllerProvider',
  '$compileProvider',
  '$filterProvider',
  '$provide',
  '$injector',
  function($controllerProvider, $compileProvider, $filterProvider, $provide, $injector) {

    //As mentioned in the first article, expose internal methods
    app.controller = $controllerProvider.register;
    app.directive = $compileProvider.directive;
    app.filter = $filterProvider.register;
    app.factory = $provide.factory;
    app.service = $provide.service;
    app.provider = $provide.provider;
    app.value = $provide.value;
    app.constant = $provide.constant;
    app.decorator = $provide.decorator;


    //And define a global function for easy future calls
    //Code for loading third-party modules,
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
