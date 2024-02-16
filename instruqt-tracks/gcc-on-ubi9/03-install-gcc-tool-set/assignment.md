---
slug: install-gcc-tool-set
id: qm2rxeocoifg
type: challenge
title: Install GCC Tool Set
teaser: Download and install GCC Toolset
notes:
- type: text
  contents: In this challenge, we will fetch and install the GCC Toolset packages
    on UBI9.
tabs:
- title: Terminal
  type: terminal
  hostname: ubi9
difficulty: ""
---
# Set up your development environment
In this step, you will use a single command to download and install GCC 12.x and other development tools that are part of the Red Hat Developer Toolset.

Download and install the development tools package group, which includes GNU Compiler Collection (GCC), GNU Debugger (GDB), and other development tools, using following command :
```
dnf group install "Development Tools" -y
```
After installation of GCC Toolset, click on the **check** button.