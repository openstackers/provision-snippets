echo "Snippet - Pacemaker"
bootstrap=$1
cluster_name=$2
cluster_members=$3
cluster_options=$4
passwd="CHANGEME"

iptables -I INPUT -p udp --dport 5405 -j ACCEPT
iptables -I INPUT -p tcp --dport 2224 -j ACCEPT
iptables -I INPUT -p tcp --dport 3121 -j ACCEPT
service iptables save

ip6tables -I INPUT -p udp --dport 5405 -j ACCEPT
ip6tables -I INPUT -p tcp --dport 2224 -j ACCEPT
ip6tables -I INPUT -p tcp --dport 3121 -j ACCEPT
service ip6tables save

yum install -y pcs fence-agents-all

systemctl enable pcsd
systemctl start pcsd

/bin/echo $passwd | /usr/bin/passwd --stdin hacluster

if [[ "$bootstrap" == "true" ]]
then
  echo "Snippet - Pacemaker - Bootstrapping"
  /usr/sbin/pcs cluster auth $cluster_members -u hacluster -p $passwd --force
  /usr/sbin/pcs cluster setup --name $cluster_name $cluster_members $cluster_options
fi
