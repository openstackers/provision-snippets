# RHEL
cat > /etc/yum.repos.d/rhel-7-server.repo <<EOF
[rhel-7-server]
name=Red Hat Enterprise Linux  - x86_64 - Server
#baseurl=http://download.bne.redhat.com/pub/rhel/released/RHEL-7/7.2/Server/x86_64/os/
baseurl=http://download.eng.bos.redhat.com/released/RHEL-7/7.2/Server/x86_64/os/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-7-server-z]
name=Red Hat Enterprise Linux  - x86_64 - Z-Stream
baseurl=http://download.lab.bos.redhat.com/rel-eng/repos/rhel-7.2-z/x86_64
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-server-optional]
name=Red Hat Enterprise Linux  - x86_64 - Server Optional
baseurl=http://download.lab.bos.redhat.com/released/RHEL-7/7.2/Server-optional/x86_64/os/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[rhel-server-extras]
name=Red Hat Enterprise Linux  - x86_64 - Server Extras
baseurl=http://download.eng.bos.redhat.com/rel-eng/latest-EXTRAS-7-RHEL-7/compose/Server/x86_64/os/
enabled=0
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
