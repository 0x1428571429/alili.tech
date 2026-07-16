---
title: 源码分析AngularJS中的Provider们的小小区别
categories: [Frontend]
tags: [AngularJS]
slug: 41effd04
keywords: AngularJS,Provider,源码分析
date: 2016-02-22 16:14:25
---
# AngularJS的provider

Angular中有以下创建供应商(provider)的方法:
* provider()
* service()
* factory()



## Provider使用方式

```javascript
angular.module("app", [])
.provider("HelloAngular", function() {
    return {
        $get: function() {
            var name = "小明";
            function getName() {
                return name;
            }
            return {
                getName: getName
            }
        }
    }
})
.controller('MyCtrl', ['$scope', 'HelloAngular',
    function($scope, helloAngular) {
        $scope.gameName = helloAngular.getName();
    }
]);
```


## Service使用方式
```javascript
angular.module("app", [])
.service("HelloAngular", function() {
    this.name = "小明";
    this.getName=function(){
        return this.name;
    }
})
.controller('MyCtrl', ['$scope', 'HelloAngular',
    function($scope, helloAngular) {
        $scope.gameName = helloAngular.getName();
    }
]);
```

## Factory使用方式

```javascript
angular.module("app", [])
.factory("HelloAngular", function() {
    var name = "小明";
    function getName(){
        return name;
    }
    return {
    	getName:getName
    };
})
.controller('MyCtrl', ['$scope', 'HelloAngular',
    function($scope, helloAngular) {
        $scope.gameName = helloAngular.getName();
    }
]);
```


实现方法各有区别,但是使用上都是一模一样的

## angularJs源码分析

``` javascript
function provider(name, provider_) {
    if (isFunction(provider_)) {
        provider_ = providerInjector.instantiate(provider_);
    }
    if (!provider_.$get) {
        throw Error('Provider ' + name + ' must define $get factory method.');
    }
    return providerCache[name + providerSuffix] = provider_;
}

//最终还是返回一个provider
function factory(name, factoryFn) { return provider(name, { $get: factoryFn }); }

//先变成factory,但是factory最终还是返回一个provider
function service(name, constructor) {
    return factory(name, ['$injector', function($injector) {
        return $injector.instantiate(constructor);
    }]);
}

```
> 都是围绕provider做着小小的修改,而实现了各种方式的供应商.