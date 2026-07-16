---
title: Angular Path Alias Configuration
slug: angular-path-alias-configuration
date: 2018-12-27 22:17:36
keywords: [Angular,Path Alias,Template]
categories: [Frontend]
tags: [Angular]
---

Angular CLI has webpack built-in, so path aliases can be configured.
The configuration method is almost the same.

# Configure Path Alias
Find the `tsconfig.json` file in your project root directory.

Note: If your configuration doesn't take effect, check if your `baseUrl` is configured correctly.

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

## Before Configuration
```js
import { Api } from '../../../../../services/api.service';
import { xxx } from '../../../../../services/api.xxx';
```

## After Configuration

```js
import { Api } from '@services/api.service';
import { xxx } from '@services/api.xxx';
```

Some development tips, hope this helps you.
