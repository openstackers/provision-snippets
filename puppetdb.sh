# Puppetdb setup
echo "Snipet puppetdb"
puppetdb_server=$1

yum -y install http://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-7-11.noarch.rpm
yum -y install puppetdb puppetdb-terminus augeas facter

augtool set /files/etc/puppet/puppet.conf/master/storeconfigs true
augtool set /files/etc/puppet/puppet.conf/master/storeconfigs_backend puppetdb

cat > /etc/puppet/puppetdb.conf <<EOF
[main]
  server = ${puppetdb_server}
  port = 8081
EOF

cat > /etc/puppet/routes.yaml <<EOF
---
master:
  facts:
    terminus: puppetdb
    cache: yaml
EOF

function rhel6() {
  chkconfig puppetdb on
  service puppetdb start
}

function rhel7() {
  systemctl enable puppetdb
  systemctl start puppetdb
}

case $(facter operatingsystemmajrelease) in
  6)
    rhel6
    ;;
  7|20|21)
    rhel7
    ;;
  *)
    ;;
esac
