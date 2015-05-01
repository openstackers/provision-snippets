#!/bin/sh
module=$1
git=$2
branch=$3
target=$4

echo "Snippet - Cloning module $module from $git for branch $branch into $target"

git --version >& /dev/null
[[ $? -eq 127 ]] && yum -y install git

if [[ $target == '' ]]
then
  target=/etc/puppet/modules/
fi

[[ -d ${target} ]] && mkdir -p $target

if [[ -d ${target}/${module} ]]
then
  rm -rf ${target}/${module}
fi

cd $target
git clone $git $module

cd $module
git checkout $branch
git submodule init
git submodule update
