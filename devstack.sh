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
FIXED_NETWORK_SIZE=10
FLAT_INTERFACE=eth2
ADMIN_PASSWORD=testing
MYSQL_PASSWORD=testing
RABBIT_PASSWORD=testing
SERVICE_PASSWORD=testing
SERVICE_TOKEN=testing
EOD

chown stack.stack /home/stack/devstack/local.conf

sudo -iu stack -- sh -c "cd devstack; ./stack.sh"
