---
title: 利用Node.js生成阿里云API签名
categories: [Backend]
tags: [Node.js]
slug: 7cafffa9
keywords:  Node.js,阿里云,签名
date: 2017-02-13 21:32:05
---

想要调用阿里云的云解析API,必须要生成阿里云所要求的签名.
[签名机制](https://help.aliyun.com/document_detail/29747.html?spm=5176.doc29743.2.4.SAqOxJ) 

网上一直没有找到nodejs相关获取签名的代码.
按照阿里云的要求,我自己写了一段程序,便于大家轻松的生成签名.


<!-- more -->
``` javascript
const querystring = require('querystring');
const crypto = require("crypto");

module.exports=function getSignatureParams(params) {
    StringToSign = "GET" + "&" + percentEncode("/") + "&" + percentEncode(uriSort(params))
    var Signture = getSignture(StringToSign);
    params.Signature = Signture;
    return params; //返回带签名的完整uri
}


    function percentEncode(str) { //百分比编码 uri
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
 
    function getSignture(Signature) {  //计算HMAC
        // 47awTgVxfVEBL8hewkBgYD6kEvuJn0 
        return crypto
            .createHmac('sha1', "testsecret&") //你的secret
            .update(Signature)
            .digest()
            .toString('base64');
    }

    function uriSort(uri) { //uri参数排序
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

