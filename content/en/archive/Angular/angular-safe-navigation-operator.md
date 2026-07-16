---
title: Angular Template Safe Navigation Operator ( ?. )
slug: angular-safe-navigation-operator
date: 2018-11-25 22:17:36
keywords: [Angular,Safe Navigation,Template]
categories: [Frontend]
tags: [Angular]
---
This is very practical and frequently used operator in Angular development.
React and Vue don't have this feature natively.

# Safe Navigation Operator ( ?. )
In our daily development, when accessing property paths.

If for some reason the path contains `null` or `undefined`, and we continue to access properties, the entire program will crash, preventing the program from continuing to run.

Here's an example:
```js
var obj ={
    a:1,
    b:{  // Sometimes, this property might not exist
        c:2,
        d:3 
    }
}
obj.a // Normal access
obj.b // If this property sometimes doesn't exist, accessing it will only return undefined, won't cause an error
obj.b.c // When property b doesn't exist, accessing properties on undefined will definitely cause the program to crash
```
Safe navigation solves the above problem. We just need to change the `.` before uncertain properties to `?.` to avoid errors. When no value is found, it will default to empty.


```js
{{ obj?.b?.c }}
```

Isn't it convenient when writing templates? It's amazing~

Mom no longer needs to worry about strange backend data causing frontend errors~~~~~

