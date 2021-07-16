#!/bin/bash
sudo yum install https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm -y
sudo amazon-linux-extras install epel -y
sudo yum install mysql-community-server -y
sudo chkconfig mysqld on  
sudo service mysqld start
sudo mysqladmin -u root password 'wahaj123a'
sudo mysql -u root -pwahaj123a -e  "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;use wahajdb;create user 'wordpress'@'localhost' identified by 'wahaj123a';  grant all on testdb.* to 'wordpress';GRANT ALL ON wordpress.* TO ' wordpress '@'localhost';GRANT ALL ON wordpress* TO ' wordpress '@'%';FLUSH PRIVILEGES;"

