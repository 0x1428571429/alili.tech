---
title: AngularJS Directive Template
slug: baa7d23b
date: 2015-05-21 22:17:36
keywords: AngularJS,Directive,directive,Template
categories: [Frontend]
tags: [AngularJS]
---

```javascript
myModule.directive('namespaceDirectiveName', function factory(injectables) {

    var directiveDefinitionObject = {
        restrict: string,// Directive usage method, including tag, attribute, class, comment
        priority: number,// Directive execution priority
        template: string,// Template used by directive, expressed as HTML string
        templateUrl: string,// Load template from specified url address
        replace: bool,// Whether to replace current element with template, if false, append to current element
        transclude: bool,// Whether to transfer current element's content to template
        scope: bool or object,// Specify directive's scope
        controller: function controllerConstructor($scope, $element, $attrs, $transclude){...},// Define interface function for interacting with other directives
        require: string,// Specify other directives that need to be depended on
        link: function postLink(scope, iElement, iAttrs) {...},// Programmatically manipulate DOM, including adding listeners, etc.
        compile: function compile(tElement, tAttrs, transclude){
            return: {

                pre: function preLink(scope, iElement, iAttrs, controller){...},
                post: function postLink(scope, iElement, iAttrs, controller){...}
            }

        }// Programmatically modify DOM template copy, can return link function
    };

    return directiveDefinitionObject;

});

```

