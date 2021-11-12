#!/bin/bash
curl -sL https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.6/graalvm-ce-java11-linux-amd64-19.3.6.tar.gz -o /tmp/graalvm-ce-java11-linux-amd64-19.3.6.tar.gz
tar -xvf /tmp/graalvm-ce-java11-linux-amd64-19.3.6.tar.gz-C /opt/java/
rm -fr /tmp/graalvm-ce-java11-linux-amd64-19.3.6.tar.gz

curl -s https://dlcdn.apache.org/maven/maven-3/3.8.3/binaries/apache-maven-3.8.3-bin.tar.gz -o /tmp/apache-maven-3.8.3-bin.tar.gz
tar -xvf /tmp/apache-maven-3.8.3-bin.tar.gz -C /opt/java/
rm -fr /tmp/apache-maven-3.8.3-bin.tar.gz

echo 'export GRAALVM_HOME=/opt/java/graalvm-ce-java11-19.3.6/' >> /root/.bashrc
echo 'export JAVA_HOME=$GRAALVM_HOME' >> /root/.bashrc
echo 'export MAVEN_HOME=/opt/java/apache-maven-3.8.3/' >> /root/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"'  >> /root/.bashrc

