---
title: Git push卡住解决办法
categories: [DevOps]
tags: [Git]
slug: 629795fd
keywords: git,push,解决方案
date: 2018-04-09 19:33:33
---

博客的每天英语是直接爬的扇贝英语,为了不直接请求代理接口(会相对比较慢).
所以每天我的程序每天会生成相应的数据文件,前端直接ajax获取就好了.
博客内容也会每天自动发布,达到每天更新名言名句的效果.
好久没管,发现很多git提交的内容没有push.手动直接push之后发现有800多个修改地方没有push.

手动push的时候直接卡住了.
就像这样:

```bash
[master 9447645] 
1 file changed, 1 insertion(+)
Counting objects: 20, done.
Compressing objects: 100% (876/876), done.
Writing objects: 100% (876/876)
```

网上找了个方法,解决了这个问题:
添加sendpack.sideband属性并置为false
```bash
# 全局的：
git config –global sendpack.sideband false

# 仓库的：
git config –local sendpack.sideband false
```

我只在我的本地仓库设置一下,然后再执行 `git push`就成功了