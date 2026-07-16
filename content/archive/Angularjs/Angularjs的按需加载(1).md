---
title: AngularJS的按需加载(1)
slug: cbf4498a
date: 2016-05-30 16:14:25
keywords: AngularJS,按需加载,解决方案
categories: [Frontend]
tags: [AngularJS]
---
今天来聊一聊一直困扰了我很久的问题.AngularJS的按需加载.

angular的好处这里就不用多说,
但是用久了你会发现,一个网站所有的 Controller, Service, Directive等等,全部加载完了,
页面才开始跑.

小项目,代码少.不会感觉太大问题.

但是页面多了,那主页越来越臃肿.有用的,没用的通通加载进来.
虽说全部加载,页面第一次打开会慢很多,之后打开的页面速度会极快.
但是,这一点都不Smart.

那有什么办法可以做到按需加载呢?
<!-- more -->
其实很简单,看代码:
```javascript
app.config([
  '$controllerProvider',
  '$compileProvider',
  '$filterProvider',
  '$provide',
  function($controllerProvider, $compileProvider, $filterProvider, $provide) {
    app.controller = $controllerProvider.register;
    app.directive = $compileProvider.directive;
    app.filter = $filterProvider.register;
    app.factory = $provide.factory;
    app.service = $provide.service;
    app.provider = $provide.provider;
    app.value = $provide.value;
    app.constant = $provide.constant;
    app.decorator = $provide.decorator;
  }
]);
```

我们要先把angular的方法替换成内部使用的方法,

这样我们在后面才可以正常的按需加载Controller, Service, Directive...

接下来,我们选择一个模块加载器,
流行的加载器有很多,Require.js,Sea.js,System.js 等等.

选一个最经典的 Require.js;

下面是按需加载的小demo
[Github Demo](https://github.com/incomparable9527/demo.Angular-async)


我们先配置好,require的config;

app.bootstrap.js
```javascript
require.config({
    paths: {
        'angular': 'http://cdn.bootcss.com/angular.js/1.5.6/angular.min',
        'ui.router': 'http://cdn.bootcss.com/angular-ui-router/0.2.18/angular-ui-router.min',
        'app': 'app'
    },
    shim: {
        'ui.router': {
            deps: ['angular']
        }
    }});
```


接下来是 app.js

```javascript
define([
    'angular', 'ui.router'
], function() {
    var app = angular.module('app', ['ui.router']);

    app.config([
        '$controllerProvider',
        '$compileProvider',
        '$filterProvider',
        '$provide',
        function($controllerProvider, $compileProvider, $filterProvider, $provide) {
            app.controller = $controllerProvider.register;
            app.directive = $compileProvider.directive;
            app.filter = $filterProvider.register;
            app.factory = $provide.factory;
            app.service = $provide.service;
            app.provider = $provide.provider;
            app.value = $provide.value;
            app.constant = $provide.constant;
            app.decorator = $provide.decorator;
        }
    ]);

    app.config([
        '$stateProvider',
        '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
            $urlRouterProvider.otherwise('/home');
            $stateProvider.state('home', {
                url: '/home',
                templateUrl: 'view/testTemplate.html',
                controller: 'testController',
                resolve: {
                    deps: [
                        '$q',
                        '$rootScope',
                        function($q, $rootScope) {
                            var deferred = $q.defer();
                            require(['../view/testController'], function() {
                                $rootScope.$apply(deferred.resolve);
                            });
                            return deferred.promise;
                        }
                    ]
                }
            })
        }
    ])
return app;
})
```
下面是模版代码,主要是为了测试控制器是否加载成功

```html
你好呀,李银河;
<p>{ {message}}</p>
```


下面是控制器代码
```javascript
define(['app'], function(app) {
    app.controller('testController', ['$scope', function($scope) {
        $scope.message='我是testController,已经成功加载运行';
    }])
})
```


最后,在app.bootstrap.js的最后,加上下面的代码,启动Angular;
```javascript
require(['app'], function() {
    angular.bootstrap(document, ['app']);
    angular.element(document).find('html').addClass('ng-app');
});
```
最后 index.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
    <div ui-view></div>
    <script src="http://cdn.bootcss.com/require.js/2.2.0/require.min.js" data-main="script/app.bootstrap"></script>
</body>
</html>
```
这样,我们就完成了最简单的按需加载.

以上就是 example1的全部代码;
今天先到这里,接下来的时间里,会慢慢解释上面的代码,已经所涉及到的知识;
还有如何按需加载第三方module,以及以上代码的弊端;
