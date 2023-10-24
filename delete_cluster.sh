gcloud compute instances delete esle-server1 --zone=europe-west2-c --quiet
gcloud compute instances delete esle-server2 --zone=europe-west2-c --quiet
gcloud compute instances delete esle-server3 --zone=europe-west2-c --quiet
gcloud compute instances delete esle-server4 --zone=europe-west2-c --quiet
gcloud compute instances delete esle-server5 --zone=europe-west2-c --quiet
gcloud compute instances delete esle-benchmark --zone=europe-west2-c --quiet
gcloud compute firewall-rules delete firewall-cockroachdb --quiet