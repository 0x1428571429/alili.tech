---
title: Angular Template Safe Navigation ( ?. )
slug: f16eaj0p4la
date: 2018-11-25 22:17:36
keywords: [Angular,Safe Navigation,Template]
categories: [Frontend]
tags: [Angular]
---

This is very practical, also an operator frequently used in Angular development.
While react and vue don't natively have such features.

# Safe Navigation Operator ( ?. )
In our daily development, when accessing property paths.

If due to some objective reasons path contains `null`, `undefined`, then accessing further, entire program will directly error. Causing program cannot continue running.

For example
```js
var obj ={
    a:1,
    b:{  // Sometimes, this property might not exist
        c:2,
        d:3 
    }
}
obj.a // Normal access
obj.b // If this property sometimes doesn't exist, accessing like this only gets undefined, won't error
obj.b.c // When b property doesn't exist, accessing under undefined will absolutely cause program crash
```
Safe navigation is to solve the above problems, we just need to change `.` before uncertain property to `?.` can avoid errors, when value not found, will default to empty.


```js
{{ obj?.b?.c }}
```

Isn't it very convenient when writing templates? Simply can't be better~

Mom no longer needs to worry about backend giving strange data causing front-end errors~~~~~

