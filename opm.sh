echo "Snippet - install Openstack Puppet Modules" 
opm=$1
branch=$2

function around() {
  # Work around when opm not available in repo
  yum remove -y openstack-puppet-modules
  rpm="openstack-puppet-modules-2014.1-24.el6ost.noarch.rpm"
  yum -y install rubygem-json
  rpm -ivh "http://download.lab.bos.redhat.com/rel-eng/OpenStack/Foreman/latest/RHEL-6-Server-OS-Foreman/x86_64/os/Packages/$rpm"
}

case $opm in
  rpm)
    echo 'OPM from RPM'
    yum install -y openstack-puppet-modules
    ;;
  *)
    echo 'OPM from GIT'
    mkdir /usr/share/openstack-puppet-modules
    git clone $opm '/usr/share/openstack-puppet-modules/modules'
    cd  '/usr/share/openstack-puppet-modules/modules'
    git checkout $branch
    ;;
esac
