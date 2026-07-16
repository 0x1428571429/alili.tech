---
title: 利用Chrome DevTools调试Node.js
categories: [Backend]
tags: [Node.js]
slug: bd292cd9
keywords:  Node.js,ts,DevTools,nodejs,debugging,浏览器
date: 2017-08-08 00:04:05
---

## 前提
* Node.js 6.3+；
* Chrome 55+;

## 配置Chrome (最新的版本已经不需要这一步);
1. 输入url：chrome://flags/#enable-devtools-experiments 进入开发者实验室

2. 启用加亮的选项

3. 重启Chrome

4. 打开 DevTools Setting -> Experiments; 

5. 连续按Shift 6次,显示隐藏的选项

6. 找到 Node debugging,并且勾上. (新版本已经没有这个选项,默认就是开启状态.所以chrome就不用配置了)

![](http://files.jb51.net/file_images/article/201702/2017216143309201.png?2017116143318)


## 运行Node.js

只要在命令语句 加上 --inspect,后面跟上你想要执行的文件;

```
node --inspect app.js 
```

![](https://static.alili.tech/images/debug.png)

复制控制台输出的:

 chrome-devtools:// 协议地址

> chrome-devtools://devtools/remote/serve_file/xxxxxxxxx

粘贴到浏览器地址栏,你就可以使用Chrome的控制台调试你的node应用了.