# RHSCL
cat > /etc/yum.repos.d/rh-internal-rhscl-rhel6-server.repo <<EOF
[rh-internal-rhscl-rhel6-server]
name=External-OpenStack-Repository - 1
baseurl=http://download.eng.rdu2.redhat.com/rel-eng/RHSCL-1.1-RHEL-6-RC-1.4/compose/Server/x86_64/os/
gpgcheck=0
enabled=1
EOF
