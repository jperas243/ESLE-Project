#!bin/bash

export CLUSTER_IP=10.106.210.86
export INITIAL_NUM_REPLICAS=3 #min is 3
export NUM_TESTS=20

kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload init tpcc --warehouses=10 --survival-goal zone postgresql://root@${CLUSTER_IP}:26257/tpcc?sslmode=disable"
sleep 60

for i in $( eval echo {1..$NUM_TESTS} )
do
    echo "Test $i"
    echo "Nodes $INITIAL_NUM_REPLICAS"  
    echo "$(( $i*100 ))"  

    kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run tpcc --warehouses=10 --concurrency=$(( $i*100 )) --duration=1m --wait=true --tolerate-errors --survival-goal zone 'postgresql://root@${CLUSTER_IP}:26257/tpcc?sslmode=disable'" > ./benchmarks/benchmark-nodes$INITIAL_NUM_REPLICAS-$(date +%F_%H-%M-%S)""
    sleep 150

    let "INITIAL_NUM_REPLICAS=INITIAL_NUM_REPLICAS+1"
    helm upgrade \
    cockroachdb-release \
    cockroachdb/cockroachdb \
    --set statefulset.replicas=$INITIAL_NUM_REPLICAS \
    --reuse-values -n cockroachdb
    sleep 150

done

minikube delete
# minikube start
# kubectl create namespace cockroachdb
# helm install cockroachdb-release --values my-values.yaml cockroachdb/cockroachdb -n cockroachdb
# kubectl get svc -n cockroachdb

# --concurrency - The number of concurrent workers.