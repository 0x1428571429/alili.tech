---
title: Visual Studio Code Hide Extra js and map Files Generated from ts
categories: [Backend]
tags: [Node.js]
slug: b36fefc7
keywords: Node.js,ts,map,typescript,Visual-Studio-Code,vscode
date: 2017-11-22 20:32:05
---

Open 【File】>【Preferences】>【Workspace Settings】, put in the following code:

```
// Put settings in this file to override defaults and user settings.
{
    "files.exclude": {
        // exclude .js and .js.map files, when in a TypeScript project
        "node_modules": true,
        "**/*.js": { "when": "$(basename).ts"},
        "**/*.js.map": true
    }
}
```

