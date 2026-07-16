---
title: Visual-Studio-Code隐藏从ts生成的额外js与map文件
categories: [Backend]
tags: [Node.js]
slug: b36fefc7
keywords:  Node.js,ts,map,typescript,Visual-Studio-Code,vscode
date: 2017-11-22 20:32:05
---

打开【文件】>【首选项】>【工作区设置】，放入以下代码：

```
// 将设置放入此文件中以覆盖默认值和用户设置。
{
    "files.exclude": {
        // exclude .js and .js.map files, when in a TypeScript project
        "node_modules": true,
        "**/*.js": { "when": "$(basename).ts"},
        "**/*.js.map": true
    }
}
```