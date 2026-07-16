---
title: React Series - JSX
categories: [Frontend]
tags: [React]
slug: react-series-jsx
keywords: react,scaffold,create-react-app
date: 2017-07-13 19:33:33
---

JSX is an interesting thing. It looks like a template language, but has all the capabilities of JavaScript.

In React, JSX is used to generate React elements.

After we create an APP using create-react-app:

## A Piece of JSX Code

```javascript
import React, { Component } from 'react';

import ReactDOM from 'react-dom';

class App extends Component {
  render() {
    return (
      <div className="App">
      I am an APP
      </div>
    );
  }
}

ReactDOM.render(<App />, document.getElementById('root'));
```


## We Can Embed Expressions in JSX

```javascript
  //Insert data  
  const data = {name:"Xiaoming"}
  const ele =  <div>My name is: {data.name} </div>;

  //Calculate
  const ele1 =  <div> {1+1} </div>;

  //Ternary expression
  const ele2 =  <div> {true?"I am Xiaoming":"I am not Xiaoming"} </div>;

  //In attributes
  const ele3 =  <img src={date.xxx} />;
```

---
Because JSX is compiled by Babel, it itself is an object.

```javascript
let ele = <div className="user">Hello World!</div>
```
After compilation:
```javascript
const element = React.createElement(
    'div',
    {className: 'user'},
    'Hello World!'
);
```

So, this is why JSX can be mixed with JavaScript code.

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
After compilation:
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


## Prevent XSS Attacks

```javascript
let content ="<span>I am HTML code?</span>"

let ele = <div>{content}</div> 
//Will directly output <span>I am HTML code?</span>, won't convert this into HTML
```


## Element's class
Because in ES6, class is a keyword (no longer a reserved word). So when writing, pay attention, change to className.

Also, attribute names are recommended to use camelCase naming.

```javascript
//HTML
<div class="user">Hello World!</div>

//JSX
<div className="user">Hello World!</div>
```

