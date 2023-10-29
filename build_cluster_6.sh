
export RAM=$1 #4GB
export CACHE=$2 #128MiB
export MAX_SQL_MEMORY=$3 #25%
export NUM_REPLICAS=$4 #5
export RANGE_MAX_BYTES=$5 #256

sh init_server_google.sh esle-server1 $RAM
sh init_server_google.sh esle-server2 $RAM
sh init_server_google.sh esle-server3 $RAM
sh init_server_google.sh esle-server4 $RAM
sh init_server_google.sh esle-server5 $RAM
sh init_server_google.sh esle-server6 $RAM
sh init_server_google.sh esle-benchmark $RAM

export SERVER_IP_1=$(gcloud compute instances describe esle-server1 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_2=$(gcloud compute instances describe esle-server2 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_3=$(gcloud compute instances describe esle-server3 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_4=$(gcloud compute instances describe esle-server4 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_5=$(gcloud compute instances describe esle-server5 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_6=$(gcloud compute instances describe esle-server6 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_BENCHMARK=$(gcloud compute instances describe esle-benchmark --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

gcloud compute firewall-rules create firewall-cockroachdb \
    --project=esle-project-403114 \
    --allow=tcp:26257,tcp:26357,tcp:26258,tcp:8080,tcp:22 \
    --source-ranges=0.0.0.0/0 

gcloud compute firewall-rules update firewall-cockroachdb \
    --project=esle-project-403114 \
    --allow=tcp:26257,tcp:26357,tcp:8080,tcp:26258,tcp:22 \
    --source-ranges=0.0.0.0/0

gcloud compute firewall-rules update firewall-cockroachdb --target-tags=firewall

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_1 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_1 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_2 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_2 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_3 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_3 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_4 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_4 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_5 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_5 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_6 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_6 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh $SERVER_IP_1 "sudo docker exec roach1 ./cockroach --host=$SERVER_IP_1:26257 init --insecure"
echo $SERVER_IP_1:8080

# #BENCHMARKS

CONNECT_STRING1="postgresql://root@${SERVER_IP_1}:26257?sslmode=disable"
CONNECT_STRING2="postgresql://root@${SERVER_IP_2}:26257?sslmode=disable"
CONNECT_STRING3="postgresql://root@${SERVER_IP_3}:26257?sslmode=disable"
CONNECT_STRING4="postgresql://root@${SERVER_IP_4}:26257?sslmode=disable"
CONNECT_STRING5="postgresql://root@${SERVER_IP_5}:26257?sslmode=disable"
CONNECT_STRING6="postgresql://root@${SERVER_IP_6}:26257?sslmode=disable"
CONNECTION_STRING_TOT="${CONNECT_STRING1} ${CONNECT_STRING2} ${CONNECT_STRING3} ${CONNECT_STRING4} ${CONNECT_STRING5} ${CONNECT_STRING6}"

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload init kv postgresql://root@${SERVER_IP_1}:26257?sslmode=disable

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_1 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_2 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_3 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_4 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_5 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_6 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=256 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/6_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=256 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/6_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=256 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/6_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=256 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/6_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=256 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/6_nodes/benchmark-test-$(date +%F_%H-%M-%S)""






