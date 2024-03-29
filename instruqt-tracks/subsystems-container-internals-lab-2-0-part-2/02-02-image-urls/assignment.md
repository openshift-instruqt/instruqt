---
slug: 02-image-urls
id: 7m9rsnatudgq
type: challenge
title: 'Topic 2 - Image URLs: Mapping business requirements to the URL, Namespace,
  Repository and Tag'
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/labs
difficulty: intermediate
timelimit: 900
---
Now we are going to inspect the different parts of the URL that you pull. The most common command is something like this, where only the repository name is specified:

```
podman inspect ubi7/ubi
```

But, what's really going on? Well, similar to DNS, the podman command line is resolving the full URL and TAG of the repository on the registry server. The following command will give you the exact same results:

```
podman inspect registry.access.redhat.com/ubi7/ubi:latest
```

You can run any of the following commands, and you will get the exact same results as well:

```
podman inspect registry.access.redhat.com/ubi7/ubi:latest
```

```
podman inspect registry.access.redhat.com/ubi7/ubi
```

```
podman inspect ubi7/ubi:latest
```

```
podman inspect ubi7/ubi
```

Now, let's build another image, but give it a tag other than "latest":

```
podman build -t ubi7:test -f ~/labs/lab2-step1/Dockerfile
```

Now, notice there is another tag.

```
podman images
```

Now try the resolution trick again. What happened?

```
podman inspect ubi7
```

It failed, but why? Try again with a complete URL:

```
podman inspect ubi7:test
```

Notice that podman resolves container images similar to DNS resolution. Each container engine is different, and Docker will actually resolve some things podman doesn't because there is no standard on how image URIs are resolved. If you test long enough, you will find many other caveats to namespace, repository, and tag resolution. Generally, it's best to always use the full URI, specifying the server, namespace, repository, and tag. Remember this when building scripts. Containers seem deceptively easy, but you need to pay attention to details.
