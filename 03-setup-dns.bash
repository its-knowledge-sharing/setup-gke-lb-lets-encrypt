#!/bin/bash

source .env

IP_NAME=ingress-ip-1

# Create IP
gcloud compute addresses create ${IP_NAME} \
--global \
--ip-version IPV4 \
--project ${PROJECT}

IP=$(gcloud compute addresses describe ${IP_NAME} --global --project=${PROJECT} | grep 'address:' | cut -d':' -f2)

# Add A record to DNS
gcloud dns record-sets transaction start --zone=${MANAGED_ZONE} --project ${PROJECT}

gcloud dns record-sets transaction add ${IP} \
   --name=${DOMAIN} \
   --ttl=300 \
   --type=A \
   --zone=${MANAGED_ZONE} \
   --project ${PROJECT}

gcloud dns record-sets transaction add ${IP} \
   --name="*.${DOMAIN}" \
   --ttl=300 \
   --type=A \
   --zone=${MANAGED_ZONE} \
   --project ${PROJECT}

gcloud dns record-sets transaction add ${IP} \
   --name="new.${DOMAIN}" \
   --ttl=300 \
   --type=A \
   --zone=${MANAGED_ZONE} \
   --project ${PROJECT}

gcloud dns record-sets transaction execute --zone=${MANAGED_ZONE} --project ${PROJECT}
