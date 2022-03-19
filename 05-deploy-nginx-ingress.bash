#!/bin/bash

source .env

NS=ingress-nginx

echo "####"
echo "#### Deploying nginx config to [${NS}] ####"

kubectl create ns ${NS}

kubectl apply -f nginx-ingress/nginx-backend-cfg.yaml -n ${NS}

OUTPUT_FILE=nginx-ingress/nginx-ing-1.yaml
cp ${OUTPUT_FILE} ${OUTPUT_FILE}.tmp
sed -i "s#<<DOMAIN>>#${DOMAIN}#g" ${OUTPUT_FILE}.tmp
kubectl apply -f ${OUTPUT_FILE}.tmp -n ${NS}


helm repo add nginx https://kubernetes.github.io/ingress-nginx/

helm template nginx nginx/ingress-nginx \
    -f nginx-ingress/nginx.yaml \
    --version 4.0.2 \
    --namespace ${NS} > tmp-nginx.yaml

kubectl apply -n ${NS} -f tmp-nginx.yaml


OUTPUT_FILE=certs/demo-certificate.yaml
cp ${OUTPUT_FILE} ${OUTPUT_FILE}.tmp
sed -i "s#<<DOMAIN>>#${DOMAIN}#g" ${OUTPUT_FILE}.tmp
kubectl apply -n ${NS} -f ${OUTPUT_FILE}.tmp
