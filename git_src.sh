#!/bin/sh
module=$1
git=$2
branch=$3
target=$4
if [[ $target == '' ]]
then
  target=/etc/puppet/modules/
fi

echo "Snippet - Cloning module $module from $git for branch $branch into $target"
yum -y install git

if [[ -d $target ]]
then
  rm -rf $target
fi
mkdir -p $target

cd $target
git clone $git $target/$module

cd $module
git checkout $branch
git submodule init
git submodule update
