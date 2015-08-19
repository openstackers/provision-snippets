#!/bin/env bash
# Vagrantify a VM - Prepares a VM for Vagrant

# Vagrant user
useradd vagrant
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > ~vagrant/.ssh/authorized_keys
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant.vagrant ~vagrant/.ssh

# Sudoers
sed -i -r 's/(.* requiretty)/#\1/' /etc/sudoers

cat > /etc/sudoers.d/90-vagrant-users <<EOF
# User rules for vagrant
vagrant ALL=(ALL) NOPASSWD:ALL
EOF

# Network
# Leave only eth0 config - the rest will be managed by vagrant
rm -f /etc/sysconfig/network-scripts/ifcfg-eth{0,1,2,3}
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
DEVICE="eth0"
TYPE="Ethernet"
ONBOOT="yes"
NM_CONTROLLED=no
BOOTPROTO="dhcp"
EOF

# SSH Server
# No UseDNS - Optional, to speed up ssh connections
sed -i -r 's/.*UseNS.*/UseDNS no/' /etc/ssh/sshd_config

# Yum deps and update
yum -y install rsync
yum -y update
yum clean all
# Misc - For instance add a ssh key, etc
