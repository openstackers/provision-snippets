#!/bin/bash

# params
MODULE=$1  # keystone
REF=$2     # '95/184195/15'
OS_TYPE=$3 # 'centos7'

git clone https://github.com/openstack/puppet-$MODULE
cd puppet-$MODULE
git fetch https://review.openstack.org/openstack/puppet-$MODULE refs/changes/$REF && git checkout FETCH_HEAD
sudo gem install bundler --no-rdoc --no-ri --verbose
mkdir .bundled_gems

export BEAKER_set=nodepool-$OS_TYPE
export BEAKER_debug=yes
export GEM_HOME=`pwd`/.bundled_gems

bundle install
bundle exec rspec spec/acceptance
