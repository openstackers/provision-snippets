#!/usr/bin/bash
cat > /etc/yum.repos.d/rh-internal-rhs <<EOD
[rh-internal-rhs]
name=Red Hat Storage
baseurl=http://download.lab.bos.redhat.com/rel-eng/RHS/3.0/latest/Server/x86_64/os/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOD
