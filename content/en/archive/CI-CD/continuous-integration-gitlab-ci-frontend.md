---
title: Continuous Integration - Using GitLab CI for Frontend Project Continuous Integration
slug: continuous-integration-gitlab-ci-frontend
date: 2019-09-20 23:15:00
keywords: Gitlab,CI,Continuous Integration
categories: [DevOps]
tags: [CI/CD]
---


There are many continuous integration platforms on the market, today I'll introduce GitLab CI.

Starting from GitLab 8.0, GitLab CI has been integrated into GitLab.

The usage is very simple, as long as we create a `.gitlab-ci.yml` file in the project root directory and add a Runner, we directly integrate GitLab CI.

The integration method is very simple and convenient. Currently we put a `.gitlab-ci.yml` file in the frontend scaffold, and subsequent frontend projects can directly integrate GitLab CI according to standards.



# GitLab Runner

All GitLab tasks will be executed in GitLab Runner. 

GitLab Runner installation environment depends on your needs, there's no limit to how many Runners a GitLab can register.

For regular frontend projects, installing directly in Linux is fine. For projects like mini-programs or RN, I currently directly found a Mac Mini to install Runner.



## GitLab Runner Installation

Installing Runner is very simple, here's GitLab's official installation tutorial, you can download according to your system environment.

[GitLab Runner Installation Official Documentation](https://docs.gitlab.com/runner/install/)


## Register Runner

After Runner is installed, to associate it with your GitLab, you need to register the Runner.

Here I'll introduce the group runner registration method, individual project runner registration is basically the same

[GitLab Runner Registration Official Documentation](https://docs.gitlab.com/runner/register/)

The general process is:

1. Open GitLab website, select Group -> Settings -> CI/CD -> Expand Runner -> You'll see the Token and Url for registering Runner
2. On the machine with Runner installed, run `sudo gitlab-runner register`
3. Enter your GitLab URL
4. Enter Token
5. Enter Runner name
6. Select Runner type, if no special requirements directly select shell
7. Complete

## Configure Runner

Runner configuration files differ based on the executing user identity

1. When GitLab Runner executes as root `/etc/gitlab-runner/config.toml`
2. When GitLab Runner executes as non-root `~/.gitlab-runner/config.toml`

### Runner Global Configuration

Here I'll only mention two key points

1. `concurrent` configuration limits the number of jobs the entire GitLab Runner can process concurrently. If you find your runner can only execute one job globally at the current time,
you can check if concurrent is default configured to 1. Otherwise when multiple jobs run concurrently at the same time, it will cause job queuing.

2. `check_interval` configuration is how often the runner checks GitLab for jobs, default is 3 seconds.

[Runner Advanced Configuration Official Documentation](https://docs.gitlab.com/runner/configuration/advanced-configuration.html)



## .gitlab-ci.yml
Create a `.gitlab-ci.yml` under the project, upload code to GitLab, and tasks can be executed according to `.gitlab-ci.yml` description
Below is a very simple demo for frontend static page build and deployment

```yaml
image: node:last

# When switching jobs, git ignored files will be cleared, generally dist directory is ignored
# But when switching jobs, dist needs to be preserved, so configure dist cache
cache:
  paths:
  - dist/

# CI execution steps
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

# Changes to develop branch series will trigger test environment deployment
deploy_test:
  stage: deploy
  script:
    - echo "Test environment deployment"
    - cli upload ./local-directory /online-directory
  only:
    # After develop/* branch changes, this stage will be triggered
    - /^develop\/*/
  tags:
    - fe

# When code merges to master, production environment deployment will be triggered
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









