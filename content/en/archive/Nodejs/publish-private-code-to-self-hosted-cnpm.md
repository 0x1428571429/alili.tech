---
title: Publish Company Private Code to Self-Hosted cnpm
categories: [Backend]
tags: [Node.js]
slug: 7cb6734b
keywords: Node.js,ts,Private,Server,typescript,verdaccio,npm,Browser
date: 2017-11-25 22:30:05
---

### Configuration
1. First need to add some configuration properties to the original config/config.js:
```javascript
    enablePrivate: false, // Anyone can publish packages
    admins: {
      admin: 'test@company.com' // Admin permissions
    },
    scopes: ['@company'], // Private packages must be under scope
```
### Restart cnpm
Enter cnpm directory
```
npm stop // Stop service
npm start // Start service
```
3.
Add code to package.json file:
```
     "name": "@company/testjs", // Package name, must add scope name before
```

### npm Login
```
    npm login --registry=http://192.168.0.100:7001 // Register previous user
    Username: admin // Admin name
    Password: 1234 // Password you want
```
```
    npm publish --registry=http://192.168.80.130:7001
```
Publish successful

### Install Just Published Package
```
   npm install @company/test -registry=http://192.168.0.100:7001
```

