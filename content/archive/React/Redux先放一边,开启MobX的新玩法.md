---
title: 'Redux先放一边,开启MobX的新玩法'
categories: [Frontend]
tags: [React]
slug: b3d50314
keywords: react,脚手架,mobx,装饰器,observable
date: 2017-11-04 19:33:33
---
## Mobx

Mobx是一个简单的,高扩展的状态管理工具.Mobx与Redux一样是为了解决react管理状态的一种工具.
但是在写代码体验上,会好过Redux.

### 安装
```
npm install mobx --save

//配合React: 
npm install mobx-react --save
```

## 一个简单的计数器
```javascript
import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { observer } from 'mobx-react'
import { observable, computed, action } from 'MobX'

class Store {
  @observable
  count = 0;

  @action
  add() {
    this.count ++
  }
  minus() {
    this.count --
  }
}

let countStore = new Store()

@observer
class CountComponent extends Component {
  render() {
    return (
      <div>
        <h2>{ countStore.count }</h2>
        <button key="add" onClick={countStore.add}>+</button>
        <button key="minus" onClick={countStore.minus}>-</button>
      </div>
    )
  }
}

ReactDOM.render(
  <CountComponent/>,
  document.getElementById('root')
)
```