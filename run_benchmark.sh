
#change SQL Tables
# cockroach sql --execute="<sql statement>;<sql statement>" --execute="<sql-statement>" <flags>
#create Google Server Benchmark

ssh -o StrictHostKeyChecking=accept-new $1 sudo docker run --rm --name=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload init kv postgresql://root@35.230.133.144:26257?sslmode=disable

ssh -o StrictHostKeyChecking=accept-new $1 sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=1024 --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@35.230.133.144:26257?sslmode=disable' > ./benchmarks/Benchmark-4/benchmark-nodes1-test-$(date +%F_%H-%M-%S)""


# kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload init kv postgresql://root@${CLUSTER_IP}:26257?sslmode=disable"

# kubectl run -n cockroachdb cockroachdb --image=cockroachdb/cockroach:v23.1.10 -it --rm -- bash -c "cockroach workload run kv --concurrency=$(( $CONCURRENCY*$i )) --duration=1m --display-every=30s --tolerate-errors 'postgresql://root@${CLUSTER_IP}:26257?sslmode=disable'" > ./benchmarks/Benchmark-4/benchmark-nodes1-test$i-$(date +%F_%H-%M-%S)""