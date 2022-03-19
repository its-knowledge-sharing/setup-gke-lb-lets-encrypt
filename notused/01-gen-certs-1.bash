#!/bin/bash

DOMAIN=its-software-services.com

CERT_DIR=root-certs

ROOT_KEY=ca1.key
ROOT_CERT=ca1.crt
EXT_FILE=ca1.ext
PWD_FILE=ca1.password

mkdir -p ${CERT_DIR}

############## ROOT ##############
cat << EOF > ${CERT_DIR}/${EXT_FILE}
[req]
distinguished_name = req_distinguished_name
default_bits = 2048
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = TH
ST = Bangkok
L = Bangkok
O = ITS
OU = DevOps
CN = ITS Software Services

[v3_req]
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @san_names
basicConstraints = CA:FALSE

[san_names]
DNS.1 = *.${DOMAIN}
EOF

PASSWORD=$(openssl rand -base64 32 | cut -c1-16)
echo ${PASSWORD} > ${CERT_DIR}/${PWD_FILE} 

openssl genrsa -out ${CERT_DIR}/${ROOT_KEY} 2048
openssl req -x509 -new -nodes \
    -key ${CERT_DIR}/${ROOT_KEY} -sha256 -days 18250 -out ${CERT_DIR}/${ROOT_CERT} \
    -config ${CERT_DIR}/${EXT_FILE} -extensions 'v3_req'
