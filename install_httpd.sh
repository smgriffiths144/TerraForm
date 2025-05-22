#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
echo 'guff and stuff' > /var/www/html/index.html

