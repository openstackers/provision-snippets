#!/bin/env bash
echo 'Snippet Redis'

yum install -y redis

systemctl enable redis
systemctl restart redis
