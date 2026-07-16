---
title: Automated Deployment Frontend Code - Using grunt-ftp-deploy
slug: '20901007'
date: 2015-06-14 23:36:00
keywords: grunt,CI/CD,Front-end Auto Publish,Front-end Auto Deploy,grunt-ftp-deploy
categories: [DevOps]
tags: [CI/CD]
---

Every time after modifying code, need to deploy to remote server, my operation steps are:

Modify code --> grunt build --> Open FileZilla --> Login ftp server --> Find local folder --> Find remote server target folder --> Select all local files --> Upload

Because deploying code, at some times will be particularly frequent. Every time need to repeat the above eight operations. Want to do something, change this.

Today our protagonist: grunt-ftp-deploy

If using sftp can use grunt-sftp-deploy

Installation:

```
npm install grunt-ftp-deploy --save-dev

or

npm install grunt-sftp-deploy --save-dev
```
<!-- more -->

In same directory as Gruntfile, we create a ".ftppass" file,
Inside is ftp authorization information,
Content as follows:
```json
{
  "key1": {
    "username": "username",
    "password": "password"
  }
}
```

Gruntfile configuration code:

```javascript
//ftp-deploy
 grunt.initConfig({
   'ftp-deploy': {
     build: {
       auth: {
         host: '192.168.1.245', //ftp server ip address
         port: 21,//Server port
         authKey: 'key1'//.ftppass file, key1 authorization information
       },
       src: 'path/to/source/folder',//Local folder
       dest: '/path/to/destination/folder',//Server target folder
       exclusions: ['path/to/source/folder/**/.DS_Store']//Files not to upload
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
         host: '192.168.1.245', //ftp server ip address
         port: 21,//Server port
         authKey: 'key1'//.ftppass file, key1 authorization information
       },
       cache: 'false',
       src: 'path/to/source/folder', //Local folder
       dest: '/path/to/destination/folder', //Server target folder
       serverSep: '/',//Server relative path
       localSep: '/',//Local relative path
       concurrency: 20,//How many files to upload each time
       progress: true //Whether to show progress bar
     }
   }
 })
```



Load task
```
grunt.loadNpmTasks('grunt-ftp-deploy');

or

grunt.loadNpmTasks('grunt-sftp-deploy');
```


Enter in console:
```
grunt ftp-deploy

or

grunt sftp-deploy
```

This way, files will automatically upload to target server


But, this still isn't convenient enough, add task to build
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
    'ftp-deploy'//--> I'm here
  ]);
```
Then our code deployment steps are now:

Modify code --> grunt build


That's all for today.

