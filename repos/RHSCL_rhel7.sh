# RHSCL
cat > /etc/yum.repos.d/rhel7-internal-server-rhscl.repo <<EOF
[rhel7-internal-server-rhscl]
name=RHSCL-1.2-RHEL-7
baseurl=http://download.eng.rdu2.redhat.com/rel-eng/RHSCL-1.2-RHEL-7-20141020.0/compose/Server/x86_64/os
gpgcheck=0
enabled=1
EOF
