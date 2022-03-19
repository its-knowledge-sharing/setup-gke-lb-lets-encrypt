#!/bin/bash

source .env

# Create IP
gcloud compute addresses create ingress-ip-1 \
--global \
--ip-version IPV4 \
--project ${PROJECT}

# Add A record to DNS
