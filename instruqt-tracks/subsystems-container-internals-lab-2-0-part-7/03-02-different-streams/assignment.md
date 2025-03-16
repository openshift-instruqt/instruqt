---
slug: 02-different-streams
id: ecpztuba19lq
type: challenge
title: Using the Fast and Stable Streams
tabs:
- title: Terminal 1
  type: terminal
  hostname: rhel
- title: Visual Editor
  type: code
  hostname: rhel
  path: /root
difficulty: intermediate
timelimit: 600
---
As mentioned in the previous step, there are two main types of streams. To view them, run the following command:

```
yum module list | grep container-tools
```

Notice there are two types:
1. container-tools:rhel8 - this is the fast moving stream, it's updated once every 12 weeks and generally fixes bugs by rolling to new versions
2. container-tools:1.0 - this was released with RHEL 8.0 and supported for 24 months, and receives bug fixes with back ports that keep the API and CLI interfaces stable
3. container-tools:2.0 - this was released with RHEL 8.2 and supported for 24 months, and receives bug fixes with back ports that keep the API and CLI interfaces stable

Now, let's pretend we are developer looking for access to the latest features in RHEL. Let's inspect the description of the fast moving stream. Notice that there are multiple versions of the rhel8 application stream. Every time a package is updated the entire group of packages is version controlled and tested together:

```
yum module info container-tools:rhel8
```

Now, let's install the fast moving container-tools:rhel8 Application Stream like this:

```
yum module install -y container-tools:rhel8
```

We should have a whole set of tools installed:

```
yum module list --installed
```

Look at the packages that were installed as part of this Application Stream:

```
yum module repoquery --installed container-tools
```

Look at the version of Podman that was installed. It should be fairly new, probably within a few months of what's latest upstream:

```
podman -v
```

Let's clean up the environment, and start from scratch:

```
yum module remove -y container-tools
yum module reset -y container-tools
```

OK, now let's pretend we are a systems administrator or SRE that wants a set of stable tools which are supported for 24 months. First, inspect the stable stream that was released in RHEL 8.0. Notice that there are several versions of this Application Stream. Every time a package is updated a new stream version is generated to snapshot the exact versions of each package together as a stream:

```
yum module info container-tools:1.0
```

Now, install it:

```
yum module install -y --allowerasing container-tools:1.0
```

Check the version of Podman again:

```
podman -v
```

Notice that it's an older version of Podman. This version only gets back ports and will never move beyond Podman 1.0.2. Note, there is no connection between the container-tools version number and the Podman version number. It is purely coincidence that these numbers coincide. The container-tools version number is an arbitrary number representing all of the tools tested together in the Application Stream. This includes, Podman, Buildah, Skopeo, CRIU, etc.

Now, let's go back to the latest version of the container-tools for the rest of this module:

```
yum module remove -y container-tools
yum module reset -y container-tools
yum module install -y container-tools:rhel8
```

Notice how easy it was to move between the stable streams and the fast moving stream. This is the power of modularity. Now, let's move on to using the actual tools.
