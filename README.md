# OpenShift Labs on Instruqt

Welcome to the OpenShift Labs on Instruqt repositories. This repo contains the source code of our self-paced labs you can access at https://developers.redhat.com/learn

To learn more about Instruqt for OpenShift Labs, check out our internal presentation [here](https://docs.google.com/presentation/d/1J-QQoiRbrkLzrbuvAZeISBuSmgS2_mIHD9XdbMumuTo/edit?usp=sharing).

## Instruqt

This repository contains images and tracks for the [Instruqt](https://instruqt.com) platform. Red Hat is using Instruqt for in-browser demonstrations of OpenShift labs, as well as the Ansible Automation Platform and RHEL. Please refer to the [Instruqt Documentation](https://docs.instruqt.com) to understand how it works.

### Using Instruqt

The first thing to do is to download the [Instruqt CLI](https://docs.instruqt.com/reference/software-development-kit-sdk), which allows you to create new tracks, push tracks, and more. This [how-to](https://docs.instruqt.com/how-to-guides/build-tracks) guide on building tracks provides a great reference in pair with our  internal presentation for OpenShift-specific labs.

### Login to Instruqt

If don't have an account on Instruqt, create a new account: https://play.instruqt.com/login

Login with the CLI:

```
instruqt auth login
```

This will open a browser where you can login, then your CLI session is authenticated.

The OpenShift Instruqt organization page is hosted at https://play.instruqt.com/openshift


### Track Pull

You can download an existing track by referencing it's slug:

```
instruqt track pull openshift/operatorframework-k8s-api-fundamentals
```

### Track Push

From within a track folder, you can push the change to your track in this way:

```
instruqt track push
```

### Check Logs

You can check the logs from your track in this way:

```
instruqt track logs
```

## Track Development

Here's how to get started on working on or maintaining an Instruqt OpenShift track:

### Updating an existing track

1. Change into the directory containing your repository and create a new branch. Make sure to push the new branch to GitHub as well:
    ```
    cd <repository_dir>
    git pull
    git checkout -b my-new-branch
    git push -u origin my-new-branch
    ```
2. Run the convert workflow, providing the branch and track slug you wish to modify:
    ```
    gh workflow run "convert" -F "slug=<track-slug>" -r my-new-branch
    ```
3. Pull the changes made by the workflow (the name and IDs will be modified):
    ```
    git pull origin my-new-branch
    ```
4. Make your changes to the dev version of the track:
    ```
    cd instruqt-tracks/<track-slug>
    # make your changes...
    ```
5. Make sure your final local changes are reflected in the track on Instruqt, because it will be used as the source of truth for the development version of the track:
    ```
    instruqt track validate
    instruqt track push
    instruqt track open
    instruqt track test
    ```
6. Add, commit, and push your changes to GitHub:
    ```
    git add .
    git commit -m "Adding new content!"
    git push
    ```
7. Once you are satisfied with your development track, and the latest changes have been pushed to Instruqt, run the promote workflow:
    ```
    gh workflow run "promote" -F "slug=<track-slug>" -r my-new-branch
    ```
8. Create a pull request by selecting **Pull requests** in the top menu of your repository, followed by **New pull request**. Indicate your new branch, and select **Create pull request**.
9. Have a colleague review your work, and merge the pull requests. Once merged, the changes will automatically be applied to the production version of your track.

### Creating a new track

To create a new track, review our [examples](https://github.com/openshift-instruqt/instruqt/tree/master/examples) and select a starting point that matches your requirements:

*Start from an OpenShift template track*

```
cd instruqt-tracks
instruqt track create --from openshift/openshift-example-track --title "My First OpenShift Track"
```

This creates an example track using CRC 4.11 VM with `root` user and authenticated by default with `system:admin` as in [this example](https://github.com/openshift-instruqt/instruqt/tree/master/examples/openshift-example-track):

*Alternatively, start from an OpenShift template track with a Fedora sidecar*

```
cd instruqt-tracks
instruqt track create --from openshift/openshift-example-track-with-fedora-sidecar --title "My First OpenShift Track with Fedora Sidecar"
```

This creates an example track using CRC 4.11 VM and a sidecar Fedora container using `root` user where to install packages/dependencies.
The container can be connected to the CRC VM with the oc CLI as in [this example](https://github.com/openshift-instruqt/instruqt/tree/master/examples/openshift-example-track-with-fedora-sidecar):

#### Add the new track to the CI system

**TIP: The folder name and slug name (within your `track.yml` file) must match**

1. Your new track should be stored inside a folder that matches your slug name within the `instruqt-tracks` folder.
2. After your track has been merged into master, [run the `generate` action (by click on the "Run workflow" button)](https://github.com/openshift-instruqt/instruqt/actions/workflows/generate-track-slugs.yml) to enroll your track in CI.

## Platform Integration Points

### Checking Challenge Execution

Add scripts to check challenge execution: 
* https://docs.instruqt.com/how-to-guides/build-tracks/build-challenges/add-a-script-to-check-challenge-execution
* https://docs.instruqt.com/concepts/lifecycle-scripts#challenge-check-script

The scripts should be stored within the challenge folder, alongside the `assignment.md` file.  The name of the script should match the name of your container or VM, for example: `check-crc` or `check-container` (if using the sidecar)

### Web Console

If Web Console access is required, replace Katacoda dynamic URLs with this snippet that will let user access to OpenShift from the web console by printing the HTTPS URL. The hypertext is highlighted so it's easy to access then by just clicking on it: 

```
    Access the OpenShift Web Console to login from the Web UI:
    ```
    oc get routes console -n openshift-console -o jsonpath='{"https://"}{.spec.host}{"\n"}'
    ```
    Copy the URL from the output of the above command and open it in your browser.
    We'll deploy our app as the `developer` user. Use the following credentials:
    * Username:
    ```
    developer
    ```
    * Password:
    ```
    developer
    ```
```

### Routes

Replace Katacoda's dynamic URLs for routes with this snippet:

```
    Get the URL from command line, from *Terminal 1* run this command to get the app's Route:

    ```
    oc get route <route-name> -n <namespace> -o jsonpath='{"http://"}{.spec.host}{"/taster"}{"\n"}'

    ```

    Copy the URL and open it in your browser, or click it from here.
```

### Assets

There's no relative path concept from assets like in Katacoda's index.json, so you need to download them from internet from the `setup-crc` or `setup-container` script and store in the expected path.

As a convention, we store files into track's `script` dir and images into track's `assets` dir:

```
├── assets
│   ├── images
│   │   └── ansible-op-flow.png
│   ├── podset_controller.go
│   └── podset_types.go
├── config.yml
├── scripts
│   ├── my_script.sh
├── step1
├── step2
├── step3
│   └── setup-container
├── step4
│   └── setup-container
├── step5
├── step6
│   └── setup-container
├── step7
├── track_scripts
│   ├── setup-container
│   └── setup-crc
└── track.yml
```

E.g. from `setup-crc`:

```
#!/bin/bash

curl -s https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/scripts/operatorframework/go-operator-podset/podset_types.go -o /tmp/podset_types.go
```

### CRC Image

We are currently using native virtualization with a CRC 4.11 (`rhd-devx-instruqt/openshift-4-11-7-lgph7
`)

The setting to have this image is from the `config.yml` file:

```
version: "3"
virtualmachines:
- name: crc
  image: rhd-devx-instruqt/openshift-4-11-7-lgph7
  machine_type: n1-highmem-4
  allow_external_ingress:
  - http
  - https
  - high-ports
```

We can also have a sidecar container that can connect to the CRC VM with oc CLI in this way:

```
version: "3"
containers:
- name: container
  image: fedora
  shell: /bin/bash
virtualmachines:
- name: crc
  image: rhd-devx-instruqt/openshift-4-11-7-lgph7
  machine_type: n1-highmem-4
  allow_external_ingress:
  - http
  - https
  - high-ports
```

The connection is made inside the setup scripts like [this one](https://github.com/openshift-instruqt/instruqt/blob/master/developing-on-openshift/developing-with-odo/track_scripts/setup-container). Please refer to Instruqt's documentation to understand [track lifecycle scripts](https://docs.instruqt.com/tracks/lifecycle-scripts).
