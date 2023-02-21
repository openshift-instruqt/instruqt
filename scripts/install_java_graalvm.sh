#!/bin/bash

export GRAALVM_VERSION=22.3.1
export MVN_VERSION=3.8.6

mkdir -p /opt/java
curl -sL https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz -o /tmp/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz
tar -xvf /tmp/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz -C /opt/java/
rm -fr /tmp/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz

curl -s https://archive.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz
tar -xzvf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt/java/
rm -fr /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

echo "export GRAALVM_HOME=/opt/java/graalvm-ce-java17-${GRAALVM_VERSION}/" >> /root/.bashrc
echo 'export JAVA_HOME=$GRAALVM_HOME' >> /root/.bashrc
echo "export MAVEN_HOME=/opt/java/apache-maven-${MVN_VERSION}/" >> /root/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"'  >> /root/.bashrc
