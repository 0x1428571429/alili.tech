---
title: AngularJS Lazy Loading (2)
slug: angularjs-lazy-loading-2
date: 2016-05-31 20:34:35
keywords: AngularJS,Lazy Loading,Solution
categories: [Frontend]
tags: [AngularJS]
---
In the previous article, we implemented the simplest AngularJS lazy loading,

by replacing Angular's internal methods and using require.js with $q to complete lazy loading.

Today let's talk about how Angular lazy loads third-party modules;

Before that, we need to understand how Angular starts.

![](https://sfault-image.b0.upaiyun.com/179/316/1793163034-56fde93e313cd_articlex)

<!-- more -->
##### setupModuleLoader Method

In the above figure, we need to pay attention to a very important method;

setupModuleLoader method, as the name suggests - module loader;

The object returned by this method is:

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
Looking at this object format, does it look familiar?

When we run

```
angular.module('app',[]);

//or

angular.module('app')
```
When we create a new module or get a module,
what's returned is this object.

When we do chaining operations,
angular.module('app',[]).config().run().controller();

Each step returns itself, so we can do chaining operations;


After Angular initialization is complete, it starts looking for the ng-app attribute in the DOM;

After finding ng-app, it gets the value of ng-app before starting Angular;
Internally runs the bootstrap method;

If you want to manually start, you can also do this:

```
angular.bootstrap(document, ['moduleName']);
```
What does Angular do when bootstrapping?

#### doBootstrap Method
In the bootstrap method in the source code, there's a doBootstrap method:

```javascript

  var doBootstrap = function() {
    element = jqLite(element);
    //Check if already bootstrapped
    if (element.injector()) {
      var tag = (element[0] === document) ? 'document' : startingTag(element);
      throw ngMinErr(
          'btstrpd',
          "App Already Bootstrapped with this Element '{0}'",
          tag.replace(/</,'&lt;').replace(/>/,'&gt;'));
    }

    //angular.bootstrap(document, ['moduleName']);
    //Here modules is the moduleName we passed in during bootstrap
    //modules ==> ['moduleName']
    modules = modules || [];
    modules.unshift(['$provide', function($provide) {
      $provide.value('$rootElement', element);
    }]);

    .....

    //Key point: createInjector
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

#### createInjector Method

Let's see what this method mainly does

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

  //Key point!!! Here modulesToLoad is the parameter we passed in earlier
  //modulesToLoad ==> ['moduleName']
  var runBlocks = loadModules(modulesToLoad);
  instanceInjector = protoInstanceInjector.get('$injector');
  instanceInjector.strictDi = strictDi;

  forEach(runBlocks, function(fn) { if (fn) instanceInjector.invoke(fn); });

  return instanceInjector;
...
//Some declared functions
}

```


#### loadModules Method

```javascript
  function loadModules(modulesToLoad) {
  //Check if modulesToLoad is an array
  //assertArg function is for error reporting
    assertArg(isUndefined(modulesToLoad) || isArray(modulesToLoad), 'modulesToLoad', 'not an array');

    var runBlocks = [], moduleFn;
    //Start iterating
    forEach(modulesToLoad, function(module) {
      if (loadedModules.get(module)) return;
      loadedModules.put(module, true);

     //Declare a call function, this is a very important function for future lazy loading
      function runInvokeQueue(queue) {
        var i, ii;
        for (i = 0, ii = queue.length; i < ii; i++) {
          var invokeArgs = queue[i],
              provider = providerInjector.get(invokeArgs[0]);

          provider[invokeArgs[1]].apply(provider, invokeArgs[2]);
        }
      }

      try {
      //Now we've got our moduleName
        if (isString(module)) {
        //angularModule is actually the setupModuleLoader method mentioned earlier,
        //so of course it returns the moduleInstance object, which is what we mentioned
          moduleFn = angularModule(module);

          //Extract all runBlocks from the module
          runBlocks = runBlocks.concat(loadModules(moduleFn.requires)).concat(moduleFn._runBlocks);
          //Then start calling the method above
          //Start iterating through and executing the methods instantiated by setupModuleLoader through the runInvokeQueue method
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
            //Some exception handling

      }
    });
    return runBlocks;
  }
```
The above is Angular's main method for loading modules
