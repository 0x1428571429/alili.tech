---
title: A Bug Caused by .gitattributes File from Two Years Ago
categories: [DevOps]
tags: [Git]
slug: gitattributes-bug-from-two-years-ago
keywords: git
date: 2019-01-24 19:33:33
---

# Cause

On a whim, I opened a frontend project I wrote two years ago to start code review.
I wrote this project alone for two years, roughly over a hundred thousand lines of code.

Found that Git in this project recognized all code files as binary files.
This problem had troubled me for a long time, but I couldn't find the cause. This led to my code having no diff history.

> Even the most stubborn problems will be solved one day

Coincidentally, I found the root cause today.

# .gitattributes

Finally found that a line in the `.gitattributes` file had a line break issue. This caused all text files to be recognized as binary files.

## Purpose of .gitattributes

.gitattributes file is a simple text file. Its purpose is to redefine attributes of specified files, specify diff/merge methods for non-text files.

### Writing Rules

```
pattern    attr1 attr2 ...
```

### Example

```
*.ttf binary
*.woff binary
*.eot binary
*.otf binary
* text=auto
```
The above code indicates that some font files are specified as binary files. When committing code, Git won't diff the change details of these files.
It will only tell you the file changed, but won't tell you specifically what changed.

