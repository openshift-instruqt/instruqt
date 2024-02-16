---
slug: step3
id: qesyzrfwqyn8
type: challenge
title: Run sample C++ app using GCC toolset
teaser: Run sample app of c++
notes:
- type: text
  contents: Compile the C++ sample app using the GCC command-line interface (CLI)
    and execute it.
tabs:
- title: Terminal
  type: terminal
  hostname: ubi9
difficulty: ""
---
# Fetch sample app and run with GCC Toolsets
We will clone the repository of a sample C++ app using git command.
```
git clone https://github.com/redhat-developer-demos/gcc-sample-app.git  && cd gcc-sample-app
```

With help of GCC cli, compile the sample app as shown below.

```
 g++ -o hello hello.cpp
```
Ensure sample has been compiled and verify it is marked executable using the following command.
```
ls
```
Execute the compiled file using following command.
```
./hello
```
After successful execution, you will see the message `Hello, Red Hat Developers Program World` on the terminal.
Congratulations!! You have completed the GCC lab. Click on the **check** button to end the lab.