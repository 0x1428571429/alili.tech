---
title: Hugo Blog Articles Not Displaying After Specified Time?
categories: [Blogging]
tags: [Hugo]
slug: hugo-articles-not-displaying
keywords: [Hugo,Blog,Migration]
date: 2018-11-18 16:14:25
---

Since switching the blog to Hugo, encountered some pitfalls.

Articles correctly added, page time adjusted to today, or after today, but cannot display in article list.

The reason is that when Hugo templates loop through files, articles exceeding the current time won't appear.


## Timezone Issue
If your article time doesn't specify a timezone.

Like this `2018-11-19 16:14:25`, the article likely won't display.

Hugo time is unified to Greenwich Mean Time, because China's time is 8 hours earlier than Greenwich Mean Time.
When Greenwich Mean Time hasn't reached your configured time, articles won't appear in the article list.

## Solution
Local server
```bash
hugo server --buildFuture
```

Page generation
```bash
hugo --buildFuture
```

