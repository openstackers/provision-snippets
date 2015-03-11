echo "Snippet - Packstack dist"
packstack=$1
branch=$2

case $packstack in
  rpm)
    echo 'Packstack from RPM'
    yum -y install openstack-packstack
    ;;
  *)
    echo 'Packstack from GIT'
    yum -y install git
    cd /tmp
    # packstack = git://github.com/stackforge/packstack.git
    git clone $packstack packstack 
    cd packstack
    git checkout $branch
    python setup.py install
    python setup.py install_puppet_modules
    ;;
esac
