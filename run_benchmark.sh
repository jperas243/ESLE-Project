ssh $SERVER_IP docker exec -it roach1 ./cockroach --host=roach1:26357 init --insecure

kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run kv --concurrency=$(( $CONCURRENCY*$i )) --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@${CLUSTER_IP}:26257?sslmode=disable'" > ./benchmarks/Benchmark-4/benchmark-nodes1-test$i-$(date +%F_%H-%M-%S)""

