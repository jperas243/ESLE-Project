#bin/bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

minikube start
minikube tunnel #run this command on a different terminal
helmfile -f helm-charts/monitoring-helmfile.yaml sync
kubectl get svc -n boutique # get loadbalancer external IP

kubectl get deployment -n boutique
#https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#scaling-a-deployment

kubectl scale deployment/shippingservice -n boutique --replicas=2