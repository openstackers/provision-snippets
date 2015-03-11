# Puppetmaster setup
yum -y install puppet puppet-server augeas facter

augtool set /files/etc/puppet/puppet.conf/master/ca true
augtool set /files/etc/puppet/puppet.conf/master/ssldir \$vardir/ssl
augtool set /files/etc/puppet/puppet.conf/main/environmentpath \$confdir/environments
augtool set /files/etc/puppet/puppet.conf/main/basemodulepath \$confdir/modules:/usr/share/puppet/modules:/usr/share/openstack-puppet/modules:/usr/share/openstack-foreman-installer/puppet/modules

augtool set /files/etc/puppet/puppet.conf/main/parser future

#augtool set /files/etc/puppet/puppet.conf/agent/ca_server openstack.os.tst
#augtool set /files/etc/puppet/puppet.conf/agent/server openstack.os.tst

echo '*' >> /etc/puppet/autosign.conf

mkdir -p /etc/puppet/environments/production/{manifests,modules}

chcon --reference /etc/puppet /etc/puppet/autosign.conf
chcon --reference /etc/puppet /etc/puppet/puppet.conf
chcon -R --reference /etc/puppet /etc/puppet/environments

ln -sf /etc/hiera.yaml /etc/puppet/hiera.yaml

function rhel6() {
  chkconfig puppetmaster on
  service puppetmaster start

  # FW
  lokkit -p 80:tcp
  lokkit -p 443:tcp
  lokkit -p 8140:tcp
}

function rhel7() {
  systemctl enable puppetmaster
  systemctl start puppetmaster

  # FW
  yum -y install firewalld
  systemctl enable firewalld
  systemctl start firewalld
  firewall-cmd --permanent --add-port=80/tcp
  firewall-cmd --permanent --add-port=443/tcp
  firewall-cmd --permanent --add-port=8140/tcp
  firewall-cmd --reload
}

case $(facter operatingsystemmajrelease) in
  6)
    rhel6
    ;;
  7|20)
    rhel7
    ;;
  *)
    ;;
esac

cat >> /etc/puppet/environments/production/manifests/site.pp <<EOF
node /aio/ {
  include quickstack
}
EOF

