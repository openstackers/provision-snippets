# Snippet - Director

yum install -y instack-undercloud

useradd stack
echo "stack:stack" | chpasswd
echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack
chmod 0440 /etc/sudoers.d/stack

su -l stack -c "DIB_YUM_REPO_CONF=\"/etc/yum.repos.d/rhos-release-7.repo  /etc/yum.repos.d/rhos-release-rhel-7.2.repo /etc/yum.repos.d/rhos-release-7-director.repo\" NODE_DIST=rhel7 DIB_LOCAL_IMAGE=/vagrant/rhel-guest-image-7.2-20151102.0.x86_64.qcow2 NODE_COUNT=1 instack-virt-setup --virt-type=qemu"
