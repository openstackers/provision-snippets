#!/bin/bash
pwd=$1

# Register RHN
subscription-manager register --username=rhn-engineering-gdubreui --force --password=$pwd

# Physical
subscription-manager subscribe --pool=8a85f9843affb61f013b19ccb7fa5f2a
# Virtual
subscription-manager subscribe --pool=8a85f9843affb61f013b19ccb8065f3f

# Add EPEL 6 repo and GPG key
yum -y install http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum-config-manager --enable epel

# Add PuppetLabs
yum -y install http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm

# Foreman
yum -y install http://yum.theforeman.org/rc/el6/x86_64/foreman-release-1.2.0-0.3.RC2.el6.noarch.rpm
yum -y install foreman-installer
ruby /usr/share/foreman-installer/generate_answers.rb

# Adjust RHEL6
yum clean expire-cache
yum-config-manager --disable rhel-6-server-cf-tools-1-rpms --disable rhel-6-server-rhev-agent-rpms --disable rhel-ha-for-rhel-6-server-rpms --disable rhel-lb-for-rhel-6-server-rpms --disable rhel-rs-for-rhel-6-server-rpms
yum-config-manager --disable rhel-6-server-eus-rpms --disable rhel-6-server-htb-rpms --disable rhel-6-server-realtime-rpms --disable rhel-6-server-rhev-mgmt-agent-rpms --disable rhel-6-server-rhevh-rpms --disable rhel-6-server-rhui-grid-rpms --disable rhel-6-server-rhui-rpms --disable rhel-6.2-scalefs-server-for-rhs-2.0-rpms --disable rhel-6.2-server-for-rhs-2.0-rpms --disable rhel-eucjp-for-rhel-6-server-rpms --disable rhel-ha-for-rhel-6-server-eus-rpms --disable rhel-hpn-for-rhel-6-server-rpms --disable rhel-lb-for-rhel-6-server-eus-rpms --disable rhel-rs-for-rhel-6-server-eus-rpms --disable rhel-sap-for-rhel-6-server-rpms --disable rhel-scalefs-for-rhel-6-server-rpms --disable rhel-server-dts-6-eus-rpms --disable rhel-server-dts-6-rpms --disable rhel-server-ose-infra-6-rpms --disable rhel-server-ose-node-6-rpms --disable rhel-server-ose-rhc-6-rpms --disable rhel-sfs-for-rhel-6-server-eus-rpms --disable rhel-sjis-for-rhel-6-server-rpms --disable rhs-2.0-for-rhel-6-server-rpms --disable rhsc-2.0-for-rhel-6-server-rpms


# Optional RHEL RPMS
yum-config-manager --enable rhel-6-server-optional-rpms

# update and shoot
yum update -y

echo
echo "Please reboot to make sure everything is persistent"
echo

###RHEL6.5
# Don't forget RHEL6.5 Optional
# EPEL
yum -y install http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# RDO - Havana 7
yum -y install http://repos.fedorapeople.org/repos/openstack/openstack-havana/rdo-release-havana-7.noarch.rpm
# Foreman
yum -y install openstack-foreman-installer
