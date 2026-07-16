---
title: 烦人的AngularJS注解 - grunt-ng-annotate的使用
slug: c38cfa0d
date: 2015-06-12 23:15:00
keywords: AngularJS,annotate,注解,grunt,自动化,持续集成
categories: [Frontend, DevOps]
tags: [AngularJS,CI/CD]
---

angular加入了依赖注入

编写代码的时候,大致的写法如下
```javascript
  app.controller('tempController', function($scope, $http, $state, $timeout) {

    ...

   })
```

可是这样的代码,压缩后会造成一个问题.
函数的参数:$scope, $http, $state, $timeout会变成: a,b,c,d

导致这个函数找不到需要注入的服务,因为每个参数的命名都是严格规定的.

如下:
```javascript
  app.controller('tempController', function(a,b,c,d) {

    ...

   })
```
<!-- more -->
为了解决这个问题,angular支持如下写法:
```javascript
  app.controller('tempController', ["$scope", "$http", "$state", "$timeout", function($scope, $http, $state, $timeout) {



   }])
```


那么问题来了:

每一次添加一个服务的时候,都需要写两遍.
每一次删除一个服务的时候,都需要删两遍.

表示大大降低了变成的愉悦.

那么我们怎么解决这个问题呢?

今天的主角来了,那就是grunt-ng-annotate

这是一个grunt的插件,当然在glup上也有.因为我的项目主要是用grunt写的.
那么这次主要讲grunt版本的ng-annotate.


首先我们需要安装ng-annotate:

```
npm install grunt-ng-annotate --save-dev
```

在你的Gruntfile里运行这个插件:
```
grunt.loadNpmTasks('grunt-ng-annotate');
```


配置代码:
```JavaScript
grunt.initConfig({
  ngAnnotate: {
    dist: {
      files: [{
        expand: true,
        cwd: '<%= yeoman.dist %>', //相对路径
        src: '**/*Controller.js',  //需要匹配的文件
        dest: '<%= yeoman.dist %>' //文件输出的路径
      }]
    }
  }
})
```

js代码在函数里加入 "ngInject":
```javascript
  app.controller('tempController', function($scope, $http, $state, $timeout) {
    "ngInject";
    ...

   })
```

一切准备完毕,我们在控制台输入命令

```
grunt ngAnnotate
```


最后我们的代码就变成了下面这个样子

```javascript
  app.controller('tempController', ["$scope", "$http", "$state", "$timeout", function(a, b, c, d) {


   }])
```


这个插件还支持另外一种方式,比如我们的js代码写成:

```javascript
//因为我的项目使用了模块加载器,而我又不想代码嵌套太多层
//所以我就写成下面的样子了
define(function(require) {
  require('app').controller('tempController',controller)
  function controller($scope, $rootScope, $http, $state, $timeout) {
  "ngInject";

  }
})
```

最后生成:

```javascript
define(function(require) {
  require('app').controller('tempController',Controller)
  function controller(a, b, c, d) {
  "ngInject";

  }
  controller.$inject = ["$scope", "$http", "$state", "$timeout"];
})
```

OK,再也不用写两次注解了.
