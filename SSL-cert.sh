#!/bin/env bash
echo "Snippet SSL cert"
CA_NAME=$1
CERTNAME=$2
TYPE=$3

KEY=/etc/pki/tls/private/${CERTNAME}-key.pem
CERT=/etc/pki/tls/certs/${CERTNAME}-cert.pem
CSR=/etc/pki/tls/${CERTNAME}.csr

[[ -f $CERT ]] && exit
echo "creating SSL certificate: ${CERTNAME}"
openssl req -new -newkey rsa:2048 -keyout $KEY -out $CSR -nodes -outform PEM -subj /C=--/ST=State/L=City/O=OpenStack/OU=${CERTNAME}/CN=${CA_NAME}/emailAddress=admin@${HOSTNAME}
openssl ca -in $CSR -out $CERT -notext -batch -extensions ${TYPE}_ca_extensions

rm -f $CSR
chmod 755 $KEY $CERT
