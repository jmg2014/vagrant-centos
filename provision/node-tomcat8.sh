#!/bin/bash

# java
sudo yum install java-1.8.0-openjdk -y


# Create a dedicated user for Apache Tomcat
sudo groupadd tomcat
sudo mkdir /opt/tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

# Download and install Apache Tomcat.

sudo wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46.tar.gz
sudo tar -zxvf apache-tomcat-8.0.46.tar.gz -C /opt/tomcat --strip-components=1

chgrp -R tomcat /opt/tomcat/conf
chmod g+rwx /opt/tomcat/conf
chmod g+r /opt/tomcat/conf/*
chown -R tomcat /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/

sudo cp '/opt/vagrant/tomcat.service' '/etc/systemd/system/tomcat.service'

# Modify permission
sudo chmod +x /etc/systemd/system/tomcat.service


# Install ‘haveged’.
sudo yum install haveged -y
sudo systemctl enable haveged.service
sudo systemctl daemon-reload
sudo systemctl start haveged.service

# Start and test Apache Tomcat

sudo systemctl enable tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat.service

# Modify the firewall rules:

sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8443/tcp
sudo service firewalld restart