#!/bin/bash

source .env

NS=ingress-nginx

# Update the existing one instead of creating the new one

OUTPUT_FILE=certs/demo-certificate-2.yaml
cp ${OUTPUT_FILE} ${OUTPUT_FILE}.tmp
sed -i "s#<<DOMAIN>>#${DOMAIN1}#g" ${OUTPUT_FILE}.tmp
kubectl apply -n ${NS} -f ${OUTPUT_FILE}.tmp
