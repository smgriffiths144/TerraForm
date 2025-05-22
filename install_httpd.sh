#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
echo 'guff and stuff' > /var/www/html/index.html

wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.9.1.linux-amd64.tar.gz
cd node_exporter-1.9.1.linux-amd64
./node_exporter
