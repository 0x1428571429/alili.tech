---
title: Continuous Integration - Code Quality Scanning
slug: continuous-integration-code-quality-scanning
date: 2019-12-15 23:15:00
keywords: Gitlab,CI,Continuous Integration
categories: [DevOps]
tags: [CI/CD]
---

To facilitate managing company code quality, integrating code quality scanning with continuous integration is an important step.
Currently the company is relatively young, but in just one year, we've had close to 300 frontend projects.

With so many frontend projects, how we ensure code quality becomes a very important matter.

With too many code projects, code review is necessary. But manual code review cannot guarantee efficiency.
Due to differences in individual levels and familiarity with company standards, we cannot guarantee consistent standards across all projects.
Some potential bugs may also be missed.

Our company is based on Gitlab CI/CD, so the following instructions are based on Gitlab. But the ideas can be applied universally, those in need can learn from the approach.



## Modify .gitlab-ci.yml
To facilitate each project's integration, we made minimal changes to the configuration.
And the configuration changes for each project are the same, just for convenient copy-paste.

We also created a CLI tool that includes all code scanning functionality. Installed on the runner machine.

```yaml
image: node:11.10.0

stages:
  - codereview # Add a codereview stage

codereview:
  stage: codereview
  script:
    - cli codereview # CLI tool triggers codereview
  tags:
    - fe #runner tag, modify according to your situation
```


# What does CLI trigger code scanning do?

## Execute SonarQube Scanning

> Regarding SonarQube installation, there are many tutorials online, please search yourself.

1. Install `sonar-scanner` on the machine executing the runner

```bash
npm i sonar-scanner -g
```

2. Use the self-developed CLI tool to generate sonar scanning configuration file in the project root directory.

```js

// Get GitLab CI injected environment variables
const {
  CI_PROJECT_NAME,
  CI_PROJECT_ID,
} = process.env;

// Generate a sonar projectKey based on GitLab project id
const projectBuffer = Buffer.from('sonar' + CI_PROJECT_ID);
const projectKey = projectBuffer.toString('hex');

// Detect code directory
// Generally src is the directory for frontend project business code
// Because company's nodejs projects are based on egg framework, it could also be app
const existsSrc = fs.existsSync(`${process.cwd()}/src/`);



// Sonar configuration file template
const sonarProject = `
sonar.projectKey=${projectKey} 

sonar.projectName=${CI_PROJECT_NAME}

sonar.projectVersion=1.0

sonar.sources=${existsSrc ? 'src' : 'app'}

sonar.binaries=bin

sonar.host.url=http://xxx.your-deployed-sonar-service-address.com 

sonar.login=admin

sonar.password=admin

sonar.sourceEncoding=UTF-8
`;
    // Generate a path
    const sPath = path.resolve(process.cwd(), 'sonar-project.properties');

    // Write sonar configuration
    fs.writeFileSync(sPath, sonarProject);

    // Execute sonar code scanning and upload code quality report
    shelljs.exec('sonar-scanner');
```


## Execute jscpd to Analyze Code Duplication Rate
Although sonar already provides code duplication rate reports, it's not very easy to see where code is duplicated.
We use jscpd to analyze project duplication rate and output friendly reports.


1. Install jscpd

```bash
npm install jscpd -g
```


2. Use self-developed CLI tool to trigger jscpd scanning project

```js
// Detect code directory
// Generally src is the directory for frontend project business code
// Because company's nodejs projects are based on egg framework, it could also be app
const existsSrc = fs.existsSync(`${process.cwd()}/src/`);


// Finally outputs two things in root directory
// One is page report
// One is json data
// How to use it is up to you
    if (existsSrc) {
      shelljs.exec('jscpd -r html ./src/');
      shelljs.exec('jscpd -r json ./src/');
    } else {
      shelljs.exec('jscpd -r html ./app/');
      shelljs.exec('jscpd -r json ./app/');
    }
```
Finally deploy the page report to a static server, get the page address and push it to specified people and groups using enterprise chat tools.


## Conclusion

I only provide the general approach here, these two tools have many more uses, won't go into detail here. Interested friends can search on their own.

That's all for today
