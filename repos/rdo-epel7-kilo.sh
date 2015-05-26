cat > /etc/yum.repos.d/rdo7-epel7.rep <<EOT
[openstack-kilo-trunk]
name=OpenStack Kilo Repository
baseurl=https://repos.fedorapeople.org/repos/openstack/openstack-trunk/epel-7/kilo-3/
enabled=1
skip_if_unavailable=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-Juno

[openstack-kilo]
name=Temporary OpenStack Kilo new deps
baseurl=http://repos.fedorapeople.org/repos/openstack/openstack-kilo/el7/
skip_if_unavailable=0
gpgcheck=0
enabled=1
EOT
