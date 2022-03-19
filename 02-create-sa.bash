#!/bin/bash

source .env

gsutil mb -b on -l us-central1 -p ${PROJECT} gs://${BUCKET_NAME}/ 
gsutil ls gs://${BUCKET_NAME}/
