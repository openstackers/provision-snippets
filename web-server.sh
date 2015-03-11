#!/bin/env bash
echo 'Snippet web-server'
yum install -y httpd

systemctl enable httpd
systemctl restart httpd
