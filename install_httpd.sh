#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
echo 'guff' > /var/www/html/index.html

