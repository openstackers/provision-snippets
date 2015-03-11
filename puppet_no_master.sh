echo "Snippet Openstack Puppet Masterless setup"
modules=$1

yum -y install puppet augeas

# Hiera is a Puppet dep and needs a missing link on RH Oses
ln -sf /etc/hiera.yaml /etc/puppet/hiera.yaml

augtool set /files/etc/puppet/puppet.conf/main/basemodulepath "$modules"

