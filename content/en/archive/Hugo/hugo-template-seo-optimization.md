---
title: Hugo Blog Baidu SEO Ultimate Optimization, Baidu Xiongzhang Auto Push
categories: [Blogging]
tags: [Hugo,SEO]
slug: hugo-template-seo-optimization
keywords: [Hugo,Blog,seo,Baidu Xiongzhang]
date: 2018-11-17 16:14:25
---

After switching to Hugo platform, the headache is that many SEO plugins from Hexo can't be used.
Below I'll share my SEO optimization solution.

# Meta Tag Optimization

## Description
meta description, considered the most useful meta tag, is the website's introduction information.
Content should be controlled within 100 characters.
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

# Baidu Xiongzhang Push
Speaking of SEO, Xiongzhang is essential, it can achieve indexing within 24 hours. So this must not be missed.

## gulp
Here I'll use gulp as my automation task management tool

### Install gulp required modules
```bash
npm init
npm install gulp --save
npm install xml2js --save
npm install xmlhttprequest --save
```

### Create a `gulpfile.js` file in project root directory

```js
// Import related dependencies
const gulp = require("gulp");
const fs = require('fs');
const xml2js = require('xml2js')
const parser = new xml2js.Parser();
const XMLHttpRequest = require("xmlhttprequest").XMLHttp;


// Register Baidu Webmaster and Xiongzhang, Baidu will provide the following data to you
var xz_appid = 'xxxxx';
var xz_token = 'xxxxx';
var baidu_token= 'xxxxx' 

// Number of URLs Xiongzhang needs to submit daily
// Note this number must match the number of URLs Baidu allows to submit, if more will fail to submit.
const xzCount = 20


// Create a task
gulp.task('baiduSeo', () => {
    // Read sitemap.xml file and convert to json
    fs.readFile(__dirname + '/public/sitemap.xml', function(err, data) {
        parser.parseString(data, function (err, result) {
            // Pass read data into this function
            urlSubmit(result.urlset.url)
            console.log('Done');
        });
    });
  });

  // Method to submit URLs
  function urlSubmit(urls) {
    // Latest content submission
    var new_target = "http://data.zz.baidu.com/urls?appid="+xz_appid+"&token="+xz_token+"&type=realtime"
    
    // History submission
    var history_target = "http://data.zz.baidu.com/urls?appid="+xz_appid+"&token="+xz_token+"&type=batch"

    // Baidu Webmaster
    var baidu_target = "http://data.zz.baidu.com/urls?site=https://your-domain&token="+baidu_token

    // MIP
    var MIP_target = "http://data.zz.baidu.com/urls?site=https://your-domain&token="+baidu_token+"&type=mip"

    // AMP
    var AMP_target = "http://data.zz.baidu.com/urls?site=https://your-domain&token="+baidu_token+"&type=amp"

    // Latest URLs, depends on Xiongzhang situation
    urls = urls.map(item=>item.loc[0])
    allUrls = urls.join('\n')

    var new_urls_Arr = urls.slice(0,xzCount)
    new_urls= new_urls_Arr.join('\n');

    console.info('Baidu Webmaster starting submission',new_urls)
    sendData(baidu_target,new_urls,'Baidu Webmaster submission successful')

    console.info('Xiongzhang starting submission')
    sendData(new_target,new_urls,'Xiongzhang submission completed')

    // Submit history URLs, max 5 million per day
    console.info("History data starting submission")
    sendData(history_target,allUrls,"History data submission completed")

    console.info("MIP starting submission")
    sendData(MIP_target,allUrls,"MIP submission successful")

    console.info("AMP starting submission")
    sendData(AMP_target,allUrls,"AMP submission successful")

    // Submit data
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

After configuring the above file

## Push
```bash
# Blog generation
hugo
# URL push
gulp
```
