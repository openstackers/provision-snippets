# EPEL Repos
echo "Snippet EPEL repos"
platform=$1

yum list installed epel-release
if [[ $? -ne 0 ]]
then
  case $platform in
    rhel*|centos*)
      case $platform in
      *6)
        echo 'Adding EPEL6'
        rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
        ;;

      *7)
        echo 'Adding EPEL7'
        #yum install epel-release
        rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
        ;;
    esac
  esac
fi

yum -y update
