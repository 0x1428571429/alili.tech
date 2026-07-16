---
title: Git大小写不敏感导致的烦人问题
categories: [DevOps]
tags: [Git]
slug: rrc7ngyr5rp
keywords: git,大小写,解决方案
date: 2019-01-09 19:33:33
---

> 因为同事把一个文件夹的小写改成了大写,导致我本地的提交不能直接push rebase 等一些列操作.恼的很~

```bash
error: The following untracked working tree files would be overwritten by checkout:
        xxx.js
Please move or remove them before you can switch branches.
Aborting
```

# 解决办法 
设置为大小写敏感(问题解决后,一定要还原配置)
``` bash
git config core.ignorecase false
```
尽管设置大小写敏感之后,始终会影响其他分支的代码,所以不建议一直使用这个配置,当问题解决之后,还是要改回去.


# 改回默认
``` bash
git config core.ignorecase true
# or
git config --unset core.ignorecase
```


# 尾巴

平时编码的时候,还是千万不要直接重命名大小写,自己本地看起来没有什么问题.在别人问题上却是大问题.

如果发生了类似问题的,应该在源头解决(谁机器上重命名的,谁改回去).如果不解决的,应该拖出去打~~


