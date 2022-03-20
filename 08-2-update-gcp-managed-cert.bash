#!/bin/bash

source .env

NS=ingress-nginx

OUTPUT_FILE=nginx-ingress/gcp-manage-certs-2.yaml
cp ${OUTPUT_FILE} ${OUTPUT_FILE}.tmp
sed -i "s#<<DOMAIN>>#${DOMAIN2}#g" ${OUTPUT_FILE}.tmp
kubectl apply -f ${OUTPUT_FILE}.tmp -n ${NS}
