export PATH=$PATH:/usr/local/go/bin:/opt/bin
export GOPATH=/usr/local/go
export HOME=/root

curl -O https://dl.google.com/go/go1.17.3.linux-amd64.tar.gz
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')
export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/v1.14.0
curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}

mkdir -p /usr/local/bin
chmod +x operator-sdk_linux_amd64
mv operator-sdk_linux_amd64 /opt/bin/operator-sdk
