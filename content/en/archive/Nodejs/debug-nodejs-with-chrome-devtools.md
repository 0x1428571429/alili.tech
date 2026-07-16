---
title: Debug Node.js with Chrome DevTools
categories: [Backend]
tags: [Node.js]
slug: bd292cd9
keywords: Node.js,ts,DevTools,nodejs,debugging,Browser
date: 2017-08-08 00:04:05
---

## Prerequisites
* Node.js 6.3+;
* Chrome 55+;

## Configure Chrome (Latest versions no longer need this step);
1. Enter URL: chrome://flags/#enable-devtools-experiments to enter Developer Lab

2. Enable highlighted option

3. Restart Chrome

4. Open DevTools Setting -> Experiments; 

5. Press Shift 6 times consecutively to show hidden options

6. Find Node debugging and check it. (New versions no longer have this option, it's enabled by default. So Chrome doesn't need configuration)

![](http://files.jb51.net/file_images/article/201702/2017216143309201.png?2017116143318)

## Run Node.js

Just add --inspect to the command, followed by the file you want to execute;

```
node --inspect app.js 
```

![](https://static.alili.tech/images/debug.png)

Copy the console output:

 chrome-devtools:// protocol address

> chrome-devtools://devtools/remote/serve_file/xxxxxxxxx

Paste it into the browser address bar, and you can use Chrome's console to debug your node application.

