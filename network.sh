echo "Snippet - Network"

IPV4_DEFAULTGW=$1
HOSTS=$2
IPV6_DEFAULTGW=$3

echo "nameserver $IPV4_DEFAULTGW" > /etc/resolv.conf

cat > /etc/hosts<<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

$HOSTS
EOF

if [[ -n $IPV6_DEFAULTGW ]]
then
  sed -i '/IPV6_DEFAULTGW=/d' /etc/sysconfig/network
  sed -i "\$aIPV6_DEFAULTGW=$IPV6_DEFAULTGW" /etc/sysconfig/network

  sed -i '/IPV6_AUTOCONF=/d' /etc/sysconfig/network
  sed -i '$aIPV6_AUTOCONF=no' /etc/sysconfig/network
fi
