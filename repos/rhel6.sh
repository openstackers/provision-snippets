# RHEL
cat > /etc/yum.repos.d/rhel6-server.repo<<EOF
[rhel-6-server]
name=Red Hat Enterprise Linux \$releasever - \$basearch - Server
baseurl=http://download.lab.bos.redhat.com/released/RHEL-6/6.6/Server/\$basearch/os/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-6-server-z]
name=Red Hat Enterprise Linux \$releasever - \$basearch - Server Z-Stream
baseurl=http://download.eng.bos.redhat.com/brewroot/repos/RHEL-6.6-Z-build/latest/\$basearch/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-server-optional]
name=Red Hat Enterprise Linux \$releasever - \$basearch - Server Optional
baseurl=http://download.lab.bos.redhat.com/released/RHEL-6/6.6/Server/optional/\$basearch/os/
enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-6-server-i386]
name=Red Hat Enterprise Linux \$releasever - i386 - Server
baseurl=http://download.lab.bos.redhat.com/released/RHEL-6/6.6/Server/i386/os/Server
enabled=0
gpgcheck=0

[rhel-6-server-z-i386]
name=Red Hat Enterprise Linux \$releasever - i686 - Server Z-Stream
baseurl=http://download.lab.bos.redhat.com/rel-eng/repos/RHEL-6.6-Z/i686/
enabled=0
gpgcheck=0
EOF
