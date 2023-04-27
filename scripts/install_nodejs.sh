#!/bin/bash

export NODEJS_VERSION=18.15.0
export NODEJS_DISTRO=linux-x64

mkdir -p /opt/nodejs
curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-${NODEJS_DISTRO}.tar.gz -o /tmp/nodejs-${NODEJS_DISTRO}-${NODEJS_VERSION}.tar.gz
tar -xvf /tmp/nodejs-${NODEJS_DISTRO}-${NODEJS_VERSION}.tar.gz -C /opt/nodejs/
rm -rf /tmp/nodejs-${NODEJS_DISTRO}-${NODEJS_VERSION}.tar.gz

echo "export NODEJS_HOME=/opt/nodejs/node-v${NODEJS_VERSION}-${NODEJS_DISTRO}/" >> /root/.bashrc
echo 'export PATH="$NODEJS_HOME/bin:$PATH"'  >> /root/.bashrc
