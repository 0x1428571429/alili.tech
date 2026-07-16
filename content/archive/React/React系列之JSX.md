---
title: React系列之JSX
categories: [Frontend]
tags: [React]
slug: 10fba257
keywords: react,脚手架,create-react-app
date: 2017-07-13 19:33:33
---

JSX是一个有趣的东西。它看似像一个模板语言，但是又具备javascript的所有能力。

在React中，JSX用来生成React元素。

我们使用create-react-app创建一个APP后：

## 一段JSX代码

```javascript
import React, { Component } from 'react';

import ReactDOM from 'react-dom';

class App extends Component {
  render() {
    return (
      <div className="App">
      我是一个APP
      </div>
    );
  }
}

ReactDOM.render(<App />, document.getElementById('root'));
```


## 我们可以在JSX中内嵌表达式

```javascript
  //插入数据  
  const data = {name:"小明"}
  const ele =  <div>我的名字是：{data.name} </div>;

  //计算
  const ele1 =  <div> {1+1} </div>;

  //三元表达式
  const ele2 =  <div> {true?"我是小明"："我不是小明"} </div>;

  //在属性里
  const ele3 =  <img src={date.xxx} />;
```

---
因为JSX使用Babel编译后,本身自己就是一个对象.

```javascript
let ele = <div className="user">Hello World!</div>
```
编译后:
```javascript
const element = React.createElement(
    'div',
    {className: 'user'},
    'Hello World!'
);
```

所以,这就是JSX可以与js代码混写的原因.

```javascript
var a =1;
function switchView(){
    if(a>1){
        return <div className="user">Hello World!</div>
    }else{
        return <div className="user">Hello Ming!</div>
    }
}
```
编译后:
```javascript
var a =1;
function switchView(){
    if(a>1){
        return React.createElement('div',{className: 'user'},'Hello world!');
    }else{
        return React.createElement('div',{className: 'user'},'Hello Ming!');
    }
}
```


## 防止XXS攻击

```javascript
let content ="<span>我是HTML代码?</span>"

let ele = <div>{content}</div> 
//会直接输入<span>我是HTML代码?</span>,不会把这一段变成HTML
```


## 元素的class
因为在ES6里,class是关键字(不再是保留字).所以写的时候要注意,修改为className.

另外属性名都建议使用驼峰命名法.

```javascript
//HTML
<div class="user">Hello World!</div>

//JSX
<div className="user">Hello World!</div>
```
