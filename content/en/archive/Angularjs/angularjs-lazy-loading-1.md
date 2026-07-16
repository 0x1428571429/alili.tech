---
title: AngularJS Lazy Loading (1)
slug: angularjs-lazy-loading-1
date: 2016-05-30 16:14:25
keywords: AngularJS,Lazy Loading,Solution
categories: [Frontend]
tags: [AngularJS]
---
Today let's talk about a problem that has been bothering me for a long time. AngularJS lazy loading.

The benefits of Angular don't need to be mentioned here,
but after using it for a while, you'll find that all Controllers, Services, Directives, etc. of a website are loaded completely,
before the page starts running.

For small projects with little code, this doesn't feel like a big problem.

But when there are more pages, the main page becomes increasingly bloated. Useful and useless code are all loaded.
Although loading everything means the first page load will be much slower, subsequent pages will be extremely fast.
But this is not Smart at all.

So what can be done to achieve lazy loading?
<!-- more -->
Actually it's very simple, look at the code:
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

We need to replace Angular's methods with internal methods first,

so that we can properly lazy load Controllers, Services, Directives... later.

Next, we choose a module loader,
there are many popular loaders: Require.js, Sea.js, System.js, etc.

Let's choose the most classic Require.js;

Below is a small demo for lazy loading
[Github Demo](https://github.com/incomparable9527/demo.Angular-async)


Let's configure require's config first;

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


Next is app.js

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
Below is the template code, mainly to test if the controller loads successfully

```html
Hello, Li Yinhe;
<p>{ {message}}</p>
```


Below is the controller code
```javascript
define(['app'], function(app) {
    app.controller('testController', ['$scope', function($scope) {
        $scope.message='I am testController, successfully loaded and running';
    }])
})
```


Finally, at the end of app.bootstrap.js, add the following code to start Angular;
```javascript
require(['app'], function() {
    angular.bootstrap(document, ['app']);
    angular.element(document).find('html').addClass('ng-app');
});
```
Finally index.html
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
This way, we've completed the simplest lazy loading.

The above is all the code for example1;
That's all for today. In the coming time, I'll slowly explain the above code and the knowledge involved;
Also how to lazy load third-party modules, and the drawbacks of the above code;
