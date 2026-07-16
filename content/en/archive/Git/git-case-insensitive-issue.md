---
title: Git Case-Insensitive Causing Annoying Problem
categories: [DevOps]
tags: [Git]
slug: git-case-insensitive-issue
keywords: git,case sensitivity,solution
date: 2019-01-09 19:33:33
---

> Because a colleague changed a folder name from lowercase to uppercase, I couldn't directly push, rebase and other operations locally. Very annoying~

```bash
error: The following untracked working tree files would be overwritten by checkout:
        xxx.js
Please move or remove them before you can switch branches.
Aborting
```

# Solution 
Set to case-sensitive (must restore configuration after problem is solved)
``` bash
git config core.ignorecase false
```
Although setting case-sensitive will always affect code in other branches, so it's not recommended to use this configuration permanently. After the problem is solved, it should be changed back.


# Restore Default
``` bash
git config core.ignorecase true
# or
git config --unset core.ignorecase
```


# Conclusion

When coding normally, never directly rename case. It looks fine locally, but it's a big problem for others.

If similar problems occur, they should be solved at the source (whoever renamed it on their machine should change it back). If not solved, they should be dragged out and beaten~~


