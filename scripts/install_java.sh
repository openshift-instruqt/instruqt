#!/bin/bash 

export MVN_VERSION=3.8.6

mkdir -p /opt/java
curl -s https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz -o /tmp/openjdk-17_linux-x64_bin.tar.gz
tar -xvf /tmp/openjdk-17_linux-x64_bin.tar.gz -C /opt/java/
rm -f /tmp/openjdk-17_linux-x64_bin.tar.gz

curl -s https://archive.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

tar -xzvf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt/java/
rm -fr /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

echo 'export JAVA_HOME=/opt/java/jdk-11/' >> /root/.bashrc
echo "export MAVEN_HOME=/opt/java/apache-maven-${MVN_VERSION}/" >> /root/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"'  >> /root/.bashrc
