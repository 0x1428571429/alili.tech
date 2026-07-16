---
title: Micro-Frontend Advanced 3 - Cross-Module Shared Components
categories: [Architecture]
tags: ['Micro-Frontend', 'Front-end-Architecture']
slug: qh7x5i5szfh
keywords: Micro-Frontend,Front-end Microservices,Front-end Automation,Solutions,Front-end Challenges,Single,SPA
date: 2019-05-12 22:17:36
---

After front-end microservices, we face a problem: duplicate code between modules cannot be reused.

If we use npm to manage our duplicate code, we'll have additional costs maintaining npm packages.
Updating npm package versions in sub-modules is also very troublesome.
There's no optimization in js file size either.

# Component Sharing
Today let's talk about how to use one component simultaneously in multiple modules.

## Approach
Manage public components in base module, encapsulate components as dynamic components, so when packaging we can split this component into a separate file.
When other sub-modules need this component, dynamically get it from Base module.

## Practice

### Dynamic Component Encapsulation

To allow other modules to load our public components on demand, we need to encapsulate existing components as dynamic components.

I'm using `umi/dynamic` here,

It's a wrapper based on https://github.com/jamiebuilds/react-loadable.
Interested friends can learn about it themselves.

```js
import React from 'react';
import dynamic from 'umi/dynamic';
import PageLoading from '@/components/PageLoading'

export const Demo = dynamic(import( `../Demo`), {loading: () => <PageLoading />})

export default Demo;
```

### Provide Method to Get Dynamic Components Externally
When loading Base module, we can expose a method under window to call this module's dynamic components

```js
window.getDynamicComponent = async function(name) {
  let component = null;
  component = await import(`@/components/dynamic/${name}`);
  return component[name];
};
```

### Sub-module Calls Public Components
Because base module provides a global method to get public components,
We can use it anywhere in any module where we need to call public components.

```js
    // Get component
   let component =  await window.getDynamicComponent('Demo')
```

To facilitate use of such public components, we can encapsulate this method into a component.
When calling public components, we just need to declare them.

```js
import React, { Component } from 'react';

// Matrix means matrix in The Matrix
export default class Matrix extends Component {
  state = {
    DynamicComponent: null
  }

  static defaultProps = {
    $name: ""
  }

  async componentWillMount() {
    this.renderComponent()
  }

  componentWillReceiveProps(nextProps) {
    this.props = nextProps
    this.renderComponent()
  }

  async renderComponent() {
    const { $name } = this.props;
    try {
      if ($name) {
        const component = await window.getDynamicComponent($name)
        this.setState({
          DynamicComponent: component
        })
      }
    } catch (error) {
      this.setState({
        DynamicComponent: null
      })
      console.error(error)
    }
  }


  render() {
    const { DynamicComponent } = this.state;
    // Inherit all props
    return DynamicComponent && <DynamicComponent {...this.props} />;
  }
}

```

Call our public components in actual pages

```js
import React, { Component } from 'react';
import Matrix from '@/components/Matrix'

export default class Page extends Component {
  render() {
    return (
      <div>
        <Matrix name="Demo" />
      </div>
    );
  }
}

```

## Afterword
Implementing such functionality is actually very simple. 
But because of this, we need some control over public component granularity.
Otherwise we might encounter a problem of too many files loading on a page, which will affect page loading speed.
Of course we can also improve this situation through existing network technologies.

With this approach, we might not need to reference any other components in our sub-modules,
Depend on public components provided by our base module. We can complete page development.

Micro-frontend has very high playability. And there are more ways to play that haven't been explored yet.

# Related Series Articles

https://time-friend.com/tags/microfrontend/

