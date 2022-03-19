#!/bin/bash

source .env

KEY_FILE=service-account.json
SA=${SA_NAME}@${PROJECT}.iam.gserviceaccount.com
SECRET=gcp-cloud-dns-account-key

NS=cert-manager
kubectl create ns ${NS}

# Create service account secret
gcloud iam service-accounts keys create ${KEY_FILE} --iam-account=${SA}
kubectl delete secret ${SECRET} -n ${NS}
kubectl create secret generic ${SECRET} --from-file=${KEY_FILE}=${KEY_FILE} -n ${NS}

helm repo add cert-manager https://charts.jetstack.io/

helm template cert-manager cert-manager/cert-manager \
    -f cert-manager/cert-manager.yaml \
    --version 1.7.1 \
    --namespace ${NS} > tmp-cert-manager.yaml

kubectl apply -n ${NS} -f tmp-cert-manager.yaml

CLUSTER_ISSUER_FILE=cert-manager/cluster-issuer.yaml
sed -i "s#__PROJECT__#${PROJECT}#g" ${CLUSTER_ISSUER_FILE}
kubectl apply -n ${NS} -f ${CLUSTER_ISSUER_FILE}

# Will move
kubectl apply -n ${NS} -f cert-manager/demo-certificate.yaml
