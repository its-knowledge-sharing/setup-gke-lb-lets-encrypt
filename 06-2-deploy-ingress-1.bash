#!/bin/bash

source .env

NS=ingress-nginx

echo "####"
echo "#### Deploying nginx ingress to [${NS}] ####"

OUTPUT_FILE=nginx-ingress/nginx-ing-1.yaml
cp ${OUTPUT_FILE} ${OUTPUT_FILE}.tmp
sed -i "s#<<DOMAIN>>#${DOMAIN1}#g" ${OUTPUT_FILE}.tmp
kubectl apply -f ${OUTPUT_FILE}.tmp -n ${NS}
