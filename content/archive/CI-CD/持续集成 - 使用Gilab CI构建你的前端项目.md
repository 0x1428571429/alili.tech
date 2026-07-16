---
title: 持续集成 - 使用Gilab CI进行前端项目的持续集成
slug: tisoqlkd0qa
date: 2019-09-20 23:15:00
keywords: Gitlab,CI,持续集成
categories: [DevOps]
tags: [CI/CD]
---


市面上的持续集成平台有很多,今天介绍Gitlab的CI.

从Gitlab 8.0开始,Gitlab CI 就集成在了Gitlab中.

使用方法非常简单,只要我们在项目的根目录创建一个 `.gitlab-ci.yml`文件,添加一个Runner,就直接接入了Gitlab CI.

接入方式非常的简单便捷.目前我们在前端脚手架中放一个`.gitlab-ci.yml`文件,后续每一个前端项目都可以按照标准直接接入Gitlab CI.



# GitLab Runner

所有的Gitlab任务都会放在Gitlab Runner中执行. 

GitLab Runner的安装环境,根据你的需求而定,一个gitlab 可以注册的Runner是没有限制的.

普通的前端项目直接安装在Linux中就可以了,如果是小程序或者RN这种项目,目前我是直接找了一台mac mini来安装Runner.



## GitLab Runner安装

安装Runner 非常简单, 这里晒出Gitlab的官方安装教程,你可以根据你的系统环境自行下载.

[安装Gitlab Runner 官方文档](https://docs.gitlab.com/runner/install/)


## 注册Runner

Runner安装好之后,想要关联到你的Gitlab,需要注册Runner.

这里给大家介绍群组的runner注册方式,个人项目的runner方式注册基本一致

[注册Gitlab Runner 官方文档](https://docs.gitlab.com/runner/register/)

大致流程为:

1. 打开Gitlab网站,选择群组-> 设置-> CI/CD -> 展开Runner -> 你会看到注册Runner的Token与Url
2. 安装好Runner的机器上,运行 `sudo gitlab-runner register`
3. 输入 你Gitlab的 URL
4. 输入 Token
5. 输入 Runner 的名字
6. 选择 Runner 的类型,没有特殊需求直接选shell
7. 完成

## 配置Runner

Runner的配置文件会以执行的用户身份不同而不同

1. 当GitLab Runner以root身份执行时 `/etc/gitlab-runner/config.toml`
2. 当GitLab Runner以非root身份执行时 `~/.gitlab-runner/config.toml`

### Runner的全局配置

这里我只说关键的两点

1. `concurrent` 配置会限制整个GitLab Runner能并发处理job的数量,如果你发现你的runner当前时间全局只能执行一个job的时候,
可以检查concurrent是否默认配置为1.不然多个job同一时段并发的时候,会造成job排队的现象.

2. `check_interval` 的配置为多久runner回去gitlab检查是否有job,默认实践为3秒.

[Runner 的高级配置 官方文档](https://docs.gitlab.com/runner/configuration/advanced-configuration.html)



## .gitlab-ci.yml
在项目下创建一个 `.gitlab-ci.yml` ,上传代码到gitlab,便可以根据`.gitlab-ci.yml`的描述执行任务
下面给一个非常简单的前端静态页面构建与部署的demo

```yaml
image: node:last

# job切换的时候,会清空git忽略的文件,一般dist目录会被忽略
# 但是job切换的时候,又需要保存dist,所以要配置dist的缓存
cache:
  paths:
  - dist/

# ci 运行步骤
stages:
  - build
  - deploy


# 构建
build:
  stage: build
  script: 
    - echo "Building the app"
    - crgt install
    - rm -rf ./dist
    - npm run build
  tags:
    - fe

# develop系列分支变动会触发测试环境的部署
deploy_test:
  stage: deploy
  script:
    - echo "测试环境部署"
    - cli upload ./本地目录 /线上目录
  only:
    # develop/* 分支变动后,会触发该stage
    - /^develop\/*/
  tags:
    - fe

# 当代码合并到master会触发 生产环境部署
deploy_production:
  stage: deploy
  script:
    - echo "Deploy to staging server"
    - cli upload ./本地目录  /线上目录
  only:
    - master
  tags:
    - fe

```








