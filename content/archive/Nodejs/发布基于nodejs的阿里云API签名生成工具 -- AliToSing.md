---
title: 发布基于nodejs的阿里云API签名生成工具 -- AliToSing
categories: [Backend]
tags: [Node.js]
slug: dd233b37
keywords: Node.js,阿里云,签名
date: 2017-07-16 00:04:05
---

基于 nodejs 的阿里云 API 签名生成工具

[Github AliToSign](https://github.com/Num142857/AliToSign)

[阿里云签名官方说明](https://help.aliyun.com/document_detail/29747.html?spm=5176.doc29743.2.4.SAqOxJ)

安装方法:

```
npm install alitosign --save
```

使用方法:

例子:[添加域名](https://help.aliyun.com/document_detail/29749.html?spm=5176.doc29744.6.592.RG61hE)

```javascript
const alitosign = require("alitosign");
const querystring = require("querystring");
const moment = require("moment");
const http = require("http");

//基本上调用接口都需要的公共参数
let originParams = {
  AccessKeyId: "xxxxxxx", //AccessKeyId 获得方法请参照官方文档
  Format: "JSON",
  Version: "2015-01-09",
  SignatureMethod: "HMAC-SHA1",
  SignatureVersion: "1.0",
};

function AddDomain() {
  //复制一份公共参数
  let params = Object.assign({}, originParams);

  //在新的对象上添加你想调用的该接口必要参数,
  //每个接口都不一样,具体请查阅官方文档
  params.Action = "AddDomain";
  params.DomainName = "time-friend.com";
  params.GroupId = "2223";

  //添加时间戳
  params.Timestamp = moment.utc().format(); //要用格林威治时间;
  params.SignatureNonce = new Date().getTime();

  //生成签名
  let signParams = alitosign(params);

  //将包含签名属性的对象转换成query格式的字符串
  let queryParams = querystring.stringify(signParams);

  //拼接url
  let url = `http://alidns.aliyuncs.com/?` + queryParams;

  //调用接口
  http.get(url, (res) => {
    res.on("data", function (data) {
      //序列化之后,就可以拿到你想要的数据了
      let oData = JSON.parse(data);
    });
  });
}
```
