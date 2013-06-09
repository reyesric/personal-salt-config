#!/usr/bin/env sh

apt-get -y install wget 
wget --no-check-certificate -O - http://bootstrap.saltstack.org | sudo sh
