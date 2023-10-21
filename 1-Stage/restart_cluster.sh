#!bin/bash
minikube delete || true
minikube start
kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
kubectl get svc -n cockroachdb