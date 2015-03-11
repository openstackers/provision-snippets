#!/bin/env bash
echo 'Snippet Sensu client'
yum -y install sensu

cat > /etc/sensu/config.json <<EOF
{
  "rabbitmq": {
    "port": 5671,
    "host": "$1",
    "user": "sensu",
    "password": "sensu",
    "vhost": "/sensu"
  }
}
EOF

HOSTNAME=`hostname`

cat > /etc/sensu/conf.d/client.json <<EOF
{
  "client": {
    "name": "$HOSTNAME",
    "address": "$2",
    "subscriptions": [ "test" ],
    "safe_mode": false,
    "keepalive": {
     }
  }
}

EOF

systemctl enable sensu-client
systemctl restart sensu-client
