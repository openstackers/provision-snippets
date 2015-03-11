# Repos
platform=$1
openstack=$2
openstackversion=$3
flea=$4

echo "Snippet Openstack Repos - $platform $openstack $openstackversion <==="

case $openstack in
  RDO|rdo)
    # EPEL
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
            rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
            ;;
        esac
      esac
    fi

    case $platform in
      rhel*)
        echo 'Enabling RHEL Optional'
        yum-config-manager --enable rhel-server-optional
        echo 'Enabling RHEL Extras'
        yum-config-manager --enable rhel-server-extras
      ;;
    esac

    yum list installed rdo-release-*
    if [[ $? -ne 0 ]]
    then
      case $openstackversion in
        4)
          echo 'Adding RDO Havana'
          rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-havana/rdo-release-havana-9.noarch.rpm
          ;;

        5)
          echo 'Adding RDO Icehouse'
          rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-icehouse/rdo-release-icehouse-4.noarch.rpm
          ;;

        6)
          echo 'Adding RDO Juno'
          rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-juno/rdo-release-juno-1.noarch.rpm
          ;;
      esac
    fi
    ;;

  RHOS|rhos)
    echo "Adding RHOS $openstackversion"
    rhos-release -v
    if [[ $? -eq 127 ]]
    then
      rpm -ivh http://team.virt.bos.redhat.com/repos/rhos-release/rhos-release-latest.noarch.rpm
      yum -y update
      options=""
      [[ $flea == "true" ]] && options="-f -d"
      rhos-release $options $openstackversion
      rhos-release $options ${openstackversion}-installer
    fi
    ;;
  *)
    echo "Error: no Repos assigned"
    exit 1
    ;;
esac

yum -y update
