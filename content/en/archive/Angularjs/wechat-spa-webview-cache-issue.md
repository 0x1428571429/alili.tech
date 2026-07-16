---
title: A WeChat SPA Page Webview Cache Issue
categories: [Frontend]
tags: [AngularJS]
slug: wechat-spa-webview-cache-issue
keywords: SPA,Cache,AngularJS
date: 2017-02-22 16:14:25
---

## A Low-Level Problem

Because the company's WeChat project uses Angular routing for single-page applications. So page switching is done based on hash values.

We encountered a problem: every time we deploy new web code to the server.
On Android WeChat client, it always takes many days. Even requires uninstalling WeChat. After reopening the page, the page will update. (But there's no such problem on iPhone)

If a critical bug is encountered after the version is officially released. That would be a disaster.

## Solution

### Add Timestamp to URL

The first solution we thought of was to add a timestamp after the URL, like this:

```
xxx.com#/home/test/page/?t=(I am timestamp)
```

But the page showed no improvement on Android client


Why is this? Is it a bug in the WeChat client?


No, the timestamp was added in the wrong place.

Let's try another way.

```
xxx.com?t=(I am timestamp)#/home/test/page/
```

At this point, we found that the Android WeChat client cache problem was solved.



## A Question Raised

Why did the browser use cached code when we put the timestamp at the end?

First, let's look at the URL format:

```
protocol :// hostname[:port] / path / [;parameters][?query]#hash
```


We used the "?" separator for our timestamp, which is a query parameter.

The first time, we put the query parameter after "#". So our timestamp, the so-called query parameter, became a hash value.

No matter what symbol or character, as long as it's placed after "#", it's a hash value.

Because HTTP requests don't include hash, no matter how we modify the timestamp after the # sign, the request received by the server is the same.

Important things to say three times:

* HTTP requests don't include hash
* HTTP requests don't include hash
* HTTP requests don't include hash

