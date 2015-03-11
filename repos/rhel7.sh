# RHEL
cat > /etc/yum.repos.d/rhel-7-server.repo <<EOF
[rhel-7-server]
name=Red Hat Enterprise Linux \$releasever - \$basearch - Server
baseurl=http://download.bne.redhat.com/released/RHEL-7/7.1/Server/x86_64/os/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-7-server-updates]
name=Red Hat Enterprise Linux \$releasever - Updates
#baseurl=http://download.bne.redhat.com/rel-eng/repos/rhel-7.0-z/\$basearch/
baseurl=http://download.bne.redhat.com/brewroot/repos/rhel-7.1-build/latest/x86_64/repodata/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-server-optional]
name=Red Hat Enterprise Linux \$releasever - \$basearch - Server Optional
baseurl=http://download.bne.redhat.com/released/RHEL-7/7.1/Server-optional/x86_64/os/enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-server-extras]
name=Red Hat Enterprise Linux \$releasever - \$basearch - Server Extras
baseurl=http://download.bne.redhat.com/brewroot/repos/extras-rhel-7.1-build/latest/x86_64/repodata/
#http://download.eng.bos.redhat.com/rel-eng/latest-EXTRAS-7-RHEL-7/compose/Server/\$basearch/os/
enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
