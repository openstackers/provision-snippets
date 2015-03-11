#!/bin/env bash
echo "Snippet SSL CA"

CA_NAME=$1
CA_KEY=/etc/pki/CA/private/cakey.pem
CA_CERT=/etc/pki/CA/cacert.pem

[[ -f $CA_CERT ]] && exit

cat >> /etc/pki/tls/openssl.cnf <<EOF
[ root_ca_extensions ]
basicConstraints = CA:true
keyUsage = keyCertSign, cRLSign

[ client_ca_extensions ]
basicConstraints = CA:false
keyUsage = digitalSignature
extendedKeyUsage = 1.3.6.1.5.5.7.3.2

[ server_ca_extensions ]
basicConstraints = CA:false
keyUsage = keyEncipherment
extendedKeyUsage = 1.3.6.1.5.5.7.3.1
EOF

umask 277
echo 01 > /etc/pki/CA/serial
touch /etc/pki/CA/index.txt

echo "self-signed SSL CA certificate"
openssl req -new -x509 -newkey rsa:2048 -keyout $CA_KEY -days 365 -out $CA_CERT -nodes -outform PEM -subj /C=--/ST=State/L=City/O=OpenStack/OU=${CA_NAME}/CN=${CA_NAME}-CA/emailAddress=admin@${HOSTNAME}
chmod 755 $CA_CERT
