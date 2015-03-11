echo "Snippet Sensu repo"
platform=$1

yum list sensu
if [[ $? -ne 0 ]]
then
  case $platform in
    rhel*|centos*)
      case $platform in
      *7)
        echo 'Adding Sensu EPEL'
        cat > /etc/yum.repos.d/sensu.repo <<EOF
[Sensu]
name=Sensu
baseurl=https://copr-be.cloud.fedoraproject.org/results/ggillies/openstack-operations/epel-7-x86_64/
enabled=1
gpgcheck=0
EOF
        ;;
    esac
  esac
fi
