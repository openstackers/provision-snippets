echo "Snippet Sensu repo-vanilla"
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
[sensu]
name=sensu-main
baseurl=http://repos.sensuapp.org/yum/el/6/$\basearch/
enabled=1
gpgcheck=0
EOF
        ;;
    esac
  esac
fi
