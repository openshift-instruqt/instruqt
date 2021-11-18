#!/bin/bash
curl -s https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/scripts/install_go.sh | bash

source /root/.bashrc

# Download dep
curl -s https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Download Operator SDK
export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')
export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/v1.8.0


curl -sL ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH} -o /usr/local/bin/operator-sdk
chmod +x /usr/local/bin/operator-sdk


# Download local assets

curl -s https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/operatorframework/go-operator-podset/scripts/podset_types.go -o /tmp/podset_types.go 
curl -s https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/operatorframework/go-operator-podset/scripts/podset_controller.go -o /tmp/podset_types.go
curl -s https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/operatorframework/go-operator-podset/scripts/app_v1alpha1_podset.yaml -o /tmp/app_v1alpha1_podset.yaml
