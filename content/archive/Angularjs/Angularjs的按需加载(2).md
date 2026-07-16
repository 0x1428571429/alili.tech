---
title: AngularJS的按需加载(2)
slug: e0d91a49
date: 2016-05-31 20:34:35
keywords: AngularJS,按需加载,解决方案
categories: [Frontend]
tags: [AngularJS]
---
上一篇我们实现了最简单的AngularJS的按需加载,

可以通过替换Angular的内部方法,再使用require.js配合$q完成了按需加载.

今天来说说Angular如何按需加载第三方module;

在此之前,我们得先弄清楚Angular是如何启动的.

![](https://sfault-image.b0.upaiyun.com/179/316/1793163034-56fde93e313cd_articlex)

<!-- more -->
##### setupModuleLoader方法

在上图中,我们得注意一个非常主要的方法;

setupModuleLoader方法,顾名思义 —— 模块加载器;

此方法最后返回的对象为:

```javascript
var moduleInstance = {
    _invokeQueue: invokeQueue,
    _runBlocks: runBlocks,
    requires: requires,
    name: name,
    provider: invokeLater('$provide', 'provider'),
    factory: invokeLater('$provide', 'factory'),
    service: invokeLater('$provide', 'service'),
    value: invokeLater('$provide', 'value'),
    constant: invokeLater('$provide', 'constant', 'unshift'),
    animation: invokeLater('$animateProvider', 'register'),
    filter: invokeLater('$filterProvider', 'register'),
    controller: invokeLater('$controllerProvider', 'register'),
    directive: invokeLater('$compileProvider', 'directive'),
    config: config,
    run: function(block) {
        runBlocks.push(block);
        return this;
    }
}
```
看着这对象的格式,有没有特别熟悉?

当我们运行

```
angular.module('app',[]);

//或者

angular.module('app')
```
我们新建一个module或者获取一个module的时候,
返回的就是这个对象.

当我们做链式操作的时候,
angular.module('app',[]).config().run().controller();

每一步操作,返回的都是它,所以我们才可以做链式操作;


当angular初始化完成之后,开始在dom里寻找ng-app属性;

当找到ng-app后,拿到ng-app的value后才开始启动 angular;
内部运行bootstrap方法;

如果要选择手动启动的话也可以这样:

```
angular.bootstrap(document, ['moduleName']);
```
当bootstrap的时候angular在做什么呢?

#### doBootstrap方法
在源码里中的bootstrap方法里有一个doBootstrap方法:

```javascript

  var doBootstrap = function() {
    element = jqLite(element);
    //判断是否启动
    if (element.injector()) {
      var tag = (element[0] === document) ? 'document' : startingTag(element);
      throw ngMinErr(
          'btstrpd',
          "App Already Bootstrapped with this Element '{0}'",
          tag.replace(/</,'&lt;').replace(/>/,'&gt;'));
    }

    //angular.bootstrap(document, ['moduleName']);
    //这里的modules就是之前我们bootstrap时候传进来的 moduleName
    //modules ==> ['moduleName']
    modules = modules || [];
    modules.unshift(['$provide', function($provide) {
      $provide.value('$rootElement', element);
    }]);

    .....

    //重点来了 createInjector
    var injector = createInjector(modules, config.strictDi);

    injector.invoke(['$rootScope', '$rootElement', '$compile', '$injector',
       function bootstrapApply(scope, element, compile, injector) {
        scope.$apply(function() {
          element.data('$injector', injector);
          compile(element)(scope);
        });
      }]
    );
    return injector;
  };

```

#### createInjector方法

我们看这个方法主要做了什么

```javascript
function createInjector(modulesToLoad, strictDi) {
  strictDi = (strictDi === true);
  var INSTANTIATING = {},
      providerSuffix = 'Provider',
      path = [],
      loadedModules = new HashMap([], true),
      providerCache = {
        $provide: {
            provider: supportObject(provider),
            factory: supportObject(factory),
            service: supportObject(service),
            value: supportObject(value),
            constant: supportObject(constant),
            decorator: decorator
          }
      },
      providerInjector = (providerCache.$injector =
          createInternalInjector(providerCache, function(serviceName, caller) {
            if (angular.isString(caller)) {
              path.push(caller);
            }
            throw $injectorMinErr('unpr', "Unknown provider: {0}", path.join(' <- '));
          })),
      instanceCache = {},
      protoInstanceInjector =
          createInternalInjector(instanceCache, function(serviceName, caller) {
            var provider = providerInjector.get(serviceName + providerSuffix, caller);
            return instanceInjector.invoke(
                provider.$get, provider, undefined, serviceName);
          }),
      instanceInjector = protoInstanceInjector;

  providerCache['$injector' + providerSuffix] = { $get: valueFn(protoInstanceInjector) };

  //重点!!! 这里的modulesToLoad 就是我们之前传进来的参数
  //modulesToLoad ==> ['moduleName']
  var runBlocks = loadModules(modulesToLoad);
  instanceInjector = protoInstanceInjector.get('$injector');
  instanceInjector.strictDi = strictDi;

  forEach(runBlocks, function(fn) { if (fn) instanceInjector.invoke(fn); });

  return instanceInjector;
...
//声明的一些函数
}

```


#### loadModules方法

```javascript
  function loadModules(modulesToLoad) {
  //判断modulesToLoad 传进来的是不是一个数组
  //assertArg函数是报错用的
    assertArg(isUndefined(modulesToLoad) || isArray(modulesToLoad), 'modulesToLoad', 'not an array');

    var runBlocks = [], moduleFn;
    //开始遍历
    forEach(modulesToLoad, function(module) {
      if (loadedModules.get(module)) return;
      loadedModules.put(module, true);

     //声明一个调用函数,这个为以后按需加载很重要的函数
      function runInvokeQueue(queue) {
        var i, ii;
        for (i = 0, ii = queue.length; i < ii; i++) {
          var invokeArgs = queue[i],
              provider = providerInjector.get(invokeArgs[0]);

          provider[invokeArgs[1]].apply(provider, invokeArgs[2]);
        }
      }

      try {
      //现在我们拿到了我们的moduleName
        if (isString(module)) {
        //angularModule其实就是之前的setupModuleLoader方法,
        //那当然他返回的就是moduleInstance对象,也就是说的那个
          moduleFn = angularModule(module);

          //把模块里的runBlocks都取出来
          runBlocks = runBlocks.concat(loadModules(moduleFn.requires)).concat(moduleFn._runBlocks);
          //然后开始调用上面的方法
          //开始通过runInvokeQueue方法遍历执行 之前setupModuleLoader实例化的方法
          runInvokeQueue(moduleFn._invokeQueue);
          runInvokeQueue(moduleFn._configBlocks);
        } else if (isFunction(module)) {
            runBlocks.push(providerInjector.invoke(module));
        } else if (isArray(module)) {
            runBlocks.push(providerInjector.invoke(module));
        } else {
          assertArgFn(module, 'module');
        }
      } catch (e) {
            ....
            //一些对于异常的处理

      }
    });
    return runBlocks;
  }
```
 以上就是angular加载模块的主要方法
