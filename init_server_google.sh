#!bin/bash
#gcloud auth login
gcloud config set project esle-project-403114

gcloud compute instances create $1 \
  --custom-cpu=4 \
  --custom-memory=$2 \
  --image-family=debian-10 \
  --image-project=debian-cloud \
  --boot-disk-size=20GB \
  --zone=asia-east1-a

gcloud compute instances list
export SERVER_IP=$(gcloud compute instances describe $1 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
ssh-keygen -f "/Users/alexanderbinett/.ssh/known_hosts" -R "$SERVER_IP"
sleep 15
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP echo hello 
scp /Users/alexanderbinett/Documents/Utbyte/ESLE/ESLE-Project/setup_google_server.sh alexanderbinett@$SERVER_IP:~/setup_google_server.sh
ssh $SERVER_IP sh setup_google_server.sh
#gcloud compute ssh esle-server --zone=europe-west2-c
#note: if doesnt work, then run "ssh $SERVER_IP" and execute each command
gcloud compute instances add-tags $1 --tags=firewall
echo ssh $SERVER_IP


#sleep 120
#gcloud compute instances delete esle-server --zone=europe-west2-c --quiet
