echo "Snippet - Apache"

yum install -y httpd
systemctl enable httpd; systemctl start httpd
echo "<p>Hello World</p>" > /var/www/html/index.html

iptables -I INPUT -p tcp --dport 80 -j ACCEPT
service iptables save
ip6tables -I INPUT -p tcp --dport 80 -j ACCEPT
service ip6tables save
