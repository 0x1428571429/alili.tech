---
title: Automated Deployment of Hugo, Hexo Blog with Travis CI
categories: [Blogging, DevOps]
tags: [Hugo, CI/CD, Travis, Hexo]
slug: oj8dtatmwzg
keywords: [Hugo, Blog, Automation, Travis, Hexo]
date: 2018-11-20 16:14:25
---

# What is Travis CI?

Travis CI is an online hosted CI service. Using Travis for continuous integration doesn't require setting up your own server. Most importantly, it's free for open source projects.
If company uses gitlab, it also provides corresponding continuous integration services. Won't elaborate here.

# Travis CI Configuration File

Travis requires project root directory must have a `.travis.yml` file.

When your repository has commits, travis will automatically execute the behaviors you configured below.

# Travis CI Hooks and Lifecycle

## Travis Hooks

Travis has different stages, it provides 7 hooks.

- before_install: Execute before install stage
- before_script: Execute before script stage
- after_failure: Execute when script stage fails
- after_success: Execute when script stage succeeds
- before_deploy: Execute before deploy step
- after_deploy: Execute after deploy step
- after_script: Execute after script stage

## Lifecycle

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

Below is my blog deployment configuration, also my project's `.travis.yml` file content.

## hugo

This is my hugo deployment configuration, for reference only

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
  - git config --global user.email "your-email"
  - git clone https://${ACCESS_TOKEN}@github.com/Num142857/alili.tech.git container
  - rm -rf container/*
  - cp -r public/* container
  - cd container
  - git add .
  - git commit -m 'Travis upate blog'
  - git push -u origin gh-pages -f
```

## Hexo

This is my hexo deployment configuration, for reference only.

This is if you already use `hexo-deployer-git` configuration, of course I also recommend using this plugin, because it's really convenient.

In the end we just need to use `sed` command to replace publish address in `_config.yml` file, can publish to specified repository without username password.

```yaml
language: node_js
node_js: 10.13.0
before_script:
  - git config user.name "Fan"
  - git config user.email "your-email"
  - sed -i'' "s~https://github.com/Num142857/alili.tech.git~https://${ACCESS_TOKEN}@github.com/Num142857/alili.tech.git~" _config.yml
script:
  - hexo clean
  - hexo g
  - hexo d
```

