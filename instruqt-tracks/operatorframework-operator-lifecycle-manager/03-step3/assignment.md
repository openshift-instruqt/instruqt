---
slug: step3
id: un7pjl28zsve
type: challenge
title: Accessing OLM on the OpenShift Console
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 225
---
Access the OpenShift Web Console to also login from the Web UI:

```
oc get routes console -n openshift-console -o jsonpath='{"https://"}{.spec.host}{"\n"}'
```

Copy the URL from the output of the above command and open it in your browser.

We'll deploy our app as the `admin` user. Use the following credentials:

* Username:
```
admin
```

* Password:
```
admin
```

The OLM panel appears in the **Operators** pane:

![OLM on the OpenShift Console](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/operatorframework/operator-lifecycle-manager/olm-console.png)
