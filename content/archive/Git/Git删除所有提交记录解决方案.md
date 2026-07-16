---
title: Git删除所有提交记录解决方案
categories: [DevOps]
tags: [Git]
keywords: 'git,push,解决方案,删除所有,提交记录,删除'
slug: ed854758
date: 2018-10-30 19:33:33
---

如果你之前的项目提交了一些敏感数据,或者要清除以前提交的记录,给出下面解决方案.

```bash
# 1. 检出一个新的分支
git checkout --orphan latest_branch

# 2. 暂存所有文件
git add -A

# 3. 提交刚刚暂存的文件
git commit -am "commit message"


# 4. 删除最原始的分支
git branch -D master

# 5. 重命名当的第分支
git branch -m master

# 6. 提交你的记录到远程仓库
git push -f origin master
```
