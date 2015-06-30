#!/bin/bash

# install deps needed when using cloud images
yum -y install libxml2-devel libxslt-devel ruby-devel
yum -y groupinstall "Development Tools"
