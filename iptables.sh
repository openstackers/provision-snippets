echo "Snippet - iptables services"
yum install -y iptables-services

# Disable the Firewalld service:
systemctl mask firewalld

systemctl enable iptables
systemctl enable ip6tables

#Go to the /etc/sysconfig directory and define your rules in the iptables, ip6tables, iptables-config and ip6tables-config files.

systemctl stop firewalld

systemctl start iptables
systemctl start ip6tables
