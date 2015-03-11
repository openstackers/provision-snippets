#!/bin/env bash
echo 'Snippet sensu-server'
CERTNAME=$1

yum install -y sensu

mkdir /etc/sensu/ssl/
cp /etc/pki/tls/private/${CERTNAME}-key.pem /etc/sensu/ssl/
cp /etc/pki/tls/certs/${CERTNAME}-cert.pem /etc/sensu/ssl/
chown -R sensu.sensu /etc/sensu/ssl

cat > /etc/sensu/config.json <<EOF
{
  "rabbitmq": {
    "ssl": {
      "private_key_file": "/etc/sensu/ssl/${CERTNAME}-key.pem",
      "cert_chain_file": "/etc/sensu/ssl/${CERTNAME}-cert.pem"
    },
    "port": 5671,
    "host": "localhost",
    "user": "sensu",
    "password": "sensu",
    "vhost": "/sensu"
  },
  "redis": {
    "host": "localhost",
    "port": 6379
  },
  "api": {
    "host": "localhost",
    "port": 4567
  },
  "handlers": {
    "default": {
      "type": "set",
      "handlers": [
        "stdout"
      ]
    },
    "stdout": {
      "type": "pipe",
      "command": "cat"
    }
  },
  "checks": {
    "test": {
      "command": "echo -n OK",
      "subscribers": [
        "test"
      ],
      "interval": 60
    }
  }
}
EOF

systemctl enable sensu-server sensu-api
systemctl restart sensu-server sensu-api

yum -y install uchiwa

systemctl enable uchiwa
systemctl restart uchiwa
