echo "Snippet - Network ipv6 ifcfg"
INTERFACE=$1
IPV6ADDR=$2

sed -i '/IPV6ADDR=/d' /etc/sysconfig/network-scripts/ifcfg-$INTERFACE
sed -i "\$aIPV6ADDR=$IPV6ADDR" /etc/sysconfig/network-scripts/ifcfg-$INTERFACE

sed -i '/IPV6_AUTOCONF=/d' /etc/sysconfig/network-scripts/ifcfg-$INTERFACE
sed -i '$aIPV6_AUTOCONF=no' /etc/sysconfig/network-scripts/ifcfg-$INTERFACE

sed -i '/IPV6_DEFAULTDEV=/d' /etc/sysconfig/network
sed -i "\$aIPV6_DEFAULTDEV=$INTERFACE" /etc/sysconfig/network

systemctl restart network
