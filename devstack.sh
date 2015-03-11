echo "Snippets- Devstack "
fixed_range=$1

adduser stack
yum install -y sudo git

echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

sudo -iu stack -- sh -c "git clone https://git.openstack.org/openstack-dev/devstack"

cat > /home/stack/devstack/local.conf <<EOD
[[local|localrc]]
FLOATING_RANGE=192.168.254.224/27
FIXED_RANGE=${fixed_range}
FIXED_NETWORK_SIZE=256
FLAT_INTERFACE=eth2
ADMIN_PASSWORD=easy
MYSQL_PASSWORD=easy
RABBIT_PASSWORD=easy
SERVICE_PASSWORD=easy
SERVICE_TOKEN=xyzpdqlazydog
EOD

chown stack.stack /home/stack/local.conf

sudo -iu stack -- sh -c "cd devstack; ./stack.sh"
