---
title: Develop Your Ethereum Dapp with Eggjs(koa) & web3.js
categories: [Blockchain]
tags: [Blockchain]
keywords: "Blockchain,Ethereum,koa,eggjs,Solidity,truffle"
slug: 69a6fd18
date: 2018-10-10 19:33:33
---

# Eggjs

Eggjs is Alibaba's open source enterprise-level Node.js framework based on Koa2.
eggjs is basically out-of-the-box, follows "Convention over Configuration". In daily development, very smooth to use.
And ecosystem is also relatively complete, koa2 plugins can all be integrated into framework.

## Egg.js Directory Structure

```bash
egg-project
├── package.json
├── app.js (optional)
├── agent.js (optional)
├── app
||   ├── router.js
│   ├── controller
│   |   └── home.js
│   ├── service (optional)
│   |   └── user.js
│   ├── middleware (optional)
│   |   └── response_time.js
│   ├── schedule (optional)
│   |   └── my_task.js
│   ├── public (optional)
│   |   └── reset.css
│   ├── view (optional)
│   |   └── home.tpl
│   └── extend (optional)
│       ├── helper.js (optional)
│       ├── request.js (optional)
│       ├── response.js (optional)
│       ├── context.js (optional)
│       ├── application.js (optional)
│       └── agent.js (optional)
├── config
||   ├── plugin.js
||   ├── config.default.js
│   ├── config.prod.js
||   ├── config.test.js (optional)
||   ├── config.local.js (optional)
||   └── config.unittest.js (optional)
└── test
    ├── middleware
    |   └── response_time.test.js
    └── controller
        └── home.test.js
```

As above, directories agreed by framework:

- `app/router.js` Used to configure URL routing rules.
- `app/controller/**` Used to parse user input, process and return corresponding results.
- `app/service/**` Used to write business logic layer, optional, recommend using.
- `app/middleware/**` Used to write middleware, optional.
- `app/public/**` Used to place static resources, optional, see built-in plugin [egg-static](https://github.com/eggjs/egg-static).
- `app/extend/**` Used for framework extensions, optional.
- `config/config.{env}.js` Used to write configuration files.
- `config/plugin.js` Used to configure plugins to load.
- `test/**` Used for unit tests.
- `app.js` and `agent.js` Used for custom startup initialization work, optional.

Directories agreed by built-in plugins:

- `app/public/**` Used to place static resources, optional, see built-in plugin [egg-static](https://github.com/eggjs/egg-static).
- `app/schedule/**` Used for scheduled tasks, optional.

**If need to customize your own directory conventions, see [Loader API](https://eggjs.org/zh-cn/advanced/loader.html)**

- `app/view/**` Used to place template files, optional, agreed by template plugin.
- `app/model/**` Used to place domain models, optional, agreed by domain-related plugins, like [egg-sequelize](https://github.com/eggjs/egg-sequelize).

# web3.js

To make your DAPP able to access blockchain data, one option is to use web3 object provided by web3.js. At underlying implementation, it communicates with local node through RPC calls. web3.js can connect to any blockchain node that exposes RPC interface.

# Import Method

Custom startup method in egg.js

```js
//app.js
"use strict";
const Web3 = require("web3");

module.exports = (app) => {
  app.beforeStart(async () => {
    const { config } = app;
    let originWeb3;
    // web3 initialization
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
    // Mount web3js to app
    app.web3 = originWeb3;

    // Create a context to call service methods
    const ctx = app.createAnonymousContext();
    app.cities = await ctx.service.connection.getAdmin();
  });
};
```

# Service Layer Calling Smart Contracts

```js
// app/service/
"use strict";
const Service = require("egg").Service;
const contract = require("truffle-contract");
// Import smart contract
const stock_artifact = require("../../build/contracts/Stock.json");

//Link contract
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
    // Fix apply error
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
      // Use web3.js to interact with smart contract
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

  // Add user
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

  // Get user
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

Complete Demo: [https://github.com/Num142857/egg-block-chain](https://github.com/Num142857/egg-block-chain)

# Demo Usage Method

### Globally Install truffle

```bash
npm install -g truffle
```

### Smart Contract

```bash
# Migrate
truffle migrate

#Compile contract
truffle compile
```

### Local Development

```bash
$ npm i
$ npm run dev
$ open http://localhost:7001/
```

### Deploy

```bash
$ npm start
$ npm stop
```

