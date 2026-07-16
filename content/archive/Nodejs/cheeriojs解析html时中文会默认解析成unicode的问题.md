---
title: cheeriojs加载html时中文会默认解析成unicode的问题
categories: [Backend]
tags: [Node.js]
slug: lbpnt17e1sc
keywords: [cheeriojs,nodejs]
date: 2018-11-29 20:32:05
---

## cheeriojs 解析中文为unicode问题
在使用`cheeriojs`的时候我发现,每当使用`html`方法,中文会默认解析成 unicode.

使用方式如下:

```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将会被解析成unicode</title>');
console.log($('title').html());
```


当使用`text`方法的时候,并不会出现以上问题

```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将会被解析成unicode</title>');
$('title').text()
```


## 解决

### 默认配置

当我们load html内容的时候,其实`cheerio`是有默认配置的.
html解析是使用的`htmlparser2`这个库,所以`htmlparser2`的配置在cheerio也是适用的.
```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将会被解析成unicode</title>',{
    withDomLvl1: true,
    normalizeWhitespace: false,
    xmlMode: false,
    decodeEntities: true
});
```

### 修改默认配置
我们只需要将`decodeEntities`修改成 false,就可以解决我们的问题.
```js
{
    decodeEntities: false
}
```


像这样
```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将不会被解析成unicode</title>',{
    decodeEntities: false
});
```