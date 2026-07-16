---
title: Multi-Server Automated Deployment Solution Based on shipit-deploy
categories: [Backend]
tags: [Node.js]
slug: fba46182
keywords: Node.js,Automation,webhook,Network,github,coding,shipit-deploy
date: 2017-12-17 20:32:05
---

Why automate deployment, I won't elaborate here.

Automated deployment based on shipit-deploy can achieve the following effects

* One-click deployment to multiple servers.
* One-click rollback of multiple servers.
* Local operation, no need to log into servers.
* Easy to customize, easy to extend, achieve automation.

## Usage

### 1. Download and Install

```
npm install --save-dev shipit-cli
npm install --save-dev shipit-deploy
```

### 2. Establish Trust Relationship with Servers
```
ssh-copy-id USER@REMOTE_HOST
```

### 3. Configuration
```javascript
module.exports = function (shipit) {
  require('shipit-deploy')(shipit);
  require('shipit-pm2')(shipit);
  require('shipit-cnpmjs')(shipit);

  shipit.initConfig({
    default: {
      workspace: '/tmp/github-monitor',
      deployTo: '/tmp/deploy_to', // Server target path
      repositoryUrl: 'https://github.com/user/repo.git', // Git repository address
      ignores: ['.git', 'node_modules'], // Excluded files
      keepReleases: 2, // Number of release versions to keep
      deleteOnRollback: false,
      key: '/path/to/key',
      shallowClone: true,
      cnpm: {
        remote: false
      }
    },
    dev: { // Development server deployment
      servers: ['user@devServer1', 'user@devServer1'],
	    branch: 'dev' // Git branch to publish,
      pm2: {
        json: 'pm2-dev-app.json' // Development environment pm2 startup configuration
      }
    },
    prod: {  // Production server deployment
      servers: ['user@prodServer1', 'user@prodServer2'],
	    branch: 'master' // Git branch to publish,
      pm2: {
        json: 'pm2-prod-app.json' // Production environment pm2 startup configuration
      }
    }
  });
};
```

pm2-prod-app.json example:
```json
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

Of course, we can also use the following script to start the project
```
pm2 startOrRestart pm2-prod-app.json
```

### Publish
```
shipit dev deploy // Development environment publish
shipit dev rollback // Rollback

shipit prod deploy // Production environment publish
shipit prod rollback // Rollback

```

