#!/bin/bash

source .env

IP_NAME=ingress-ip-2

IP=$(gcloud compute addresses describe ${IP_NAME} --global --project=${PROJECT} | grep 'address:' | cut -d':' -f2)

# Add A record to DNS
gcloud dns record-sets transaction start --zone=${MANAGED_ZONE2} --project ${PROJECT}

gcloud dns record-sets transaction add ${IP} \
   --name=${DOMAIN2} \
   --ttl=300 \
   --type=A \
   --zone=${MANAGED_ZONE2} \
   --project ${PROJECT}

gcloud dns record-sets transaction add ${IP} \
   --name="test2.${DOMAIN2}" \
   --ttl=300 \
   --type=A \
   --zone=${MANAGED_ZONE2} \
   --project ${PROJECT}

gcloud dns record-sets transaction execute --zone=${MANAGED_ZONE2} --project ${PROJECT}
