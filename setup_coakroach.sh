#bin/bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

minikube start
minikube tunnel #run this command on a different terminal

helm repo add cockroachdb https://charts.cockroachdb.com/
helm repo update

kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
#helm uninstall cockroachdb-release -n cockroachdb

kubectl port-forward service/cockroachdb-release-public 8080 -n cockroachdb #run this command on a different terminal

kubectl run -n cockroachdb cockroachdb -it \
--image=cockroachdb/cockroach:v23.1.10 \
--rm \
--restart=Never \
-- sql \
--insecure \
--host=cockroachdb-release-public

minikube stop