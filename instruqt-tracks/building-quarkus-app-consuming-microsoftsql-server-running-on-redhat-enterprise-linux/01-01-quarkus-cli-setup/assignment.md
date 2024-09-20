---
slug: 01-quarkus-cli-setup
id: nwzsoxxjree2
type: challenge
title: Topic 1 - Quarkus CLI setup
notes:
- type: text
  contents: |
    ## Quarkus CLI Install
    In this lab we will install the Quarkus CLI in lab & with the help of Quarkus cli execute the CRUD application.
tabs:
- id: 0aiebxebzrn7
  title: Terminal 1
  type: terminal
  hostname: rhel
- id: jasta1nvcosk
  title: Terminal 2
  type: terminal
  hostname: rhel
difficulty: intermediate
timelimit: 1000
---
# Quarkus CLI Install

`Step1:` Run the following command in the **Terminal 1**

```
curl -Ls https://sh.jbang.dev | bash -s - trust add https://repo1.maven.org/maven2/io/quarkus/quarkus-cli/
```
```
curl -Ls https://sh.jbang.dev | bash -s - app install --fresh --force quarkus@quarkusio
```

Restart **Terminal 1** click on restart **↻** icon

Type the following command to check quarkus is successfully installed

```
quarkus
```

Quarkus is successfully installed click on **Next** now
