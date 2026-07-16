---
title: cheeriojs Chinese Parsed to Unicode Issue When Loading HTML
categories: [Backend]
tags: [Node.js]
slug: lbpnt17e1sc
keywords: [cheeriojs,nodejs]
date: 2018-11-29 20:32:05
---

## cheeriojs Parsing Chinese to Unicode Issue
When using `cheeriojs`, I found that whenever using the `html` method, Chinese will be parsed to unicode by default.

Usage is as follows:

```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将会被解析成unicode</title>');
console.log($('title').html());
```

When using the `text` method, the above problem doesn't occur

```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将会被解析成unicode</title>');
$('title').text()
```

## Solution

### Default Configuration

When we load html content, `cheerio` actually has default configuration.
HTML parsing uses the `htmlparser2` library, so `htmlparser2` configuration is also applicable in cheerio.
```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将会被解析成unicode</title>',{
    withDomLvl1: true,
    normalizeWhitespace: false,
    xmlMode: false,
    decodeEntities: true
});
```

### Modify Default Configuration
We just need to change `decodeEntities` to false to solve our problem.
```js
{
    decodeEntities: false
}
```

Like this
```js
var cheerio = require('cheerio');
var $ = cheerio.load('<title>我是中文,我将不会被解析成unicode</title>',{
    decodeEntities: false
});
```

