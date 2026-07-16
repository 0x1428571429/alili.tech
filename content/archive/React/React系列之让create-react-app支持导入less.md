---
title: React系列之让create-react-app支持导入less
categories: [Frontend]
tags: [React]
slug: 3b5f5a23
keywords: react,脚手架,less
date: 2017-07-14 19:33:33
---

目前来说,create-react-app并不支持直接导入LESS;
这里我就介绍一下,如何让它支持LESS的导入.

create-react-app是基于webpack的,只是没有暴露webpack.config相关的文件.想要支持less,肯定是要修改webpack的配置文件的.
以下命令可以做到暴露出配置文件来:
```
npm run eject
```
运行完毕之后,你会看见多出了一个config文件夹.
里面有webpack.config.dev.js和webpack.config.prod.js等配置文件.

接下来,安装less-loader
```
npm install less-loader less --save-dev
```
然后修改webpack.config.dev.js文件,

我们只需要修改两个地方

## 第一: 找到下面代码
```javascript
exclude: [
    /\.html$/,
    /\.(js|jsx)$/,
    /\.css$/,
    /\.json$/,
    /\.bmp$/,
    /\.gif$/,
    /\.jpe?g$/,
    /\.png$/,
]
```
将.css改为.(css|less)，内容变为：
```javascript
exclude: [
    /\.html$/,
    /\.(js|jsx)$/,
    /\.(css|less)$/,
    /\.json$/,
    /\.bmp$/,
    /\.gif$/,
    /\.jpe?g$/,
    /\.png$/,
]
```


## 第二个：找到test: /\.css$/

更改为test: /\.(css|less)$/

并在下面的use数组里面增加less-loader
```javascript
{
    loader: require.resolve('less-loader') // compiles Less to CSS
}
```

更改完以后这部分代码大概长这个样子：

```javascript

      {
        test: /\.(css|less)$/,
        use: [
          require.resolve('style-loader'),
          {
            loader: require.resolve('css-loader'),
            options: {
              importLoaders: 1,
            },
          },
          {
            loader: require.resolve('less-loader') // compiles Less to CSS
          }

          ...

        ],
      }
 ```
生产环境的配置跟上面也差不多.

---

好了,现在就可以导入less了哟：

``` javascript
import './style.less';
```

