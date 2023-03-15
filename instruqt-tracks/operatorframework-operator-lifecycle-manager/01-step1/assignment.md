---
slug: step1
id: x1xjubrnqhrx
type: challenge
title: Exploring OLM
notes:
- type: text
  contents: |-
    ![Operator Lifecycle Manager](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/operatorframework/operator-lifecycle-manager/olm-logo.png)

    The [Operator Lifecycle Manager](https://github.com/operator-framework/operator-lifecycle-manager) project is a component of the Operator Framework, an open source toolkit to manage Kubernetes native applications, called Operators, in an effective, automated, and scalable way.

    OLM extends Kubernetes to provide a declarative way to install, manage, and upgrade operators and their dependencies in a cluster. It also enforces some constraints on the components it manages in order to ensure a good user experience.

    OLM enables users to do the following:

    # Over-the-Air Updates and Catalogs

    Kubernetes clusters are being kept up to date using elaborate update mechanisms today, more often automatically and in the background. Operators, being cluster extensions, should follow that. OLM has a concept of catalogs from which Operators are available to install and being kept up to date. In this model OLM allows maintainers granular authoring of the update path and gives commercial vendors a flexible publishing mechanism using channels.

    # Dependency Model

    With OLM's packaging format, Operators can express dependencies on the platform and on other Operators. They can rely on OLM to respect these requirements as long as the cluster is up. In this way, OLM's dependency model ensures Operators stay working during their long lifecycle across multiple updates of the platform or other Operators.

    # Discoverability

    OLM advertises installed Operators and their services into the namespaces of tenants. They can discover which managed services are available and which Operator provides them. Administrators can rely on catalog content projected into a cluster, enabling discovery of Operators available to install.

    # Cluster Stability

    Operators must claim ownership of their APIs. OLM will prevent conflicting Operators owning the same APIs being installed, ensuring cluster stability.

    # Declarative UI controls

    Operators can behave like managed service providers. Their user interface on the command line are APIs. For graphical consoles OLM annotates those APIs with descriptors that drive the creation of rich interfaces and forms for users to interact with the Operator in a natural, cloud-like way.
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
The Operator Lifecycle Manager (OLM) is included with [OpenShift 4](https://try.openshift.com) and can easily be installed in a non-OpenShift Kubernetes environment by running [this simple command](https://operatorhub.io/how-to-install-an-operator#).

Let's get started exploring OLM by viewing its Custom Resource Definitions (CRDs).

OLM ships with 6 CRDs:

* **CatalogSource**:
    * A collection of Operator metadata (ClusterServiceVersions, CRDs, and PackageManifests). OLM uses CatalogSources to build the list of available operators that can be installed from OperatorHub in the OpenShift web console. In OpenShift 4, the web console has added support for managing the out-of-the-box CatalogSources as well as adding your own custom CatalogSources. You can create a custom CatalogSource using the [OLM Operator Registry](https://github.com/operator-framework/operator-registry).
* **Subscription**:
    * Relates an operator to a CatalogSource. Subscriptions describe which channel of an operator package to subscribe to and whether to perform updates automatically or manually. If set to automatic, the Subscription ensures OLM will manage and upgrade the operator to ensure the latest version is always running in the cluster.
* **ClusterServiceVersion (CSV)**:
    * The metadata that accompanies your Operator container image. It can be used to populate user interfaces with info like your logo/description/version and it is also a source of technical information needed to run the Operator. It includes RBAC rules and which Custom Resources it manages or depends on. OLM will parse this and do all of the hard work to wire up the correct Roles and Role Bindings, ensuring that the Operator is started (or updated) within the desired namespace and check for various other requirements, all without the end users having to do anything. You can easily build your own CSV with [this handy website](https://operatorhub.io/packages) and read about the [full CSV architecture in more detail](https://github.com/operator-framework/operator-lifecycle-manager/blob/master/doc/design/architecture.md#what-is-a-clusterserviceversion).
* **PackageManifest**:
    * An entry in the CatalogSource that associates a package identity with sets of CSVs. Within a package, channels point to a particular CSV. Because CSVs explicitly reference the CSV that they replace, a PackageManifest provides OLM with all of the information that is required to update a CSV to the latest version in a channel (stepping through each intermediate version).
* **InstallPlan**:
    * Calculated list of resources to be created in order to automatically install or upgrade a CSV.
* **OperatorGroup**:
    * Configures all Operators deployed in the same namespace as the OperatorGroup object to watch for their Custom Resource (CR) in a list of namespaces or cluster-wide.

Observe these CRDs by running the following command:

```
oc get crd | grep -E 'catalogsource|subscription|clusterserviceversion|packagemanifest|installplan|operatorgroup'
```



OLM is powered by controllers that reside within the `openshift-operator-lifecycle-manager` namespace as three Deployments (catalog-operator, olm-operator, and packageserver):

```
oc -n openshift-operator-lifecycle-manager get deploy
```