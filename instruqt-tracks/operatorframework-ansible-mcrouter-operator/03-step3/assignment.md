---
slug: step3
id: vhgnuwxbrymz
type: challenge
title: Using Mcrouter
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 360
---
We can now verify connectivity to our Memcached pool via Mcrouter.

Let's begin by exposing the Mcrouter Pod as a Service accessible to the Cluster.

```
oc expose deploy/mcrouter --name mcrouter --type=ClusterIP --target-port=5000
```

Create a temporary telnet Pod and connect to Mrouter:

```
oc run -it --rm telnet --image=registry.redhat.io/rhel8/support-tools --restart=Never -- telnet mcrouter 5000
```

After a few seconds you will see a message `If you don't see a command prompt, try pressing enter.` ***But do not press enter***. Run the following commands to insert the key `ansible` with an 8 byte value of `operator` for 900 seconds and exit:

```
set ansible 0 900 8
operator
get ansible
quit
```

We can also utilize the `mcperf` tool for measuring Memcached server performance.

This command will create ***1000*** connections to Mcrouter. The connections are created at the rate of ***1000*** conns/sec and on every connection it sends ***10*** `set` requests at the rate of ***1000*** reqs/sec with the item sizes derived from a uniform distribution in the interval of 1 to 16 bytes:

```
oc run -it --rm mcperf --image=quay.io/madorn/mcperf --restart=Never -- mcperf -s mcrouter -p 5000 --linger=0 --timeout=5 --conn-rate=1000 --call-rate=1000 --num-calls=10 --num-conns=1000 --sizes=u1,16
```

We should be able to see a significant spike in CPU/Memory usage from running the above command. You can check it out by selecting the ***Console*** tab which will open the OpenShift dashboard. Log in with username: `admin`, password: `admin`, and then select ***Monitoring*** --> ***Dashboards***. Also be sure to run the following command:

```
oc adm policy add-cluster-role-to-user cluster-admin admin
```
