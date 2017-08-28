#!/bin/bash

# Install
sudo yum install epel-release -y
sudo yum install wget net-tools locate -y
sudo yum update -y

# Start Firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
