---
title: Basic Usage of Hugo Blog Building Tool
categories: [Blogging]
tags: [Hugo]
slug: obvozmdf
keywords: [Hugo,Blog,Migration]
date: 2018-11-15 16:14:25
---

Finally migrated blog to `Hugo`, initially most worried was this theme didn't exist on `Hugo` platform.
But got excited, spent two or three days. This theme. Completely migrated to `Hugo` platform.
Next I'll introduce `Hugo` usage and pitfalls encountered, and solutions.

# Hugo Performance
Precisely because hexo's performance couldn't satisfy, extremely unstable when generating static files. And time is relatively longer.
With same page count, processing speed hugo is 20 times or more than hexo. This is why I switched to Hugo.

# Configuration File
Two platforms have many commonalities, migration has much work that's very natural.
In configuration files hugo can also use yaml, so migrating from hexo will be relatively much better.
Additionally hugo can also use json as configuration file, providing users many choices.

# Hugo Basic Usage

## On Mac Platform
Mac Hugo provides homebrew installation method, very convenient.

```bash
brew install hugo
```
On Debian and Ubuntu Platform

```bash
sudo apt-get install hugo
```

## On Windows Platform
Windows Hugo provides Chocolatey installation method, through the following command.

```bash
choco install hugo -confirm
```

Verify Installation

After installation completes, we open terminal, enter the following command to verify if installation successful
```
hugo version
```


## Create a Site
```
hugo new site quickstart
```

## Add a Theme
```
cd quickstart;\
git init;\
git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke;\

# Edit your config.toml configuration file
# Add a theme called Ananke
echo 'theme = "ananke"' >> config.toml
```

## Create a New Article

```
hugo new posts/my-first-post.md
```

## Start Hugo Service Locally
```
hugo server -D
```

## Build Static Site
```
hugo
```

