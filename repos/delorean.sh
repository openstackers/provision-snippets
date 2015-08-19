#!/bin/bash
cat > /etc/yum.repos.d/delorean.repo <<EOF
[openstack-kilo-delorean]
name=OpenStack Kilo delorean Repository
baseurl= http://trunk.rdoproject.org/centos7/current/
skip_if_unavailable=0
enabled=1
gpgcheck=0
EOF
