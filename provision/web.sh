#!/bin/bash

# Install apache
yum install httpd -y

cat > /var/www/html/index.html <<EOD
<html><head><title>${HOSTNAME}</title></head><body><h1>${HOSTNAME}</h1>
<p>This is the default web page for ${HOSTNAME}.</p>
</body></html>
EOD

sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo service firewalld restart

sudo service hhtpd start
