#!/bin/bash

source .env

NS=cert-manager
kubectl create ns ${NS}

helm repo add cert-manager https://charts.jetstack.io/

helm template cert-manager cert-manager/cert-manager \
-f cert-manager/cert-manager.yaml \
--version 1.7.1 \
--namespace ${NS} > tmp-cert-manager.yaml

kubectl apply -n ${NS} -f tmp-cert-manager.yaml
