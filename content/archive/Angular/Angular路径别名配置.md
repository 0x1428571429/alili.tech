---
title: Angular路径别名配置
slug: 3u54dxnerfn
date: 2018-12-27 22:17:36
keywords: [Angular,路径别名,模版]
categories: [Frontend]
tags: [Angular]
---

angular cli 内置了 webpack,所以也是可以配置路径别名的.
而且配置的方式几乎是一样的.

# 配置路径别名
找到你的项目根目录的 `tsconfig.json` 文件.

注意: 如果你的配置不生效,需要查看你的`baseUrl`是否配置正确.

```json
{
    "compilerOptions": {
        "baseUrl": "./src/", 
        "paths": {
            "@app/*": ["app/*"],
            "@services/*": ["app/services/*"]
        }
    }
}

```

## 配置之前
```js
import { Api } from '../../../../../services/api.service';
import { xxx } from '../../../../../services/api.xxx';
```

## 配置之后

```js
import { Api } from '@services/api.service';
import { xxx } from '@services/api.xxx';
```

一些开发中的小技巧,希望可以帮到你.