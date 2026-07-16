---
title: Git Delete All Commit History Solution
categories: [DevOps]
tags: [Git]
keywords: 'git,push,solution,delete all,commit history,delete'
slug: git-delete-all-commits-solution
date: 2018-10-30 19:33:33
---

If your previous project committed some sensitive data, or you want to clear previous commit history, here's the solution.

```bash
# 1. Check out a new branch
git checkout --orphan latest_branch

# 2. Stage all files
git add -A

# 3. Commit the staged files
git commit -am "commit message"


# 4. Delete the original branch
git branch -D master

# 5. Rename the current branch
git branch -m master

# 6. Push your history to the remote repository
git push -f origin master
```

