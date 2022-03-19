#!/bin/bash

source .env

gcloud container clusters create gke-lets-encrypt --zone us-central1-a --project ${PROJECT}

gcloud container clusters get-credentials gke-lets-encrypt --zone us-central1-a --project ${PROJECT}

kubectl get nodes
