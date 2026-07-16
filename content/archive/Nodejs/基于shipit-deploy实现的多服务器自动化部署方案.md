---
title: 基于shipit-deploy实现的多服务器自动化部署方案
categories: [Backend]
tags: [Node.js]
slug: fba46182
keywords:  Node.js,自动化,webhook,网络,github,coding,shipit-deploy
date: 2017-12-17 20:32:05
---

为什么要自动化部署，我这里就不多赘述了。

基于shipit-deploy的自动化部署，可以实现以下效果

* 一键部署多台服务器。
* 一键回滚多台服务器。
* 本地操作，不需要登录服务器。
* 方便定制，方便扩展，实现自动化。

## 使用

### 1.下载安装

```
npm install --save-dev shipit-cli
npm install --save-dev shipit-deploy
```

### 2.与服务器建立信任关系
```
ssh-copy-id USER@REMOTE_HOST
```

### 3.配置
```javascript
module.exports = function (shipit) {
  require('shipit-deploy')(shipit);
  require('shipit-pm2')(shipit);
  require('shipit-cnpmjs')(shipit);

  shipit.initConfig({
    default: {
      workspace: '/tmp/github-monitor',
      deployTo: '/tmp/deploy_to', //服务器的目标路径
      repositoryUrl: 'https://github.com/user/repo.git', //git仓库地址
      ignores: ['.git', 'node_modules'], //排除的文件
      keepReleases: 2, //发布保留的版本数量
      deleteOnRollback: false,
      key: '/path/to/key',
      shallowClone: true,
      cnpm: {
        remote: false
      }
    },
    dev: { //开发服务器部署
      servers: ['user@devServer1', 'user@devServer1'],
	    branch: 'dev' //需要发布的git分支,
      pm2: {
        json: 'pm2-dev-app.json' //开发环境的pm2启动配置
      }
    }，
    prod: {  //生产服务器部署
      servers: ['user@prodServer1', 'user@prodServer2'],
	    branch: 'master' //需要发布的git分支,
      pm2: {
        json: 'pm2-prod-app.json' //生产jam环境的pm2启动配置
      }
    }
  });
};
```

pm2-prod-app.json 示例：
``` json
{
  "apps": [
    {
      "name": "frontend_name", 
      "script": "app.js",
      "args": "--env=production",
      "instances": 1,
      "cwd": "/tmp/production_path/current",
      "env": {
        "NODE_ENV": "production",
        "PORT": "9001"
      }
    }
  ]
}
```

当然，我们也可以使用以下脚本来启动项目
```
pm2 startOrRestart pm2-prod-app.json
```

### 发布
```
shipit dev deploy //开发环境发布
shipit dev rollback //回滚

shipit prod deploy //生产环境发布
shipit prod rollback //回滚

```
