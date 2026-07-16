---
title: 在公司搭建私有的cnpm服务器
categories: [Backend]
tags: [Node.js]
slug: eed8d24e
keywords:  Node.js,ts,私有,服务器,typescript,verdaccio,npm,浏览器,cnpm
date: 2017-11-24 22:30:05
---

现在的js的项目越来越多。如果我们把代码开源。我们会把这些代码发布到npm。
但是npm是公共的，公司的代码毕竟不会公开在网上。
于是我们就有必要搭建一个自己的npm服务器。把公司私有的代码发布在自己公司的npm服务器上。
这样我们就可以即方便的下载我们想要的代码。也可以不把这些代码放在开源平台上面

## 安装的基本步骤

1. 在linu安装mysql
2. npm install cnpm.org  下载cnpm.org的代码
3. 配置好cnpm.org的数据库配置
4. npm start

在安装过程中，我们只有这简单的4步。不管哪里遇到各种各样的问题，都不会脱离这4个步骤。


## 开始吧
### 在linux安装mysql
网上有很多相关教程，请自行搜索。如果有需要我会重新开一篇来讲述安装步骤。
我们假设这里我们创建了一个用户为：root 密码：root1234
1. 创建数据库
```
CREATE DATABASE cnpmjs
```
2. 建表： 

在cnpm.org代码里，doc/db.sql文件里面有创建cnpm.org的相关表的sql语句
```
mysql> use cnpmjs;
mysql> source docs/db.sql
```

### 在代码里配置sql信息

在cnpm.org代码里的 config/config.js配置我们的数据库连接信息.

找到以下mysqlServers相关代码,配置大致如下：

``` javascript
    mysqlServers: [
      {
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'root1234',  // 这是我们刚刚创建的账户跟密码
      }
    ],
```

### 安装cnpm.org 的相关js依赖（这是jser们再熟悉不过的了）
 
 进入cnpm.org代码目录

 ```
 npm install
 ``` 
 

 ### 最后一步 
当里的js依赖装好了之后，cnpm.org的数据库配置也配置好了以后。
再命令行里 运行一下命令：

```
npm start
```

好了，我们的cnpm服务器就这样简单的搭建成功了。

* 默认web端口为：7002，当你浏览器输入这台机器的ip加端口便可以访问 cnpm.org应用的web页面了。
 本机访问则是：http://localhost:7002

* registry 默认端口为： 7001

> 如果在其他机器始终访问不了你的应用。请检查你的服务器防火墙哦。

### 尝试使用
```
    npm install webpack -g --registry=http://192.168.0.100:7001 // IP为你搭建服务器的地址，不要忘加端口号
```

如果你觉得以上方式麻烦可以设置里本机npm 默认registry
```
npm config set registry http://192.168.0.100:7001
```

## cnpm.org的相关配置

``` javascript
{
enableCluster：是否启用 cluster-worker 模式启动服务，默认 false，生产环节推荐为 true;
registryPort： API 专用的 registry 服务端口，默认 7001；
webPort： Web 服务端口，默认 7002；
bindingHost：监听绑定的 Host ，默认为 127.0.0.1，如果外面架了一层本地的 Nginx 反向代理或者 Apache 反向代理的话推荐不用改；
sessionSecret：session 用的盐；
logdir：日志目录；
uploadDir：临时上传文件目录；
viewCache：视图模板缓存是否开启，默认为 false；
enableCompress：是否开启 gzip 压缩，默认为 false；
admins：管理员们，这是一个 JSON Object，对应各键名为各管理员的用户名，键值为其邮箱，默认为 { fengmk2: 'fengmk2@gmail.com', admin: 'admin@cnpmjs.org', dead_horse: 'dead_horse@qq.com' }；
logoURL：Logo 地址，不过对于我这个已经把 CNPM 前端改得面目全非的人来说已经忽略了这个配置了；
adBanner：广告 Banner 的地址；
customReadmeFile：实际上我们看到的 cnpmjs.org 首页中间一大堆冗长的介绍是一个 Markdown 文件转化而成的，你可以设置该项来自行替换这个文件；
customFooter：自定义页脚模板；
npmClientName：默认为 cnpm，如果你有自己开发或者 fork 的 npm 客户端的话请改成自己的 CLI 命令，这个应该会在一些页面的说明处替换成你所写的；
backupFilePrefix：备份目录；
database：{
    //数据库相关配置，为一个对象，默认如果不配置将会是一个 ~/.cnpmjs.org/data.sqlite 的 SQLite ；
    db：数据的库名；
    username：数据库用户名；
    password：数据库密码；
    dialect：数据库适配器，可选 "mysql"、"sqlite"、"postgres"、"mariadb"，默认为 "sqlite"；
    hsot：数据库地址；
    port：数据库端口；
    pool：{
        //数据库连接池相关配置，为一个对象；
        maxConnections：最大连接数，默认为 10；
        minConnections：最小连接数，默认为 0；
        maxIdleTime：单条链接最大空闲时间，默认为 30000 毫秒；
    }
    storege：仅对 SQLite 配置有效，数据库地址，默认为 ~/.cnpmjs/data.sqlite；
},
nfs：包文件系统处理对象，为一个 Node.js 对象，默认是 fs-cnpm 这个包，并且配置在 ~/.cnpmjs/nfs 目录下，也就是说默认所有同步的包都会被放在这个目录下；开发者可以使用别的一些文件系统插件（如上传到又拍云等）,又或者自己去按接口开发一个逻辑层，这些都是后话了；
registryHost：暂时还未试过，我猜是用于 Web 页面显示用的，默认为 r.cnpmjs.org；
enablePrivate：是否开启私有模式，默认为 false；
//如果是私有模式则只有管理员能发布包，其它人只能从源站同步包；
//如果是非私有模式则所有登录用户都能发布包；
scopes：非管理员发布包的时候只能用以 scopes 里面列举的命名空间为前缀来发布，如果没设置则无法发布，也就是说这是一个必填项，默认为 [ '@cnpm', '@cnpmtest', '@cnpm-test' ]，据苏千大大解释是为了便于管理以及让公司的员工自觉按需发布；更多关于 NPM scope 的说明请参见 npm-scope；
privatePackages：就如该配置项的注释所述，出于历史包袱的原因，有些已经存在的私有包（可能之前是用 Git 的方式安装的）并没有以命名空间的形式来命名，而这种包本来是无法上传到 CNPM 的，这个配置项数组就是用来加这些例外白名单的，默认为一个空数组；
sourceNpmRegistry：更新源 NPM 的 registry 地址，默认为 https://registry.npm.taobao.org；
sourceNpmRegistryIsCNpm：源 registry 是否为 CNPM ，默认为 true，如果你使用的源是官方 NPM 源，请将其设为 false；
syncByInstall：如果安装包的时候发现包不存在，则尝试从更新源同步，默认为 true；
syncModel：更新模式（不过我觉得是个 typo），有下面几种模式可以选择，默认为 "none";
// "none"：永不同步，只管理私有用户上传的包，其它源包会直接从源站获取；
// "exist"：定时同步已经存在于数据库的包；
// "all"：定时同步所有源站的包；
syncInterval：同步间隔，默认为 "10m" 即十分钟；
syncDevDependencies：是否同步每个包里面的 devDependencies 包们，默认为 false；
badgeSubject：包的 badge 显示的名字，默认为 cnpm；
userService：用户验证接口，默认为 null，即无用户相关功能也就是无法有用户去上传包，该部分需要自己实现接口功能并配置，如与公司的 Gitlab 相对接，这也是后话了；
alwaysAuth：是否始终需要用户验证，即便是 $ cnpm install 等命令；
httpProxy：代理地址设置，用于你在墙内源站在墙外的情况。
}

```

参考文章：
[https://www.v2ex.com/t/292046](https://www.v2ex.com/t/292046)







