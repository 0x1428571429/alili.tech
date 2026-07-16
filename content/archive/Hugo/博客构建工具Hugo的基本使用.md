---
title: 博客构建工具Hugo的基本使用
categories: [Blogging]
tags: [Hugo]
slug: obvozmdf
keywords: [Hugo,博客,迁移]
date: 2018-11-15 16:14:25
---

最终还是把博客迁移到了`Hugo`,当初最纠结的是这套主题在`Hugo`平台上没有.
但是脑子一热，花了两三天时间。这套主题。全部迁移到了`Hugo`平台。
接下来就给大家介绍一下`Hugo`的使用以及踩到的坑,以及解决方案.

# Hugo的性能
正是因为hexo的性能不能满足,在生成静态文件的时候极其不稳定.而且时间也相对比较长一些.
在相同页面数量的情况下,处理速度hugo是hexo20倍及以上.这才是我换Hugo的原因.

# 配置文件
两个平台有很多共通的地方,迁移起来有很多工作是非常顺其自然的.
在配置文件上hugo也是可以使用yaml的,所以从hexo迁移过来会相对好很多.
其次hugo还可以使用json作为配置文件,为用户提供了很多选择.

# Hugo的基本使用

## Mac平台下
Mac下Hugo提供了homebrew安装的方式，非常简便。

```bash
brew install hugo
```
Debian and Ubuntu平台下

```bash
sudo apt-get install hugo
```

## Windows平台下
Windows下Hugo提供了Chocolatey方式的安装，通过如下命令即可。

```bash
choco install hugo -confirm
```

验证安装

安转完成后，我们打开终端，输入如下命令进行验证是否安装成功
```
hugo version
```


## 创建一个站点
```
hugo new site quickstart
```

## 添加一个主题
```
cd quickstart;\
git init;\
git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke;\

# 编辑你的 config.toml 配置文件
# 添加一个叫 Ananke 的主题
echo 'theme = "ananke"' >> config.toml
```

## 新建一篇文章

```
hugo new posts/my-first-post.md
```

## 本地开启Hugo服务
```
hugo server -D
```

## 构建静态站点
```
hugo
```