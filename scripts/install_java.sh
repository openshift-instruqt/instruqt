#!/bin/bash 

export MVN_VERSION=3.8.4

mkdir -p /opt/java
curl -s https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz -o /tmp/openjdk-11_linux-x64_bin.tar.gz
tar -xvf /tmp/openjdk-11_linux-x64_bin.tar.gz -C /opt/java/
rm -f /tmp/openjdk-11_linux-x64_bin.tar.gz

curl -s https://dlcdn.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz
tar -xzvf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt/java/
rm -fr /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

echo 'export JAVA_HOME=/opt/java/jdk-11/' >> /root/.bashrc
echo 'export MAVEN_HOME=/opt/java/apache-maven-${MVN_VERSION}/' >> /root/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"'  >> /root/.bashrc