---
title: React系列之用create-react-native-app创建React Native应用
categories: [Frontend]
tags: [React]
slug: bb62bab9
keywords: react,props,脚手架,React Native,rn,expo
date: 2017-07-30 19:33:33
---
之前在介绍create-react-app的时候稍微提了一下create-react-native-app.

这东西其实用起来还是蛮有意思的.这东西最大的好处就是如果你没有安装Xcode,Android Studio这些工具的时候,也是可以在电脑上调试React Native 应用的.

> 这里说的电脑包括 Mac Windows Linux!!!!

[create-react-native-app](https://github.com/react-community/create-react-native-app/)

# Create React Native App 安装
```
$ npm install -g create-react-native-app
$ create-react-native-app my-app
$ cd my-app/
$ npm start
```
安装 [Expo](https://expo.io) 这个APP在你的iphone或者安卓手机上. npm start 之后,控制台会出现一个二维码.用这个Expo 扫描这个二维码,就可以马上在你的手机上直接进行远程调试了.那是相当的方便啊.但是速度还是相对桌面模拟器调试慢一点.

![](https://static.alili.tech/images/expo-qrcode.png)


# Expo的桌面开发工具 Expo XDE

[Expo XDE](https://expo.io/tools)

我们不仅可以在控制里运行整个项目,用XDE也可以.并且支持使用模拟器直接在电脑里直接调试程序.速度不错,完全可以接受.

只不过我Mac的模拟器在安装expo的时候,花了好长的一段时间.如果大家有遇到类似的情况一定要耐心的等一等.

![](https://static.alili.tech/images/xde.png)