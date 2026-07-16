---
title: Hugo博客百度SEO终极优化,熊掌号自动推送
categories: [Blogging]
tags: [Hugo,SEO]
slug: 0xh05yxhj3yq
keywords: [Hugo,博客,seo,熊掌号]
date: 2018-11-17 16:14:25
---

在切换到Hugo平台之后,比较头疼的是之前hexo很多seo的插件不能使用了.
下面跟大家说一下我的seo优化方案.

# Meta标签优化

## Description
meta description，被认为是最有用的meta标签，是网站的简介信息。
content控制在100个字符以内比较好。
```html
<meta name='description' itemprop="description" content="{{ if .Description }}{{ .Description }}{{ else }}{{if .IsPage}}{{substr .Summary 0 100}}{{ end }}{{ end }}">
```


## Keywords
```html
{{ if .Keywords }} 
<meta name="keywords" content="{{ delimit .Keywords ", " }}" >
{{else}}
<meta name="keywords" content="{{ delimit .Site.Params.Keywords ", " }}" >
{{ end }}
```

# 百度熊掌号推送
说到seo熊掌号是必不可少的了,他可以做到24小时之内收录.所以这个必须不能放过.

## gulp
在这里我要使用gulp来做我的自动化任务管理工具

### 安装gulp需要的模块
```bash
npm init
npm install gulp --save
npm install xml2js --save
npm install xmlhttprequest --save
```

### 在项目根目录创建一个`gulpfile.js`文件

```js
// 导入相关依赖
const gulp = require("gulp");
const fs = require('fs');
const xml2js = require('xml2js')
const parser = new xml2js.Parser();
const XMLHttpRequest = require("xmlhttprequest").XMLHttp;


// 注册百度站长与熊掌号,百度会提供下面的数据给你
var xz_appid = 'xxxxx';
var xz_token = 'xxxxx';
var baidu_token= 'xxxxx' 

//熊掌号每天需要提交的url数量
// 注意这个数字必须要跟百度允许提交的url数量一致,如果多了会提交失败.
const xzCount = 20


// 创建一个任务
gulp.task('baiduSeo', () => {
    // 读取sitemap.xml文件并且转换成json
    fs.readFile(__dirname + '/public/sitemap.xml', function(err, data) {
        parser.parseString(data, function (err, result) {
            // 把读取的数据传入这个函数
            urlSubmit(result.urlset.url)
            console.log('Done');
        });
    });
  });

  // 提交url的方法
  function urlSubmit(urls) {
    // 最新内容提交
    var new_target = "http://data.zz.baidu.com/urls?appid="+xz_appid+"&token="+xz_token+"&type=realtime"
    
    // 历史提交
    var history_target = "http://data.zz.baidu.com/urls?appid="+xz_appid+"&token="+xz_token+"&type=batch"

    // 百度站长
    var baidu_target = "http://data.zz.baidu.com/urls?site=https://你的域名&token="+baidu_token

    // MIP
    var MIP_target = "http://data.zz.baidu.com/urls?site=https://你的域名&token="+baidu_token+"&type=mip"

    // AMP
    var AMP_target = "http://data.zz.baidu.com/urls?site=https://你的域名&token="+baidu_token+"&type=amp"

    // 最新url,看熊掌号情况而定
    urls = urls.map(item=>item.loc[0])
    allUrls = urls.join('\n')

    var new_urls_Arr = urls.slice(0,xzCount)
    new_urls= new_urls_Arr.join('\n');

    console.info('百度站长开始提交',new_urls)
    sendData(baidu_target,new_urls,'百度站长提交成功')

    console.info('熊掌号开始提交')
    sendData(new_target,new_urls,'熊掌号提交完成')

    // 提交历史url 每天最多500w条
    console.info("历史数据开始提交")
    sendData(history_target,allUrls,"历史数据提交完成")

    console.info("MIP 开始提交")
    sendData(MIP_target,allUrls,"MIP提交成功")

    console.info("AMP 开始提交")
    sendData(AMP_target,allUrls,"AMP提交成功")

    // 提交数据
    function sendData(target,urls,message){
        var xhr = new XMLHttpRequest();
        xhr.open('POST', target, false);
        xhr.setRequestHeader('Content-type', 'text/plain');
        xhr.onload = function () {
            console.log(this.responseText);
            if(message){console.info(message)}
        };
        xhr.send(urls);
    }

};

gulp.task("default",[
    'baiduSeo'
])
```

配置好以上都文件之后

## 推送
```bash
# 博客生成
hugo
# url推送
gulp
```
