#!bin/bash
#gcloud auth login
gcloud config set project esle-project

gcloud compute instances create esle-server \
  --machine-type=f1-micro \
  --image-family=debian-10 \
  --image-project=debian-cloud \
  --boot-disk-size=10GB \
  --zone=europe-west2-c

gcloud compute instances list
export SERVER_IP=$(gcloud compute instances describe esle-server --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
ssh-keygen -f "/home/joaopereira243/.ssh/known_hosts" -R "$SERVER_IP"
#ssh -oStrictHostKeyChecking=no $SERVER_IP echo hello
scp /home/joaopereira243/Desktop/ESLE/ESLE-Project/setup_google_server.sh joaopereira243@$SERVER_IP:~/setup_google_server.sh
ssh $SERVER_IP sh setup_google_server.sh
#gcloud compute ssh esle-server --zone=europe-west2-c
#note: if doesnt work, then run "ssh $SERVER_IP" and execute each command


#sleep 120
#gcloud compute instances delete esle-server --zone=europe-west2-c --quiet
