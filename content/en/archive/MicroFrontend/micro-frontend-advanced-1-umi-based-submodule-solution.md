---
title: Micro-Frontend Advanced 1 - Umi-Based Submodule Solution
categories: [Architecture]
tags: ['Micro-Frontend', 'Front-end-Architecture']
slug: 9xuojm75d2a
keywords: Micro-Frontend,Front-end Microservices,Front-end Automation,Solutions,Front-end Challenges,Single,SPA
date: 2019-04-13 22:17:36
---

It's been more than half a year since the first article about front-end microservices. Many people are interested.

Today let's talk about how we build a more complete front-end microservices sub-module based on umi.

If you're using front-end technology stacks other than React,
Many of my handling methods can also be applied to other technology stacks.

Hope it helps you too.

# Excellent umi Framework

In front-end mid-backend projects, front-end microservices needs are relatively strong. 

Speaking of mid-backend, many enterprises build their projects based on antd components.

Since last year's `see conf`, Ant Design's `pluggable enterprise-level react application framework` umi was released.

This framework is closely related to antd. Using antd with umi is quite natural and smooth.

It can be said that projects built based on umi and antd are very beautiful. Such an excellent framework, if we make it suitable for our front-end microservices architecture, wouldn't that be great?

umi also has related microservices solutions: https://github.com/umijs/umi-example-monorepo

But umi's provided solution has great limitations.
If we can integrate single-spa's microservices solution, independent development, independent deployment, and other front-end microservices benefits,
Will give your project greater development space in the future.

# Front-End Microservices Through umi Plugin Mechanism

umi provides a very powerful plugin mechanism. It's precisely because of this that we can make umi integrate into microservices architecture

## umi Plugin Introduction

Basic introduction to umi plugins:

https://umijs.org/zh/plugin/

## umi Plugin Development

Here's how to develop a simple umi plugin:

https://umijs.org/zh/plugin/develop.html

## umi Plugin Integrating single-spa

```js
export default (api, opts) => {
  // All the following code is written here
};
```

## Render Entry Handling Method

Define a dynamic element. When our base app needs to load sub-modules, it will render the elements needed by sub-modules.

When our sub-modules find the nodes they need to render, they will render.

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

## Using single-spa-react

Import `single-spa-react` in umi's entry file, judge based on module properties whether module renders on root node or specified node at runtime

```js
// Production environment use
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

## Export Standard Lifecycle Externally
Clear umi's original render method, and export lifecycle needed by single-spa externally.

```js
// Production environment use
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

This way we get a umi sub-module compatible with single-spa.

## Packaging Related

```js
    api.modifyWebpackConfig((config) => {
     // Still package as amd module
      config.output.libraryTarget = 'amd'

      // Specify module name
      config.output.library = options.name;

      // Modify outputPath according to your deployment situation
      config.output.path = resolve(`./dist/${options.deployPath}/`);
      
      // Modify publicPath according to your deployment situation
      config.output.publicPath = options.deployPath;
      return config;
    })
  }


  api.modifyDefaultConfig(memo => ({
      // webpack configuration modification, umi also provides chainWebpack
      ...memo,
      // Specify routing mode
      history: 'hash',

      // Export store file for communication
      // If you don't know what this is for, you can read previous articles
      chainWebpack(config) {
        config
          .entry('store').add('./src/store.js')
          .end()
      }
    }));
```

## umi Global Variable Problem
umi provides many global variables externally. When only one module in our micro-frontend architecture is built with umi, we don't need to consider this problem. If multiple modules use umi, global variable conflicts will occur. Fortunately, umi's global variables have standards, we can handle them specifically.

I provide the following solution, might be relatively violent, but can solve conflict problems. If you have better and more elegant methods, welcome to discuss.

General idea is, after project packaging completes, replace all global variables in each file with other names.

```js
// Replace global variables after packaging to avoid conflicts
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
            // Replace global variables
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

# Afterword

umi's plugin mechanism is really excellent. To make umi integrate into single-spa's microservices solution, basically read through umi source code. Really benefited a lot~  

The above is the method to make umi microservices. Please modify and use according to your project situation.
Later I'll also introduce many unexpected operations that come after front-end project microservices.

This kind of basic technology progress can bring immeasurable benefits and changes in the future.

Please follow subsequent series articles.

# Related Series Articles

https://time-friend.com/tags/microfrontend/

