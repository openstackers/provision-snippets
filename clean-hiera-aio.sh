# Quickstack AIO fix
echo "Snippet - Changes needed for Quickstack AIO"

sed -i "/- \"%{hiera('server3_/d" /usr/share/openstack-foreman-installer/puppet/modules/quickstack/data/RedHat.yaml
sed -i "/- \"%{hiera('server2_/d" /usr/share/openstack-foreman-installer/puppet/modules/quickstack/data/RedHat.yaml
sed -i "s/quickstack::pacemaker::common::pacemaker_cluster_members: \"%{hiera('server1_ip')} %{hiera('server2_ip')} %{hiera('server3_ip')}\"/quickstack::pacemaker::common::pacemaker_cluster_members: \"%{hiera('server1_ip')}\"/" /usr/share/openstack-foreman-installer/puppet/modules/quickstack/data/RedHat.yaml
