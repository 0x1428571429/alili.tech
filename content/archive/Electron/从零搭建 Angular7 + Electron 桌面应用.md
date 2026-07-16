---
title: 从零搭建 Angular7 + Electron 桌面应用
slug: i15aswl1v4s
date: 2018-12-18 19:02:36
keywords: Angular,Electron,Angular 7
categories: [Frontend]
tags: ['Electron','Angular']
---

#  Electron 是什么？
Electron 是一个可以用 JavaScript、HTML 和 CSS 构建桌面应用程序的库。这些应用程序能打包到 Mac、Windows 和 Linux 系统上运行，也能上架到 Mac 和 Windows 的 App Store。
意思就是说,你只要拥有前端开发的能力,也可以轻松开发跨平台的桌面应用.

## Electron的『主进程』和『渲染进程』
Electron 有两种进程：『主进程』和『渲染进程』。部分模块只能在两者之一上运行，而有些则无限制。主进程更多地充当幕后角色，而渲染进程则是应用程序的各个窗口。

### 主进程
主进程，通常是一个命名为 main.js 的文件，该文件是每个 Electron 应用的入口。它控制了应用的生命周期（从打开到关闭）。它既能调用原生元素，也能创建新的（多个）渲染进程。另外，Node API 是内置其中的。

### 渲染进程
渲染进程是应用的一个浏览器窗口。与主进程不同，它能存在多个（注：一个 Electron 应用只能存在一个主进程）并且相互独立（它也能是隐藏的）。

主窗口通常被命名为 index.html。它们就像典型的 HTML 文件，但 Electron 赋予了它们完整的 Node API。因此，这也是它与浏览器的区别。

## 进程之间的通讯 (IPC)
想要再网页里调用主进程的功能,比如关闭窗口,最小化全屏等主线程才能控制的功能.
Electron提供了通讯的机制,这就是IPC.后续会慢慢介绍IPC的使用.


# Angular7 + Electron
介绍完Electron的一些基础概念之后,
这里教大家徒手搭建一个基于ng7的桌面应用工程.

## 1. 安装最新`angular-cli`
```bash
npm i -g @angular/cli
```

## 2. 生成一个`angular`工程
```bash
ng new electro-angular7
```

## 3. 安装最新版`electron`
```bash
cd electro-angular7
npm install --save-dev electron@latest
```

## 4. 在项目根目录添加`主进程` main.js文件

```js
const { app, BrowserWindow , ipcMain } = require('electron');
const  path  = require('path')
// 保持对window对象的全局引用，如果不这么做的话，当JavaScript对象被
// 垃圾回收的时候，window对象将会自动的关闭
let win;
function createWindow () {
  // 创建浏览器窗口。
  win = new BrowserWindow({
    width: 1000,
    height: 670 ,
  });

  // 然后加载应用的 index.html。
  win.loadURL(`file://${__dirname}/dist/electro-angular7/index.html`);
  // 打开开发者工具
  win.webContents.openDevTools();


  // 当 window 被关闭，这个事件会被触发。
  win.on('closed', () => {
    // 取消引用 window 对象，如果你的应用支持多窗口的话，
    // 通常会把多个 window 对象存放在一个数组里面，
    // 与此同时，你应该删除相应的元素。
    win = null;
  });
}

// Electron 会在初始化后并准备
// 创建浏览器窗口时，调用这个函数。
// 部分 API 在 ready 事件触发后才能使用。
app.on('ready', createWindow);

// 当全部窗口关闭时退出。
app.on('window-all-closed', () => {
  // 在 macOS 上，除非用户用 Cmd + Q 确定地退出，
  // 否则绝大部分应用及其菜单栏会保持激活。
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  // 在macOS上，当单击dock图标并且没有其他窗口打开时，
  // 通常在应用程序中重新创建一个窗口。
  if (win === null) {
    createWindow();
  }
});

// 在这个文件中，你可以续写应用剩下主进程代码。
// 也可以拆分成几个文件，然后用 require 导入。


// ipc通讯相关代码
// 登录窗口最小化
ipcMain.on('window-min', function() {
  win.minimize();
});
// 登录窗口最大化
ipcMain.on('window-max', function() {
  if (win.isMaximized()) {
    win.restore();
  } else {
    win.maximize();
  }
});
ipcMain.on('window-close', function() {
  win.close();
});

```



## 5. package.json 文件修改

添加main.js的位置与npm scripts electron命令
```bash
{
  "scripts": {
    "electron": "electron .",
  },
    "main": "main.js",
}
```

## 6.修改index.html
找到 `src/index.html`
```html
<!-- 找到 -->
<base href="/">

<!-- 修改为: -->
<base href="./">
```

## 7. 跑起来
``` bash
# 构建你的angular应用
npm run build
# 启动electron程序
npm run electron
```
好了,今天就先到这里.后面会继续深挖Electron.
