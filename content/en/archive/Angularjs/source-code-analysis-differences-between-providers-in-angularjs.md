---
title: Source Code Analysis of Small Differences Between Providers in AngularJS
categories: [Frontend]
tags: [AngularJS]
slug: 41effd04
keywords: AngularJS,Provider,Source Code Analysis
date: 2016-02-22 16:14:25
---

# AngularJS Provider

Angular has the following methods for creating providers:
* provider()
* service()
* factory()



## Provider Usage

```javascript
angular.module("app", [])
.provider("HelloAngular", function() {
    return {
        $get: function() {
            var name = "Xiaoming";
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


## Service Usage
```javascript
angular.module("app", [])
.service("HelloAngular", function() {
    this.name = "Xiaoming";
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

## Factory Usage

```javascript
angular.module("app", [])
.factory("HelloAngular", function() {
    var name = "Xiaoming";
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


Implementation methods each have differences, but usage is exactly the same

## AngularJS Source Code Analysis

```javascript
function provider(name, provider_) {
    if (isFunction(provider_)) {
        provider_ = providerInjector.instantiate(provider_);
    }
    if (!provider_.$get) {
        throw Error('Provider ' + name + ' must define $get factory method.');
    }
    return providerCache[name + providerSuffix] = provider_;
}

//Finally returns a provider
function factory(name, factoryFn) { return provider(name, { $get: factoryFn }); }

//First becomes factory, but factory finally returns a provider
function service(name, constructor) {
    return factory(name, ['$injector', function($injector) {
        return $injector.instantiate(constructor);
    }]);
}

```
> All revolve around provider making small modifications, achieving various provider methods.

