---
title: 'Taro Cross-Platform Development - Thoughts and Measures on the New Era of Cross-Platform Development'
categories: [Cross-Platform]
tags: [Taro,Cross-platform-Development,Front-end-Architecture]
slug: bjg2zsidz0a
keywords: Taro,Multi-platform Isomorphism,Front-end-Architecture,Multi-platform Development Skills,Cross-platform Development
date: 2020-06-16 22:17:36
---

## New Era

The emergence of cross-platform frameworks has transitioned front-end browser compatibility to a new era of client platform compatibility.

For startups, this type of framework can quickly test and reduce human and time costs.

## Why Choose Taro

> It's not that Taro solution is particularly excellent. At the current time point, all current cross-platform frameworks are still in the improvement stage. The most complete platforms might be mini programs and H5.

But for companies with strong cross-platform development needs, this is far from enough.

Taro just looked more suitable for our existing business at first glance. As the number of platforms increases, how to handle it calmly.

Currently still unknown. For teams, sudden surge in front-end output, other supporting facilities not keeping up equals ready to crash at any time. The biggest problem we currently face is testing resources.

For cross-platform technology, currently relatively complete and business-compatible technology frameworks to choose from:

1. Taro

2. uni-app

One React-like, one Vue-like.

At the framework level, both technology frameworks provide very similar multi-platform compatibility solutions.

The biggest difference is the difference between React and Vue. Of course, uni-app provides mini program container solutions.

Taro doesn't have this yet.

> Looking at Taro currently, directly implementing Taro to uni mini programs is theoretically achievable.

In Taro next version, Vue syntax is already supported. Will there be a situation of multi-platform framework to multi-platform framework in the future?

Back to the question itself, why did we choose Taro:

1. Team was built using React technology stack initially

2. We have some exploration on RN side

3. Taro supports Quick App

Looking at historical baggage, choosing Taro has relatively lower transition costs.

## Goals

1. One codebase, run on multiple platforms.

2. Reduce maintenance costs

3. Rapid multi-platform launch

> If looking at rapid launch, human costs in the short term are very considerable. But once projects get bigger, teams get bigger.

Automated testing, and project engineering not keeping up, then directly heaven becomes hell.

## Situation and Mindset

Currently using Taro to develop single platform, basically no major problems. Problems encountered currently can all be solved.

The only thing occupying development workload is how to handle code compatibility issues across platforms.

So methods and techniques for handling compatibility issues and awareness of multi-platform development are particularly important.

Another is developer mindset. Because we need to develop multiple platforms, platform differences will still exist.

While developing multiple platforms, also need to learn development methods for multiple platforms. Back and forth, it's easy to collapse mentally.

But if you cross this period, understand characteristics of each platform, you'll be able to handle some problems with ease later~

## Best Adaptation Path

After various practices, we believe the following development compatibility path is relatively simple.

During adaptation, mainly style problems are more common. If adapting in reverse, it will be extremely painful,

Because any line of code you wrote before could be a bug later.

> Possibly in future development, this type of shortcoming problem will become less and less obvious.

But looking at now, appropriate adaptation path is an important problem you must pay attention to.

RN --> Quick App --> Mini Program --> Other Mini Programs --> H5

## Brainstorming & Outlook

Looking at current cross-platform framework development trends, will the following events occur?

1. A cross-platform framework directly compatible with another framework, directly eating all platforms?

2. Open source a mini program-like container, directly replacing React Native and Weex?

3. Will multi-platform testing frameworks (one set of test cases, test all platforms) emerge?

## Afterword

In the following period, I will organize the following problems and team practices into articles for everyone to think about.

1. How to transform native mini programs into Taro framework?

2. How to transform native Quick Apps into Taro framework?

3. How to use Taro correctly to develop React Native?

3. How to design a front-end architecture that spans multiple platforms, supports business module hot-plugging, and multi-team collaboration

4. Cross-platform compatibility techniques based on Taro and workarounds for platform shortcomings

5. How should we debug and solve when encountering Taro bugs

6. Summary and solutions for problems encountered on each platform

