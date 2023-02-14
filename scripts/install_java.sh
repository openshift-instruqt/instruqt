#!/bin/bash 

export MVN_VERSION=3.8.6

mkdir -p /opt/java

cd /tmp && curl -LJO https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.6%2B10/OpenJDK17U-jdk_x64_linux_hotspot_17.0.6_10.tar.gz
tar -xzvf /tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.6_10.tar.gz -C /opt/java/
rm -f /tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.6_10.tar.gz

curl -s https://archive.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

tar -xzvf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt/java/
rm -fr /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

echo 'export JAVA_HOME=/opt/java/jdk-17.0.6+10/' >> /root/.bashrc
echo "export MAVEN_HOME=/opt/java/apache-maven-${MVN_VERSION}/" >> /root/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"'  >> /root/.bashrc
