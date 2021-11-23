#!/bin/bash

export MVN_VERSION=3.8.4
export MANDREL_VERSION=21.2.0.2-Final

curl -sL https://github.com/graalvm/mandrel/releases/download/mandrel-${MANDREL_VERSION}/mandrel-java11-linux-amd64-${MANDREL_VERSION}.tar.gz -o /tmp/mandrel.tar.gz && cd /usr/local && sudo tar -xvzf /tmp/mandrel.tar.gz && rm -rf /tmp/mandrel.tar.gz
curl -s https://dlcdn.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz
tar -xzvf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt/java/
rm -fr /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

echo 'export GRAALVM_HOME=/usr/local/mandrel-java11-${MANDREL_VERSION}' >> /root/.bashrc
echo 'export MAVEN_HOME=/opt/java/apache-maven-${MVN_VERSION}/' >> /root/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"'  >> /root/.bashrc