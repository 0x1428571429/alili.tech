---
title: Angular7 + Electron主进程与渲染进程通讯问题
slug: pw9ygknqvso
date: 2018-12-19 19:02:36
keywords: Angular,Electron,Angular 7
categories: [Frontend]
tags: ['Electron','Angular']
---

# Electron 中的进程分类
在 Electron 中，存在两种进程：`主进程`和`渲染进程`。


`渲染进程`你可以理解为view层,也就是我们非常熟悉的显示页面的进程.
在这里你可以调用nodejs接口的能力,也可以做我们已经非常熟悉的浏览器操作.
但是你想要调用主进程才能做的一些操作的时候,就需要一个通讯机制,告诉主进程你要干嘛干嘛.

# IPC通讯
## 渲染层向主进程发送通知

```js
//index.html,渲染进程发送通知
onst electron = require('electron')
const ipcRenderer = electron.ipcRenderer
ipcRenderer.send('main-process-messages','hellow')
```

```js
// main.js 主进程接收通知
const { ipcMain } = require('electron');
ipcMain.on('main-process-messages', function(event, message) {
  console.log(message)
});
```

## 主进程向渲染进程发送通知

```js
// main.js
mainWindow.webContents.send('main-process-messages', 'main-process-messages show')
```

```js
//index.html,渲染进程中接收消息
const electron = require('electron')
const ipcRenderer = electron.ipcRenderer
ipcRenderer.on('main-process-messages', function(event, message){
    alert(message)
})
```

# 在Angular工程中如何使用

当你在angular工程中直接`require('electron')`是会直接报错的.

```
ERROR in ./node_modules/electron/index.js
Module not found: Error: Can't resolve 'fs' in '###/node_modules/electron'
ERROR in ./node_modules/electron/index.js
Module not found: Error: Can't resolve 'path' in '###/node_modules/electron'
```
那我们该怎么办呢.

1. 创建一个 `electron.service.ts`

```js
// 示例代码
import { Injectable } from '@angular/core';
import {} from 'electron';
import Fs from 'fs';

@Injectable({
  providedIn: 'root'
})
export class ElectronService {
  constructor() {
        // check if platform is electron
        const isElectron: boolean = window && window['process'] && window['process'].type;

        if (isElectron) {
          const fs: typeof Fs = window['require']('fs');
          const app: Electron.App = window['require']('electron').remote;
        }
  }
  electron = window['require']('electron');
}

```

当我们需要electron的时候,直接引入这个service就好了.