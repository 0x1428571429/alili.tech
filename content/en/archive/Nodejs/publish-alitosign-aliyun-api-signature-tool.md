---
title: Publish Aliyun API Signature Generation Tool Based on Node.js -- AliToSing
categories: [Backend]
tags: [Node.js]
slug: dd233b37
keywords: Node.js,Aliyun,Signature
date: 2017-07-16 00:04:05
---

Aliyun API signature generation tool based on Node.js

[Github AliToSign](https://github.com/Num142857/AliToSign)

[Aliyun Signature Official Documentation](https://help.aliyun.com/document_detail/29747.html?spm=5176.doc29743.2.4.SAqOxJ)

Installation method:

```
npm install alitosign --save
```

Usage method:

Example: [Add Domain](https://help.aliyun.com/document_detail/29749.html?spm=5176.doc29744.6.592.RG61hE)

```javascript
const alitosign = require("alitosign");
const querystring = require("querystring");
const moment = require("moment");
const http = require("http");

// Basically common parameters needed for calling interfaces
let originParams = {
  AccessKeyId: "xxxxxxx", // AccessKeyId acquisition method please refer to official documentation
  Format: "JSON",
  Version: "2015-01-09",
  SignatureMethod: "HMAC-SHA1",
  SignatureVersion: "1.0",
};

function AddDomain() {
  // Copy common parameters
  let params = Object.assign({}, originParams);

  // Add necessary parameters for the interface you want to call on the new object,
  // Each interface is different, please check official documentation for details
  params.Action = "AddDomain";
  params.DomainName = "time-friend.com";
  params.GroupId = "2223";

  // Add timestamp
  params.Timestamp = moment.utc().format(); // Use Greenwich Mean Time;
  params.SignatureNonce = new Date().getTime();

  // Generate signature
  let signParams = alitosign(params);

  // Convert object containing signature property to query format string
  let queryParams = querystring.stringify(signParams);

  // Concatenate url
  let url = `http://alidns.aliyuncs.com/?` + queryParams;

  // Call interface
  http.get(url, (res) => {
    res.on("data", function (data) {
      // After serialization, you can get the data you want
      let oData = JSON.parse(data);
    });
  });
}
```

