echo "Snippet - Playstack"
branch=$1
public=$2
internal=$3
admin=$4
run=$5

gem install configatron --no-ri --no-rdoc

if [[ ! -d  /usr/local/playstack ]]
then
  git clone https://github.com/gildub/playstack.git /usr/local/playstack
  cd /usr/local/playstack
  git checkout $branch
fi

cd $HOME
[[ ! -d  playstack ]] && mkdir playstack
cd playstack

echo "/usr/local/playstack/playstack -dtesting -a$admin -i$internal -p$public"
/usr/local/playstack/playstack -dtesting -a$admin -i$internal -p$public --answer=/vagrant/answer.yaml

augtool set /files/etc/puppet/puppet.conf/main/hiera_config /root/playstack/hiera/hiera.yaml

if [[ $run == 'true' ]]
then
  puppet apply manifests
fi

# cat /etc/keystone/keystone.conf | grep -v "^#" | grep -v "^$"
