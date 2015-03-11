cat > /etc/yum.repos.d/rhel7-internal-server-rhscl.repo <<EOD
[glusterfs-epel]
name=GlusterFS is a clustered file-system capable of scaling to several petabytes.
baseurl=http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/epel-7/x86_64/
enabled=1
skip_if_unavailable=1
gpgcheck=0

[glusterfs-swift-epel]
name=GlusterFS is a clustered file-system capable of scaling to several petabytes.
baseurl=http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/epel-7/noarch/
enabled=1
skip_if_unavailable=1
gpgcheck=0

[glusterfs-source-epel]
name=GlusterFS is a clustered file-system capable of scaling to several petabytes. - Source
baseurl=http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/epel-7/SRPMS/
enabled=0
skip_if_unavailable=1
gpgcheck=0
EOD
