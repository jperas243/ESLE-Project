#!bin/bash
rm benchmarks/Benchmark-1/* benchmarks/Benchmark-2/* benchmarks/Benchmark-3/* benchmarks/Benchmark-4/* benchmarks/Benchmark-5/* benchmarks/Benchmark-6/* || true

export CONCURRENCY=4
export NUM_TESTS=15

minikube delete || true
minikube start --memory 8192 --cpus 4
kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
sleep 60

export CLUSTER_IP=$(kubectl get service/cockroachdb-release-public -n cockroachdb -o jsonpath='{.spec.clusterIP}')
export INITIAL_NUM_REPLICAS=1 #min is 3

kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload init kv postgresql://root@${CLUSTER_IP}:26257?sslmode=disable"
sleep 60


#1-Node, Same Load (100,160)
for i in $( eval echo {1..$NUM_TESTS} )
do
    echo "Test $i"
    echo "Nodes $INITIAL_NUM_REPLICAS"    

    kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run kv --concurrency=$(( $CONCURRENCY )) --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@${CLUSTER_IP}:26257?sslmode=disable'" > ./benchmarks/Benchmark-1/benchmark-nodes1-test$i-$(date +%F_%H-%M-%S)""
    sleep 180

done


# #1-Node, Increase Load (N*100,N*160)
minikube delete || true
minikube start --memory 8192 --cpus 4
kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
sleep 60

export CLUSTER_IP=$(kubectl get service/cockroachdb-release-public -n cockroachdb -o jsonpath='{.spec.clusterIP}')
export INITIAL_NUM_REPLICAS=1 #min is 3

kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload init kv postgresql://root@${CLUSTER_IP}:26257?sslmode=disable"
sleep 60


#1-Node, Same Load (100,160)
for i in $( eval echo {1..$NUM_TESTS} )
do
    echo "Test $i"
    echo "Nodes $INITIAL_NUM_REPLICAS"    

    kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run kv --concurrency=$(( $CONCURRENCY*$i )) --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@${CLUSTER_IP}:26257?sslmode=disable'" > ./benchmarks/Benchmark-2/benchmark-nodes1-test$i-$(date +%F_%H-%M-%S)""
    sleep 180

done

# # #N-Node, Same Load (100,160)
minikube delete || true
minikube start --memory 8192 --cpus 4
kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
sleep 60

export CLUSTER_IP=$(kubectl get service/cockroachdb-release-public -n cockroachdb -o jsonpath='{.spec.clusterIP}')
export INITIAL_NUM_REPLICAS=1 #min is 3

kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload init kv postgresql://root@${CLUSTER_IP}:26257?sslmode=disable"
sleep 60

for i in $( eval echo {$INITIAL_NUM_REPLICAS..$NUM_TESTS} )
do
    echo "Test $i"
    echo "Nodes $INITIAL_NUM_REPLICAS"    

    kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run kv --concurrency=$(( $CONCURRENCY )) --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@${CLUSTER_IP}:26257?sslmode=disable'" > ./benchmarks/Benchmark-3/benchmark-nodes1-$(date +%F_%H-%M-%S)""

    let "INITIAL_NUM_REPLICAS=INITIAL_NUM_REPLICAS+1"
    helm upgrade \
    cockroachdb-release \
    cockroachdb/cockroachdb \
    --set statefulset.replicas=$INITIAL_NUM_REPLICAS \
    --reuse-values -n cockroachdb
    sleep 180

done

# #N-Node, Increase Load (N*100,N*160)
minikube delete || true
minikube start --memory 8192 --cpus 4
kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
sleep 60

export CLUSTER_IP=$(kubectl get service/cockroachdb-release-public -n cockroachdb -o jsonpath='{.spec.clusterIP}')
export INITIAL_NUM_REPLICAS=1 #min is 3

kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload init kv postgresql://root@${CLUSTER_IP}:26257?sslmode=disable"
sleep 60

for i in $( eval echo {$INITIAL_NUM_REPLICAS..$NUM_TESTS} )
do
    echo "Test $i"
    echo "Nodes $INITIAL_NUM_REPLICAS"    

    kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run kv --concurrency=$(( $CONCURRENCY*$i )) --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@${CLUSTER_IP}:26257?sslmode=disable'" > ./benchmarks/Benchmark-4/benchmark-nodes$i-test$i-$(date +%F_%H-%M-%S)""

    let "INITIAL_NUM_REPLICAS=INITIAL_NUM_REPLICAS+1"
    helm upgrade \
    cockroachdb-release \
    cockroachdb/cockroachdb \
    --set statefulset.replicas=$INITIAL_NUM_REPLICAS \
    --reuse-values -n cockroachdb
    sleep 180

done

# #N-Node, Increase Load (N*100,N*160)
minikube delete || true
minikube start --memory 8192 --cpus 4
kubectl create namespace cockroachdb
helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
sleep 60

export CLUSTER_IP=$(kubectl get service/cockroachdb-release-public -n cockroachdb -o jsonpath='{.spec.clusterIP}')
export INITIAL_NUM_REPLICAS=3 #min is 3

kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload init kv postgresql://root@${CLUSTER_IP}:26257?sslmode=disable"
sleep 60

for i in $( eval echo {$INITIAL_NUM_REPLICAS..$NUM_TESTS} )
do
    echo "Test $i"
    echo "Nodes $INITIAL_NUM_REPLICAS"    

    kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run kv --concurrency=$(( $CONCURRENCY*$i )) --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@${CLUSTER_IP}:26257?sslmode=disable'" > ./benchmarks/Benchmark-5/benchmark-nodes$i-$(date +%F_%H-%M-%S)""

    let "INITIAL_NUM_REPLICAS=INITIAL_NUM_REPLICAS+1"
    helm upgrade \
    cockroachdb-release \
    cockroachdb/cockroachdb \
    --set statefulset.replicas=$INITIAL_NUM_REPLICAS \
    --reuse-values -n cockroachdb
    sleep 180

done

minikube delete
# minikube start
# kubectl create namespace cockroachdb
# helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
# kubectl get svc -n cockroachdb

# # --concurrency - The number of concurrent workers.