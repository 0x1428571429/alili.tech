---
title: 自动化部署前端代码 - grunt-ftp-deploy的使用
slug: '20901007'
date: 2015-06-14 23:36:00
keywords: grunt,CI/CD,前端自动发布,前端自动部署,grunt-ftp-deploy
categories: [DevOps]
tags: [CI/CD]
---

每一次修改完代码之后,要部署到远程的服务器,我的操作步骤是:

修改代码 --> grunt build --> 打开FileZilla -->登录ftp服务器 -->找到本地文件夹 --> 找到远程服务器目标文件夹 -->全选本地文件 --> 上传

因为部署代码,在某个时候会特别频繁.每一次都要重复上面的八个操作.表示要做点什么,改变一下.

今天我们的主角:grunt-ftp-deploy

如果是sftp可以使用grunt-sftp-deploy

安装:

```
npm install grunt-ftp-deploy --save-dev

or

npm install grunt-sftp-deploy --save-dev
```
<!-- more -->

在与Gruntfile文件同一目录,我们新建一个".ftppass"的文件,
里面是ftp的授权信息,
内容如下:
```json
{
  "key1": {
    "username": "username",
    "password": "password"
  }
}
```

Gruntfile配置代码:

```javascript
//ftp-deploy
 grunt.initConfig({
   'ftp-deploy': {
     build: {
       auth: {
         host: '192.168.1.245', //ftp服务器的ip地址
         port: 21,//服务器端口
         authKey: 'key1'//.ftppass文件里,key1的授权信息
       },
       src: 'path/to/source/folder',//本地文件夹
       dest: '/path/to/destination/folder',//服务器的目标文件夹
       exclusions: ['path/to/source/folder/**/.DS_Store']//不上传的文件
     }
   }
 })
```
or
```javascript
//sftp-deploy
 grunt.initConfig({
   'sftp-deploy': {
     build: {
       auth: {
         host: '192.168.1.245', //ftp服务器的ip地址
         port: 21,//服务器端口
         authKey: 'key1'//.ftppass文件里,key1的授权信息
       },
       cache: 'false',
       src: 'path/to/source/folder', //本地文件夹
       dest: '/path/to/destination/folder', //服务器的目标文件夹
       serverSep: '/',//服务器的相对路径
       localSep: '/',//本地的相对路径
       concurrency: 20,//每次上传多少个文件
       progress: true //是否显示进度条
     }
   }
 })
```



加载task
```
grunt.loadNpmTasks('grunt-ftp-deploy');

or

grunt.loadNpmTasks('grunt-sftp-deploy');
```


在控制台输入:
```
grunt ftp-deploy

or

grunt sftp-deploy
```

这样,文件就会自动上传到目标服务器了


但是,这样还是不够方便,把task加入到 build里面
```javascript
  grunt.registerTask('build', [
    'clean:dist',
    'useminPrepare',
    'concurrent:dist',
    'postcss',
    'ngtemplates',
    'concat',
    'copy:dist',
    'ngAnnotate',
    'cssmin',
    'usemin',
    'htmlmin',
    'compress',
    'ftp-deploy'//--> 我在这里
  ]);
```
那我们现在部署代码的步骤就是:

修改代码 --> grunt build


今天就到这里.
