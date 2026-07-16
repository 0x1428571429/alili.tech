---
title: 前端微服务化进阶1 - 基于umi的子模块方案
categories: [Architecture]
tags: ['Micro-Frontend', 'Front-end-Architecture']
slug: 9xuojm75d2a
keywords: 微前端,前端微服务化,前端自动化,解决方案,前端难题,Single,SPA
date: 2019-04-13 22:17:36
---

距离第一篇聊前端微服务的文章已经时隔大半年,很多人对此感兴趣.

今天我们就聊一聊,我们如何基于umi来打造一个更完善的前端微服务的子模块.

如果你用的是react以外的前端技术栈,
我的很多处理做法也可以应用在其他技术栈上.

希望对你也有所帮助.

# 优秀的umi框架

在前端中后台项目上,前端微服务化的需求相对是比较旺盛一些的. 

说到中后台,很多企业都是基于antd的组件来构建自己的项目.

自去年的`see conf`之后,蚂蚁的一款`可插拔的企业级 react 应用框架` umi发布了.

这款框架与antd息息相关,antd结合umi使用那是相当的自然与流畅.

可以说,基于umi与antd构建的项目非常的漂亮.这么优秀的框架,如果让他适用于我们的前端微服务架构,岂不美哉?

umi也有相关的类似微服务方案: https://github.com/umijs/umi-example-monorepo

但是umi提供的方案,有很大的局限性.
如果可以接入single-spa的微服务方案,独立开发,独立部署等等的前端微服务化红利,
会让你的项目日后有更大的发展空间.


# 基于umi插件机制做到前端微服务化

umi 提供了非常强大的插件机制,正是由于这一点,我们才可以让umi也可以接入到微服务架构中来

## umi插件介绍

umi插件的基本介绍:

https://umijs.org/zh/plugin/



## umi插件开发

这里介绍了如何开发一个简单的umi插件:

https://umijs.org/zh/plugin/develop.html



## 接入single-spa的umi插件


```js
export default (api, opts) => {
  // 以下的所有代码都写在这里面哦
};
```
 
## 渲染入口处理方法

定义一个动态的元素,当我们的base app 需要加载子模块的时候,会渲染出子模块需要渲染元素.

我们的子模块找到了自己模块需要渲染的节点的时候,就会渲染出来.

```js
  const domElementGetterStr = `
      function domElementGetter() {
        let el = document.getElementById('submodule-page')
        if (!el) {
          el = document.createElement('div')
          el.id = 'submodule-page'
        }
        let timer = null
        timer = setInterval(() => {
          if (document.querySelector('#submoduleContent.submoduleContent')) {
                document.querySelector('#submoduleContent.submoduleContent').appendChild(el)
                clearInterval(timer)
                timer = null
          }
        }, 100)

        return el
    }`
```



## 使用single-spa-react

在umi的入口文件导入`single-spa-react` ,根据模块的属性来判断模块在运行时是否渲染在root节点上还是指定节点

```js
// 生产环境使用
if (process.env.NODE_ENV === 'production') {
 api.addEntryCodeAhead(`
    import singleSpaReact from 'single-spa-react';
    let reactLifecycles;
    reactLifecycles =  singleSpaReact({
        React,
        ReactDOM,
        rootComponent: (customProps) => window.g_plugins.apply('rootContainer', {
        initialValue: React.createElement(require('./router').default,customProps),
        }),
        domElementGetter: ${options.base?`() => document.getElementById('root')`:domElementGetterStr}
    });
  `);
}

```


## 对外导出标准的生命周期
清空umi原来的渲染方法,并且对外导出single-spa需要的生命周期.

```js
// 生产环境使用
if (process.env.NODE_ENV === 'production') {
api.modifyEntryRender(``)

api.addEntryCode(`
    export const bootstrap = [
    reactLifecycles.bootstrap,
    ];

    export const mount = [
    reactLifecycles.mount,
    ];

    export const unmount = [
    reactLifecycles.unmount,
    ];
    `)
}
```


这样我们就得到了一个兼容single-spa的umi子模块.


## 打包相关

```js
    api.modifyWebpackConfig((config) => {
     // 打包的还是amd模块
      config.output.libraryTarget = 'amd'

      // 指定模块名称
      config.output.library = options.name;

      //根据自己部署情况来修改outputPath
      config.output.path = resolve(`./dist/${options.deployPath}/`);
      
      // 根据自己部署情况来修改publicPath
      config.output.publicPath = options.deployPath;
      return config;
    })
  }


  api.modifyDefaultConfig(memo => ({
      // webpack的配置修改,umi也提供了 chainWebpack
      ...memo,
      //指定路由模式
      history: 'hash',

      // 导出用于通信的store文件
      // 如果你不知道这个是用来干什么的,可以读一读以前的文章
      chainWebpack(config) {
        config
          .entry('store').add('./src/store.js')
          .end()
      }
    }));
```



## umi的全局变量问题
umi对外提供了很多的全局变量,当我们的微前端架构中,只有一个模块是umi构建的话,不需要考虑这个问题,如果有多个模块使用了umi,将会出现全局变量冲突的问题.还好umi的全局变量是有规范的,我们可以针对性处理.

我给出以下解决方案,可能相对暴力,但是也能解决冲突的问题.如果你有更好更加优雅的办法,欢迎交流.

大致思路是,在项目打包完成后,把每个文件的全局变量全部替换成其他的名字.

```js
// 打包后替换全局变量以免冲突
api.onBuildSuccess(() => {
    const outPath = resolve('.', `dist/${options.deployPath}`);
    readdir(outPath, 'utf8', (err, data) => {

      data.forEach((item) => {
        if (!lstatSync(resolve(outPath, item)).isDirectory()) {
          readFile(resolve(outPath, item), 'utf8', (error, files) => {
            if (error) {
              console.log(error);
              return
            }
            // 替换全局变量
            const result = files.replace(/window.g_/g, `window.g_${options.name}_`);

            writeFile(resolve(outPath, item), result, 'utf8', (err2) => {
              if (err2) console.log(err2);
            });

          })
        }

      });

    })
  })
```



# 尾巴

umi的插件机制真的很优秀,为了让umi也可以接入到single-spa的微服务化的方案中来,基本上umi源码都看了一遍.真的是受益匪浅~  

以上就是让umi微服务化的方法,请根据自身的项目情况修改与使用.
后面我还会介绍一些前端项目微服务化之后,带来的很多意想不到的骚操作.

这种基础技术的进步,未来可以带来无法估量的收益与改变.

请关注后续的系列文章.

# 相关系列文章

https://time-friend.com/tags/microfrontend/
