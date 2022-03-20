#!/bin/bash

source .env

NS=ingress-nginx

OUTPUT_FILE=certs/demo-certificate-2.yaml
cp ${OUTPUT_FILE} ${OUTPUT_FILE}.tmp
sed -i "s#<<DOMAIN>>#${DOMAIN1}#g" ${OUTPUT_FILE}.tmp
kubectl apply -n ${NS} -f ${OUTPUT_FILE}.tmp
