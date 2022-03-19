#!/bin/bash

# Create IP
gcloud compute addresses create ingress-ip-1 \
--global \
--ip-version IPV4

# Add A record to DNS
