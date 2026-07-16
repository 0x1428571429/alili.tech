---
title: Continuous Integration - Using GitLab CI for Frontend Project Continuous Integration
slug: tisoqlkd0qa
date: 2019-09-20 23:15:00
keywords: Gitlab,CI,Continuous Integration
categories: [DevOps]
tags: [CI/CD]
---

There are many continuous integration platforms on the market. Today I'll introduce GitLab's CI.

Starting from GitLab 8.0, GitLab CI has been integrated into GitLab.

Usage is very simple. As long as we create a `.gitlab-ci.yml` file in the project root directory and add a Runner, we directly integrate GitLab CI.

Integration method is very simple and convenient. Currently we put a `.gitlab-ci.yml` file in the front-end scaffold, and every subsequent front-end project can directly integrate GitLab CI according to standards.

# GitLab Runner

All GitLab tasks will be executed in GitLab Runner.

GitLab Runner installation environment depends on your needs. There's no limit to how many Runners a gitlab can register.

For ordinary front-end projects, just install in Linux. For mini programs or RN projects, I currently directly found a mac mini to install Runner.

## GitLab Runner Installation

Installing Runner is very simple. Here's GitLab's official installation tutorial. You can download according to your system environment.

[GitLab Runner Installation Official Documentation](https://docs.gitlab.com/runner/install/)

## Register Runner

After Runner is installed, to associate it with your GitLab, you need to register the Runner.

Here I'll introduce group runner registration method. Personal project runner registration method is basically the same.

[GitLab Runner Registration Official Documentation](https://docs.gitlab.com/runner/register/)

General process:

1. Open GitLab website, select Group -> Settings -> CI/CD -> Expand Runner -> You'll see Runner registration Token and Url
2. On the machine with Runner installed, run `sudo gitlab-runner register`
3. Enter your GitLab URL
4. Enter Token
5. Enter Runner name
6. Select Runner type, if no special requirements, directly select shell
7. Complete

## Configure Runner

Runner configuration files differ based on executing user identity

1. When GitLab Runner executes as root `/etc/gitlab-runner/config.toml`
2. When GitLab Runner executes as non-root `~/.gitlab-runner/config.toml`

### Runner Global Configuration

Here I'll only mention two key points

1. `concurrent` configuration will limit the number of jobs the entire GitLab Runner can process concurrently. If you find your runner can only execute one job globally at the current time,
you can check if concurrent is default configured to 1. Otherwise, when multiple jobs are concurrent at the same time, it will cause job queuing.

2. `check_interval` configuration is how often runner checks gitlab for jobs, default is 3 seconds.

[Runner Advanced Configuration Official Documentation](https://docs.gitlab.com/runner/configuration/advanced-configuration.html)

## .gitlab-ci.yml
Create a `.gitlab-ci.yml` under the project, upload code to gitlab, and tasks can be executed according to `.gitlab-ci.yml` description.
Below is a very simple demo for front-end static page build and deployment

```yaml
image: node:last

# When switching jobs, git ignored files will be cleared, generally dist directory will be ignored
# But when switching jobs, dist needs to be saved, so need to configure dist cache
cache:
  paths:
  - dist/

# ci running steps
stages:
  - build
  - deploy


# Build
build:
  stage: build
  script: 
    - echo "Building the app"
    - crgt install
    - rm -rf ./dist
    - npm run build
  tags:
    - fe

# develop branch changes will trigger test environment deployment
deploy_test:
  stage: deploy
  script:
    - echo "Test environment deployment"
    - cli upload ./local-directory /online-directory
  only:
    # After develop/* branch changes, will trigger this stage
    - /^develop\/*/
  tags:
    - fe

# When code merges to master will trigger production environment deployment
deploy_production:
  stage: deploy
  script:
    - echo "Deploy to staging server"
    - cli upload ./local-directory  /online-directory
  only:
    - master
  tags:
    - fe

```

