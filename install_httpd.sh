#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on

