# Quickstack
quickstack=$1
quickstackbranch=$2

echo 'Snippet Quickstack'

cat > /usr/local/bin/quickstack.sh <<EOF
#!/bin/bash

cd /usr/share
rm -rf openstack-foreman-installer
git clone https://github.com/gildub/astapor.git openstack-foreman-installer
cd openstack-foreman-installer
git checkout $quickstackbranch
EOF

chmod +x /usr/local/bin/quickstack.sh

case $quickstack in
  rpm)
    echo 'Quickstack from RPM'
    rpm -e openstack-foreman-installer
    # rpm -ivh --nodeps http://download.eng.bos.redhat.com/rel-eng/OpenStack/6.0-RHEL-7-Installer/latest/RH7-RHOS-6.0-Installer/x86_64/os/Packages/openstack-foreman-installer-3.0.9-1.el7ost.noarch.rpm
    yum -y install openstack-foreman-installer
    ;;
  *)
    echo "Quickstack from GIT $quickstack branch $quickstackbranch"
    yum -y install git
    cd /usr/share
    if [[ -d openstack-foreman-installer ]]
    then
      rm -rf openstack-foreman-installer
    fi
    git clone $quickstack openstack-foreman-installer
    cd openstack-foreman-installer
    git checkout $quickstackbranch
    ;;
esac
