---
title: Git Push Stuck Solution
categories: [DevOps]
tags: [Git]
slug: git-push-stuck-solution
keywords: git,push,solution
date: 2018-04-09 19:33:33
---

The blog's daily English is directly scraped from Shanbay English. To avoid directly requesting proxy interfaces (which would be relatively slow).
So my program generates corresponding data files every day, and the frontend directly gets them via ajax.
Blog content is also automatically published every day, achieving the effect of updating famous quotes and sentences daily.
Haven't checked for a long time, found many git commits weren't pushed. After manually pushing, found there were over 800 modifications not pushed.

When manually pushing, it got stuck directly.
Like this:

```bash
[master 9447645] 
1 file changed, 1 insertion(+)
Counting objects: 20, done.
Compressing objects: 100% (876/876), done.
Writing objects: 100% (876/876)
```

Found a method online that solved this problem:
Add sendpack.sideband attribute and set it to false
```bash
# Global:
git config –global sendpack.sideband false

# Repository:
git config –local sendpack.sideband false
```

I only set it in my local repository, then executed `git push` and it succeeded

