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

#Install CockroachDB on Kubernets Cluster
kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
#helm uninstall cockroachdb-release -n cockroachdb

#Scale DB Replicas
helm upgrade \
cockroachdb-release \
cockroachdb/cockroachdb \
--set statefulset.replicas=4 \
--reuse-values -n cockroachdb

#Access CockroachDB Console
kubectl port-forward service/cockroachdb-release-public 8080 -n cockroachdb #run this command on a different terminal

#Access CockroachCLI - SQL-Client
kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it -- bash
kubectl attach cockroachdb -n cockroachdb -c cockroachdb -i -t 
cockroach sql --insecure --host=cockroachdb-release-public


#Run Benchmark
kubectl get svc -n cockroachdb #get cockroachdb-release-public cluster IP
#ex:10.111.68.1
kubectl attach cockroachdb -c cockroachdb -i -t -n cockroachdb
cockroach workload init tpcc --warehouses=10 --survival-goal zone 'postgresql://root@10.111.68.1:26257/tpcc?sslmode=disable'
cockroach workload run tpcc --warehouses=10 --duration=1m --wait=true --tolerate-errors --survival-goal zone 'postgresql://root@10.111.68.1:26257/tpcc?sslmode=disable'
cockroach sql --insecure --host=cockroachdb-release-public
SHOW TABLES FROM tpcc;
DROP DATABASE tpcc CASCADE;



minikube stop