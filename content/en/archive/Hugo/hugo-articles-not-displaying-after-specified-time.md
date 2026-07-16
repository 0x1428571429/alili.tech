---
title: Hugo Platform Articles Not Displaying After Specified Time?
categories: [Blogging]
tags: [Hugo]
slug: yqufemb0c1m
keywords: [Hugo,Blog,Migration]
date: 2018-11-18 16:14:25
---

Since blog switched to Hugo, encountered some pitfalls.

Clearly correctly added articles, page time adjusted to today, or after today but cannot display in article list.

Reason is Hugo template when looping through files, articles exceeding current time won't appear.

## Timezone Issue
If your article time doesn't specify timezone.

Like this `2018-11-19 16:14:25`, article likely won't display.

Hugo time is unified to Greenwich Mean Time, because China's time is 8 hours earlier than Greenwich Mean Time.
When Greenwich Mean Time hasn't reached your configured time, articles won't appear in article list.

## Solution
Local service
```bash
hugo server --buildFuture
```

Page generation
```bash
hugo --buildFuture
```

