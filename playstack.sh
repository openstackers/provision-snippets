echo "Snippet - Playstack"
branch=$1
public=$2
internal=$3
admin=$4

gem install configatron --no-ri --no-rdoc

if [[ ! -d  /usr/local/playstack ]]
then
  git clone https://github.com/gildub/playstack.git /usr/local/playstack
  cd /usr/local/playstack
  git checkout $branch
fi

cd $HOME
mkdir playstack
cd playstack

/usr/local/playstack/playstack -dtesting -a$admin -i$internal -p$public

augtool set /files/etc/puppet/puppet.conf/main/hiera_config /root/playstack/hiera/hiera.yaml

puppet apply manifests

# cat /etc/keystone/keystone.conf | grep -v "^#" | grep -v "^$"
