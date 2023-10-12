#!bin/bash
gcloud config set project esle-project

gcloud container clusters create \
  --machine-type n1-standard-2 \
  --num-nodes 2 \
  --disk-size 10 \
  --zone europe-west2-a	 \
  --cluster-version latest \
  cockroach-cluster


gcloud container clusters get-credentials cockroach-cluster --project esle-project --zone europe-west2-a	


sleep 60
gcloud container clusters delete cockroach-cluster --zone europe-west2-a