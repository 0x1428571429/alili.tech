---
title: Annoying AngularJS Annotations - Using grunt-ng-annotate
slug: c38cfa0d
date: 2015-06-12 23:15:00
keywords: AngularJS,annotate,Annotation,grunt,Automation,Continuous Integration
categories: [Frontend, DevOps]
tags: [AngularJS,CI/CD]
---

Angular added dependency injection

When writing code, roughly written as follows
```javascript
  app.controller('tempController', function($scope, $http, $state, $timeout) {

    ...

   })
```

But such code, after compression will cause a problem.
Function parameters: $scope, $http, $state, $timeout will become: a,b,c,d

Causing this function cannot find services to inject, because each parameter's naming is strictly required.

As follows:
```javascript
  app.controller('tempController', function(a,b,c,d) {

    ...

   })
```
<!-- more -->
To solve this problem, angular supports the following writing:
```javascript
  app.controller('tempController', ["$scope", "$http", "$state", "$timeout", function($scope, $http, $state, $timeout) {



   }])
```


Then the problem comes:

Every time adding a service, need to write twice.
Every time deleting a service, need to delete twice.

Greatly reduces coding pleasure.

So how do we solve this problem?

Today's protagonist comes, that's grunt-ng-annotate

This is a grunt plugin, of course also available on gulp. Because my project mainly uses grunt.
So this time mainly talk about grunt version ng-annotate.


First we need to install ng-annotate:

```
npm install grunt-ng-annotate --save-dev
```

Run this plugin in your Gruntfile:
```
grunt.loadNpmTasks('grunt-ng-annotate');
```


Configuration code:
```JavaScript
grunt.initConfig({
  ngAnnotate: {
    dist: {
      files: [{
        expand: true,
        cwd: '<%= yeoman.dist %>', //Relative path
        src: '**/*Controller.js',  //Files to match
        dest: '<%= yeoman.dist %>' //File output path
      }]
    }
  }
})
```

Add "ngInject" in function in js code:
```javascript
  app.controller('tempController', function($scope, $http, $state, $timeout) {
    "ngInject";
    ...

   })
```

Everything ready, we enter command in console

```
grunt ngAnnotate
```


Finally our code becomes like this

```javascript
  app.controller('tempController', ["$scope", "$http", "$state", "$timeout", function(a, b, c, d) {


   }])
```


This plugin also supports another way, for example our js code written as:

```javascript
//Because my project uses module loader, and I don't want code nested too many layers
//So I wrote it like below
define(function(require) {
  require('app').controller('tempController',controller)
  function controller($scope, $rootScope, $http, $state, $timeout) {
  "ngInject";

  }
})
```

Finally generates:

```javascript
define(function(require) {
  require('app').controller('tempController',Controller)
  function controller(a, b, c, d) {
  "ngInject";

  }
  controller.$inject = ["$scope", "$http", "$state", "$timeout"];
})
```

OK, no need to write annotations twice anymore.

