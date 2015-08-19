#!/bin/bash
echo $0

# params
MODULE=$1  # keystone
REF=$2     # 95/184195/15
OS_TYPE=$3 # centos7
STABLE=$4  # stable/kilo

mkdir old_branch new_branch

# prepare gems
pushd old_branch
git clone https://github.com/openstack/puppet-$MODULE
cd puppet-$MODULE
git checkout $STABLE
sudo gem install bundler --no-rdoc --no-ri --verbose
mkdir .bundled_gems
export GEM_HOME=`pwd`/.bundled_gems
bundle install

# install and test the stable branch
export BEAKER_set=nodepool-$OS_TYPE
export BEAKER_debug=yes
bundle exec rspec spec/acceptance

# upgrade and test the current branch
pushd +1
cd new_branch
git clone https://github.com/openstack/puppet-$MODULE
cd puppet-$MODULE
git fetch https://review.openstack.org/openstack/puppet-$MODULE refs/changes/$REF && git checkout FETCH_HEAD
sudo gem install bundler --no-rdoc --no-ri --verbose
mkdir .bundled_gems
export GEM_HOME=`pwd`/.bundled_gems
bundle update

export BEAKER_provision=no
bundle exec rspec spec/acceptance
