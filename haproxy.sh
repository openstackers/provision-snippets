#!/bin/env bash
echo 'Snippet HAProxy'
yum -y install haproxy

systemctl enable haproxy
systemctl restart haproxy
