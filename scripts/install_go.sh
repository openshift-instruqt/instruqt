#!/bin/bash


curl -s https://dl.google.com/go/go1.17.3.linux-amd64.tar.gz -o /tmp/go1.17.3.linux-amd64.tar.gz 

tar -xvf /tmp/go1.17.3.linux-amd64.tar.gz -C /usr/local/
rm -f /tmp/go1.17.3.linux-amd64.tar.gz

echo 'export GOPATH=/usr/local/go' >> /root/.bashrc
echo 'export PATH=$GOPATH/bin:$PATH' >> /root/.bashrc
