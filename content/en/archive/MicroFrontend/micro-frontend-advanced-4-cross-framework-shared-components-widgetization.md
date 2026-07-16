---
title: Micro-Frontend Advanced 4 - Cross-Framework Shared Components (Widgetization)
categories: [Architecture]
tags: ['Micro-Frontend', 'Front-end-Architecture']
slug: vgnhe9tfqnc
keywords: Micro-Frontend,Front-end Microservices,Front-end Automation,Solutions,Front-end Challenges,Single,SPA
date: 2019-06-22 22:17:36
---

In micro-frontend, we can let sub-modules use different framework technology stacks according to our business needs. Although reaching this step is already very beautiful, is this the end of micro-frontend?

The answer is no, micro-frontend boundaries can be further broadened.

The previous micro-frontend article https://time-friend.com/archive/qh7x5i5szfh/ introduced how to call React components between sub-modules with the same technology stack.

What we're talking about today is how sub-modules between different technology stacks call components from different technology stacks.

Ultimately, we only need to call relevant functional components according to our needs. We don't need to care whether they're written in React, Vue, or Angular.

You just use it, just know it's a component, don't worry too much~ This is extremely beneficial for team component accumulation.

## Scenario

Generally, a company's front-end team technology stack is unified. But there are also times when front-end teams use non-unified technology stacks.
For example:

1. Changes of the times, upgrading technology stack leads to internal technology stack inconsistency
2. Many projects, because requirements are inconsistent, other technology stacks are more powerful for projects
3. ...Other management reasons

When we've already used micro-frontend architecture to build our projects, our sub-modules might use other technology stacks due to project needs,

If we use other technology stacks, our originally encapsulated components can't be used in new projects, so we need components to be shared across frameworks.

## What Should We Do?

![](https://static.alili.tech/images/micro/microComponent.png)

Here we mention micro-component repository module, which is a separate project. You can understand it as an old project before. When you need a certain component from this old project, you can directly take it from this project.

You can also make it a project that only provides components. After all, at runtime, a sub-module mounted to our project has no resource consumption.

We just need to know where the components we need come from, then find this component based on the component and previously defined routes, call it, use it.

## Encapsulate Our Components Based on Web Components

Components developed by different frameworks have great differences. Wanting to string them together for use is basically impossible.
Fortunately, currently all frameworks support components existing in webcomponent form.

react: https://react.docschina.org/docs/web-components.html

vue : https://github.com/vuejs/vue-web-component-wrapper

angular: https://www.angular.cn/guide/elements#transforming-components-to-custom-elements

## Detailed Introduction About Web Components

https://developer.mozilla.org/zh-CN/docs/Web/Web_Components

## Loading Performance
If a page depends on many cross-framework components, network performance problems will inevitably occur.

![](https://static.alili.tech/images/micro/microComponent2.png)

We'll add a node service layer in the middle of requests. When pages request multiple cross-framework components, our node will merge them into a single file and save it on disk.

So, after this page has been requested, scattered page components will be merged together. When other users request it the second time, there won't be this merge file processing, directly return static resources to the client.

This method also won't put too much additional pressure on nodejs,

Because current page structures are still relatively statically stable, not too many dynamic customized things. This solution is sufficient to handle most application scenarios.

## Afterword

After continuous exploration, micro-frontend has finally reached this step of widgetization, quite emotional~

We went from a window that could only load a single page,
To multiple pages (SPA),
To now multiple projects (micro-frontend),
Then can control different components freely combining between multiple projects (widgetization).

Micro-frontend application boundaries should be able to expand wider, can develop more surprising operations.

# Related Series Articles

https://time-friend.com/tags/microfrontend/

