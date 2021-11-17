#!/bin/bash


curl -s https://dl.google.com/go/go1.16.3.linux-amd64.tar.gz -o /tmp/go1.16.3.linux-amd64.tar.gz 

tar -xvf /tmp/go1.16.3.linux-amd64.tar.gz -C /usr/local/
rm -f /tmp/go1.16.3.linux-amd64.tar.gz

mkdir -p /root/tutorial/go

echo 'export GOROOT=/usr/local/go' >> /root/.bashrc
echo 'export GOPATH=/root/tutorial/go/' >> /root/.bashrc
echo 'export GOBIN=/root/tutorial/go/bin' >> /root/.bashrc
echo 'export PATH=$GOROOT/bin:$PATH' >> /root/.bashrc
