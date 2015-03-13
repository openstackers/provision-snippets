echo "Snippet - install Openstack Puppet Modules"
opm=$1
branch=$2
refresh=$3

function around() {
  # Work around when opm not available in repo
  yum remove -y openstack-puppet-modules
  rpm="openstack-puppet-modules-2014.1-24.el6ost.noarch.rpm"
  yum -y install rubygem-json
  rpm -ivh "http://download.lab.bos.redhat.com/rel-eng/OpenStack/Foreman/latest/RHEL-6-Server-OS-Foreman/x86_64/os/Packages/$rpm"
}

function git_get() {
  git clone $opm '/usr/share/openstack-puppet/modules'
  cd  '/usr/share/openstack-puppet/modules'
  git checkout $branch
}

case $opm in
  rpm)
    echo 'OPM from RPM'
    yum install -y openstack-puppet-modules
    ;;
  *)
    echo 'OPM from GIT'
    if [[ ! -d /usr/share/openstack-puppet ]]
    then
      mkdir /usr/share/openstack-puppet
      git_get
    else
      [[ $refresh -eq 1 ]] && git_get
    fi
    ;;
esac
