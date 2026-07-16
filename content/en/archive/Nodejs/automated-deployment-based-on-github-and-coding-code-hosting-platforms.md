---
title: Automated Deployment Based on Github and Coding Code Hosting Platforms
categories: [Backend]
tags: [Node.js]
slug: ff76a1bd
keywords: Node.js,Automation,webhook,Network,github,coding
date: 2017-02-14 22:30:05
---

Since playing with Raspberry Pi, I need to frequently update code to Raspberry Pi every day.

But it's too frequent, repetitive things need to be done over and over. Very time-consuming.

Found Github and Coding both have webhook functionality,

So I had an idea:

Want every time git push updates code,
Use hosting platform's webhook to notify my Raspberry Pi,
After receiving notification, automatically update hosting platform's latest code, and automatically restart.

Wouldn't this save a lot of time?
<!-- more -->
Searched npmjs.com for modules with related functionality, sure enough there are:

[github-webhook-handler](https://www.npmjs.com/package/github-webhook-handler)

[coding-webhook-handler](https://www.npmjs.com/package/coding-webhook-handler)

Next we'll use coding as an example to write a small automated deployment program.

First prepare a piece of sh code that Raspberry Pi runs after receiving notification

```sh
#! /bin/bash
cd /home/pi/workspace/xxx  // Open project directory
git reset --hard origin/master
git clean -f
git pull origin master // Pull and merge code
cnpm install           // Install modules
pm2 reload app         // pm2 restart program
```

Below is js code

```javascript
const http = require("http");
const spawn =require('child_process').spawn;
const createHandler = require("coding-webhook-handler");
const handler = createHandler({  // Configure coding parameters
    path: "/",
    token: "dsdsdsdsds"
});

http.createServer((req, res) => {  // Start a service to receive notifications sent by hosting platform
    handler(req, res, (err) => {
        res.statusCode = 404;
        res.end("no such location")
    })
    console.log("Hi!")
}).listen(7878);

const runCommand = (cmd, args, callback) => {  
    const child = spawn(cmd, args);  // Run sh code

    let response = "";  // Receive content sent by hosting platform
    child.stdout.on("data", buffer => response += buffer.toString());
    child.stdout.on("end", () => {
        callback(response)
    })
}

handler.on("error", (err) => {
    console.error('Error:', err.message) // Output error information
})


handler.on('*', function (event) {
    console.log(event.event)
    console.log(event.payload)
    console.log(event.protocol)
    console.log(event.host)
    console.log(event.url)
})


handler.on("push", (event) => { // push event
    console.log('event:', event.event); 

    runCommand('sh', ['./auto_build.sh'], txt => {  // Run sh code
        console.log(txt)   // Output information sent by hosting platform
    })
})

```

