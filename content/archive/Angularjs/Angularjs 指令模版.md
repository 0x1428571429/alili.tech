---
title: AngularJS 指令模版
slug: baa7d23b
date: 2015-05-21 22:17:36
keywords: AngularJS,指令,directive,模版
categories: [Frontend]
tags: [AngularJS]
---

```javascript
myModule.directive('namespaceDirectiveName', function factory(injectables) {

    var directiveDefinitionObject = {
        restrict: string,//指令的使用方式，包括标签，属性，类，注释
        priority: number,//指令执行的优先级
        template: string,//指令使用的模板，用HTML字符串的形式表示
        templateUrl: string,//从指定的url地址加载模板
        replace: bool,//是否用模板替换当前元素，若为false，则append在当前元素上
        transclude: bool,//是否将当前元素的内容转移到模板中
        scope: bool or object,//指定指令的作用域
        controller: function controllerConstructor($scope, $element, $attrs, $transclude){...},//定义与其他指令进行交互的接口函数
        require: string,//指定需要依赖的其他指令
        link: function postLink(scope, iElement, iAttrs) {...},//以编程的方式操作DOM，包括添加监听器等
        compile: function compile(tElement, tAttrs, transclude){
            return: {

                pre: function preLink(scope, iElement, iAttrs, controller){...},
                post: function postLink(scope, iElement, iAttrs, controller){...}
            }

        }//编程的方式修改DOM模板的副本，可以返回链接函数
    };

    return directiveDefinitionObject;

});

```
