#!/bin/bash

# Install mysql
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo rpm -ivh mysql57-community-release-el7-11.noarch.rpm
sudo yum install mysql-server -y

sudo firewall-cmd --zone=public --permanent --add-port=3308/tcp
sudo service firewalld restart

sudo systemctl start mysqld
sudo systemctl enable mysqld


MYSQL_TEMPORARY_ROOT_PASSWORD=$(grep "temporary password" /var/log/mysqld.log | awk '{print $11}')

# Database
 mysql --user="root" --password="$MYSQL_TEMPORARY_ROOT_PASSWORD"  --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewP@ssword2017'"
 mysql --user="root" --password="MyNewP@ssword2017"  -e "CREATE DATABASE IF NOT EXISTS my_db;"

# user
 mysql --user="root" --password="MyNewP@ssword2017"  -e "CREATE USER new_User@'%' IDENTIFIED BY 'newUserP@assword2017';"
 mysql --user="root" --password="MyNewP@ssword2017"  -e "CREATE USER new_User@'gateway' IDENTIFIED BY 'newUserP@assword2017';"
 mysql --user="root" --password="MyNewP@ssword2017"  -e "CREATE USER new_User@'localhost' IDENTIFIED BY 'newUserP@assword2017';"
 mysql --user="root" --password="MyNewP@ssword2017"  -e "GRANT ALL PRIVILEGES ON * . * TO 'new_User'@'%';"
 mysql --user="root" --password="MyNewP@ssword2017"  -e "GRANT ALL PRIVILEGES ON * . * TO 'new_User'@'gateway';"
 mysql --user="root" --password="MyNewP@ssword2017"  -e "GRANT ALL PRIVILEGES ON * . * TO 'new_User'@'localhost';"
 mysql --user="root" --password="MyNewP@ssword2017"  -e "FLUSH PRIVILEGES;"

# schema
mysql --user="root" --password="MyNewP@ssword2017" my_db < /opt/vagrant/database/schemas/my_db.sql
