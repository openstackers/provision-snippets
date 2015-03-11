#!/bin/env bash
echo 'Snippet - Rabbitmq-SSL'

FQDN=`hostname`
CERTNAME=$1
USER=$2
NODE1=$3
NODE2=$4
NODE3=$5

setenforce 0

yum -y install rabbitmq-server

mkdir /etc/rabbitmq/ssl
cp /etc/pki/CA/cacert.pem /etc/rabbitmq/ssl/
cp /etc/pki/tls/certs/${CERTNAME}-cert.pem /etc/rabbitmq/ssl/
cp /etc/pki/tls/private/${CERTNAME}-key.pem /etc/rabbitmq/ssl/

cat > /etc/rabbitmq/rabbitmq.config <<EOF
[
    {rabbit, [
    {ssl_listeners, [5671]},
    {ssl_options, [{cacertfile,"/etc/rabbitmq/ssl/cacert.pem"},
                   {certfile,"/etc/rabbitmq/ssl/${CERTNAME}-cert.pem"},
                   {keyfile,"/etc/rabbitmq/ssl/${CERTNAME}-key.pem"},
                   {verify,verify_peer},
                   {fail_if_no_peer_cert,true}]},
    {cluster_nodes, {['rabbit@${NODE1}', 'rabbit@${NODE2}', 'rabbit@${NODE3}'], disc}}
  ]}
].
EOF

# Set communication cookie
echo -n JRCBHBZVGUYANPACBUIP > /var/lib/rabbitmq/.erlang.cookie
chmod 400 /var/lib/rabbitmq/.erlang.cookie
chown rabbitmq.rabbitmq /var/lib/rabbitmq/.erlang.cookie

systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

# Mirroring execept self generated queues
rabbitmqctl set_policy ha-all '^(?!amq\.).*' '{"ha-mode": "all"}'

# Credentials
rabbitmqctl add_vhost /$USER

# Create a RabbitMQ user with permissions for the Sensu vhost

rabbitmqctl add_user $USER $USER
rabbitmqctl set_permissions -p /$USER $USER ".*" ".*" ".*"

# Optional - Enable the RabbitMQ web management console
# rabbitmq-plugins enable rabbitmq_management
