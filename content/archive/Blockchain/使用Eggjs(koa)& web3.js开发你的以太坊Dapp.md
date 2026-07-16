---
title: 使用Eggjs(koa) & web3.js开发你的以太坊Dapp
categories: [Blockchain]
tags: [Blockchain]
keywords: "区块链,以太坊,koa,eggjs,Solidity,truffle"
slug: 69a6fd18
date: 2018-10-10 19:33:33
---

# Eggjs

Eggjs 是阿里开源的企业级基于 Koa2 的 Node.js 框架.
eggjs 基本上是开箱即用,奉行『约定优于配置』.在日常开发中,用起来非常顺畅.
而且生态也比较完善,koa2 的插件都可以对接到框架中来.

## Egg.js 目录结构

```bash
egg-project
├── package.json
├── app.js (可选)
├── agent.js (可选)
├── app
|   ├── router.js
│   ├── controller
│   |   └── home.js
│   ├── service (可选)
│   |   └── user.js
│   ├── middleware (可选)
│   |   └── response_time.js
│   ├── schedule (可选)
│   |   └── my_task.js
│   ├── public (可选)
│   |   └── reset.css
│   ├── view (可选)
│   |   └── home.tpl
│   └── extend (可选)
│       ├── helper.js (可选)
│       ├── request.js (可选)
│       ├── response.js (可选)
│       ├── context.js (可选)
│       ├── application.js (可选)
│       └── agent.js (可选)
├── config
|   ├── plugin.js
|   ├── config.default.js
│   ├── config.prod.js
|   ├── config.test.js (可选)
|   ├── config.local.js (可选)
|   └── config.unittest.js (可选)
└── test
    ├── middleware
    |   └── response_time.test.js
    └── controller
        └── home.test.js
```

如上，由框架约定的目录：

- `app/router.js` 用于配置 URL 路由规则。
- `app/controller/**` 用于解析用户的输入，处理后返回相应的结果。
- `app/service/**` 用于编写业务逻辑层，可选，建议使用。
- `app/middleware/**` 用于编写中间件，可选。
- `app/public/**` 用于放置静态资源，可选，具体参见内置插件 [egg-static](https://github.com/eggjs/egg-static)。
- `app/extend/**` 用于框架的扩展，可选。
- `config/config.{env}.js` 用于编写配置文件。
- `config/plugin.js` 用于配置需要加载的插件。
- `test/**` 用于单元测试。
- `app.js` 和 `agent.js` 用于自定义启动时的初始化工作，可选。

由内置插件约定的目录：

- `app/public/**` 用于放置静态资源，可选，具体参见内置插件 [egg-static](https://github.com/eggjs/egg-static)。
- `app/schedule/**` 用于定时任务，可选。

**若需自定义自己的目录规范，参见 [Loader API](https://eggjs.org/zh-cn/advanced/loader.html)**

- `app/view/**` 用于放置模板文件，可选，由模板插件约定。
- `app/model/**` 用于放置领域模型，可选，由领域类相关插件约定，如 [egg-sequelize](https://github.com/eggjs/egg-sequelize)。

# web3.js

为了让你的 DAPP 能够访问区块链上的数据，一种选择是使用 web3.js 提供的 web3 对象。底层实现上，它通过 RPC 调用与本地节点通信。web3.js 可以与任何暴露了 RPC 接口的区块链节点连接。

# 引入方式

在 egg.js 自定义启动方式

```js
//app.js
"use strict";
const Web3 = require("web3");

module.exports = (app) => {
  app.beforeStart(async () => {
    const { config } = app;
    let originWeb3;
    // web3 初始化
    if (typeof originWeb3 !== "undefined") {
      console.warn(
        "Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask"
      );
      // Use Mist/MetaMask's provider
      originWeb3 = new Web3(originWeb3.currentProvider);
    } else {
      console.warn(
        `No web3 detected. Falling back to http://${config.web3.host}:${config.web3.port}. You should remove this fallback when you deploy live, as it\'s inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask`
      );
      // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
      originWeb3 = new Web3(
        new Web3.providers.HttpProvider(
          `http://${config.web3.host}:${config.web3.port}`
        )
      );
    }
    // 把web3js挂载到app下
    app.web3 = originWeb3;

    // 创建一个上下文,用来调用service的方法
    const ctx = app.createAnonymousContext();
    app.cities = await ctx.service.connection.getAdmin();
  });
};
```

# Service 层调用智能合约

```js
// app/service/
"use strict";
const Service = require("egg").Service;
const contract = require("truffle-contract");
// 引入只能合约
const stock_artifact = require("../../build/contracts/Stock.json");

//链接合约
const Stock = contract(stock_artifact);
let adminAddress;

let meta;
class ConnectionService extends Service {
  constructor(...args) {
    super(...args);
    this.web3 = this.app.web3;
  }
  setProvider() {
    Stock.setProvider(this.web3.currentProvider);
    // 解决apply报错
    if (typeof Stock.currentProvider.sendAsync !== "function") {
      Stock.currentProvider.sendAsync = function () {
        return Stock.currentProvider.send.apply(
          Stock.currentProvider,
          arguments
        );
      };
    }
  }

  getAccounts() {
    return new Promise((resolve, reject) => {
      this.setProvider();
      // Get the initial account balance so it can be displayed.
      // 使用web3.js 与只能合约交互
      this.web3.eth.getAccounts(function (err, accs) {
        if (err != null) {
          console.log("There was an error fetching your accounts.");
          reject("There was an error fetching your accounts.");
          return;
        }

        if (accs.length === 0) {
          console.log(
            "Couldn't get any accounts! Make sure your Ethereum client is configured correctly."
          );
          reject(
            "Couldn't get any accounts! Make sure your Ethereum client is configured correctly."
          );
          return;
        }
        this.accounts = accs;
        resolve(this.accounts);
      });
    });
  }

  getBalance(account) {
    return new Promise((resolve, reject) => {
      this.setProvider();
      Stock.deployed()
        .then(function (instance) {
          meta = instance;
          return meta.getBalance.call(account, { from: adminAddress });
        })
        .then(function (value) {
          resolve({
            shareLotsLength: value[0],
            total: value[1],
          });
        })
        .catch(function (e) {
          console.log(e);
          reject("Error 404");
        });
    });
  }

  // 添加用户
  async addMember(address, name, empNo) {
    if (!this.adminAddress) {
      await this.getAdmin();
    }
    this.setProvider();
    return new Promise((resolve, reject) => {
      Stock.deployed()
        .then((instance) => {
          meta = instance;
          return meta.addMember(address, name, Number(empNo), {
            from: adminAddress || "0x0000000000000000000000000000000000000000",
          });
        })
        .then((value) => {
          let args = "not found";
          for (let i = 0; i < value.logs.length; i++) {
            const log = value.logs[i];
            if (log.event === "addmember") {
              args = log.args;
              break;
            }
          }
          resolve(args);
        })
        .catch((e) => {
          console.log(e);
          reject("add Member error");
        });
    });
  }

  // 获取用户
  getAdmin() {
    return new Promise((resolve, reject) => {
      this.setProvider();
      Stock.deployed()
        .then((instance) => {
          return instance.getAdmin.call();
        })
        .then((value) => {
          adminAddress = value;
          resolve(value);
        })
        .catch((e) => {
          console.log(e);
          reject("getAdmin error");
        });
    });
  }
}

module.exports = ConnectionService;
```

完整 Demo: [https://github.com/Num142857/egg-block-chain](https://github.com/Num142857/egg-block-chain)

# Demo 使用方法

### 全局安装 truffle

```bash
npm install -g truffle
```

### 智能合约

```bash
# 转移
truffle migrate

#编译合约
truffle compile
```

### 本地开发

```bash
$ npm i
$ npm run dev
$ open http://localhost:7001/
```

### 部署

```bash
$ npm start
$ npm stop
```
