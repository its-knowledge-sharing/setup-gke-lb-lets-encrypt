#!/bin/bash

DOMAIN=its-software-services.com

CERT_DIR=root-certs

ROOT_KEY=ca2.key
ROOT_CERT=ca2.crt
EXT_FILE=ca2.ext
PWD_FILE=ca2.password

mkdir -p ${CERT_DIR}

############## ROOT ##############
cat << EOF > ${CERT_DIR}/${EXT_FILE}
[req]
distinguished_name = req_distinguished_name

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
keyUsage = keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @san_names

[san_names]
DNS.1 = demo1.${DOMAIN}
DNS.2 = demo2.${DOMAIN}
EOF

PASSWORD=$(openssl rand -base64 32 | cut -c1-16)
echo ${PASSWORD} > ${CERT_DIR}/${PWD_FILE} 

openssl genrsa -out ${CERT_DIR}/${ROOT_KEY} 2048
openssl req -x509 -new -nodes \
    -key ${CERT_DIR}/${ROOT_KEY} -sha256 -days 18250 -out ${CERT_DIR}/${ROOT_CERT} \
    -config ${CERT_DIR}/${EXT_FILE} -extensions 'v3_req'
