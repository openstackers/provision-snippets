echo "Snippet - Iptables"

systemctl disable firewalld
systemctl stop firewalld

#sysctl net.ipv4.ip_forward=1

yum install -y iptables-services

cat > /etc/sysconfig/iptables <<EOD
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -p gre -j ACCEPT                   -m comment --comment "001 GRE Tunnels" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 443   -m comment --comment "001 Horizon incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 80    -m comment --comment "001 Horizon incoming" -j ACCEPT
-A INPUT -p udp -m multiport --dports 4789  -m comment --comment "001 VXLAN Tunnels" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 5000  -m comment --comment "001 keystone incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 3260  -m comment --comment "001 Nova volume incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 3306  -m comment --comment "001 Mysql incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 5672  -m comment --comment "001 AMQP incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 5900:5999  -m comment --comment "001 VNC incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 6080  -m comment --comment "001 Novncproxy incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8000  -m comment --comment "001 Heat API CFN incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8003  -m comment --comment "001 Heat API Cloudwatch incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8004  -m comment --comment "001 Heat API incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8773  -m comment --comment "001 EC2 API incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8774  -m comment --comment "001 Nova API incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8775  -m comment --comment "001 Metadata Proxy incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8776  -m comment --comment "001 Cinder volume incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8777  -m comment --comment "001 Ceilometer incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 8888  -m comment --comment "001 Swift incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 9292  -m comment --comment "001 Glance incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 9696  -m comment --comment "001 Neutron incoming" -j ACCEPT
-A INPUT -p tcp -m multiport --dports 35357 -m comment --comment "001 keystone incoming" -j ACCEPT
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOD

systemctl enable iptables
systemctl start iptables
