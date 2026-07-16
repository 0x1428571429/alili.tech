---
title: 使用Travis CI自动化部署你的Hugo,Hexo博客
categories: [Blogging, DevOps]
tags: [Hugo, CI/CD, Travis, Hexo]
slug: oj8dtatmwzg
keywords: [Hugo, 博客, 自动化, Travis, Hexo]
date: 2018-11-20 16:14:25
---

# Travis CI 是什么?

Travis CI 是在线托管的 CI 服务，用 Travis 来进行持续集成，不需要自己搭服务器。最重要的是，它对开源项目是免费的。
如果公司是用的是 gitlab,也有提供相应的持续集成服务.这里就过多赘述.

# Travis CI 配置文件

Travis 要求项目的根目录下面，必须有一个`.travis.yml`文件。

当你的仓库有提交的时候,travis 会自动执行你下面配置的行为.

# Travis CI 的钩子与生命周期

## Travis 的钩子

Travis 有不同的阶段,他提供了 7 个钩子。

- before_install：install 阶段之前执行
- before_script：script 阶段之前执行
- after_failure：script 阶段失败时执行
- after_success：script 阶段成功时执行
- before_deploy：deploy 步骤之前执行
- after_deploy：deploy 步骤之后执行
- after_script：script 阶段之后执行

## 生命周期

1. before_install
2. install
3. before_script
4. script
5. aftersuccess or afterfailure
6. [OPTIONAL] before_deploy
7. [OPTIONAL] deploy
8. [OPTIONAL] after_deploy
9. after_script

# .travis.yml

下面是我的博客部署配置,也是我项目`.travis.yml`文件的内容.

## hugo

这是我的 hugo 部署配置,仅供参考

```yaml
language: node_js
node_js: 10.13.0
install:
  - wget https://github.com/gohugoio/hugo/releases/download/v0.51/hugo_0.51_Linux-64bit.deb
  - sudo dpkg -i hugo*.deb
  - hugo version
  - rm -rf public
  - npm install

script:
  - hugo --buildFuture
  - gulp
  - echo 'Build done!'
after_success:
  - git config --global user.name "Fan"
  - git config --global user.email "你的邮箱"
  - git clone https://${ACCESS_TOKEN}@github.com/Num142857/alili.tech.git container
  - rm -rf container/*
  - cp -r public/* container
  - cd container
  - git add .
  - git commit -m 'Travis upate blog'
  - git push -u origin gh-pages -f
```

## Hexo

这是我的 hexo 部署配置,仅供参考.

这是你已经有用`hexo-deployer-git`的配置,当然我也比较推荐使用这个插件,因为真的很方便.

到最后我们只需要使用`sed`命令替换`_config.yml`文件里面的发布地址,就可以免用户名密码发布到指定仓库了.

```yaml
language: node_js
node_js: 10.13.0
before_script:
  - git config user.name "Fan"
  - git config user.email "你的邮箱"
  - sed -i'' "s~https://github.com/Num142857/alili.tech.git~https://${ACCESS_TOKEN}@github.com/Num142857/alili.tech.git~" _config.yml
script:
  - hexo clean
  - hexo g
  - hexo d
```
