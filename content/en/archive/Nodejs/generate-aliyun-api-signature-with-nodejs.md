---
title: Generate Aliyun API Signature with Node.js
categories: [Backend]
tags: [Node.js]
slug: 7cafffa9
keywords: Node.js,Aliyun,Signature
date: 2017-02-13 21:32:05
---

To call Aliyun's DNS API, you must generate the signature required by Aliyun.
[Signature Mechanism](https://help.aliyun.com/document_detail/29747.html?spm=5176.doc29743.2.4.SAqOxJ)

I couldn't find Node.js related code for getting signatures online.
According to Aliyun's requirements, I wrote a program myself to easily generate signatures.

<!-- more -->
```javascript
const querystring = require('querystring');
const crypto = require("crypto");

module.exports=function getSignatureParams(params) {
    StringToSign = "GET" + "&" + percentEncode("/") + "&" + percentEncode(uriSort(params))
    var Signture = getSignture(StringToSign);
    params.Signature = Signture;
    return params; // Return complete uri with signature
}


    function percentEncode(str) { // Percent encode uri
        var s = encodeURI(str);
        return s
            .replace(/ /g, "%20")
            .replace(/\//g, "%2F")
            .replace(/\+/g, "%20")
            .replace(/\*/g, "%2A")
            .replace(/\%7E/g, "~")
            .replace(/\=/g, "%3D")
            .replace(/\&/g, "%26")
            .replace(/\:/g, "%253A")
    }
 
    function getSignture(Signature) {  // Calculate HMAC
        // 47awTgVxfVEBL8hewkBgYD6kEvuJn0 
        return crypto
            .createHmac('sha1', "testsecret&") // Your secret
            .update(Signature)
            .digest()
            .toString('base64');
    }

    function uriSort(uri) { // Sort uri parameters
        var arr = querystring.stringify(uri).split("&");
        arr = arr.sort();
        var str = "";
        [].forEach.call(arr, function (s, i) {
            if (i == (arr.length - 1)) {
                str = str + s
            } else {
                str = str + s + "&"
            }
        });
        return str;
    }
```

