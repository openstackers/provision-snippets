# Common stuff
echo "Snippet - Pre"

echo "nameserver 192.168.121.1" > /etc/resolv.conf

cat > /etc/hosts<<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

$1
EOF
