#!/usr/bin/env sh

echo "Acquire::http::Proxy \"http://10.0.3.1:3142\";"  > /etc/apt/apt.conf.d/01proxy
apt-get -y install wget 
wget --no-check-certificate -O - http://bootstrap.saltstack.org | sudo sh
