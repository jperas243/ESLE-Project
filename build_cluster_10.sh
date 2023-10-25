
export RAM=$1 #4GB
export CACHE=$2 #128MiB
export MAX_SQL_MEMORY=$3 #25%
export NUM_REPLICAS=$4 #5
export RANGE_MAX_BYTES=$5 #256
export EXPERIMENT_NUMBER=$6 #256

sh init_server_google.sh esle-server1 $RAM
sh init_server_google.sh esle-server2 $RAM
sh init_server_google.sh esle-server3 $RAM
sh init_server_google.sh esle-server4 $RAM
sh init_server_google.sh esle-server5 $RAM
sh init_server_google.sh esle-server6 $RAM
sh init_server_google.sh esle-server7 $RAM
sh init_server_google.sh esle-server8 $RAM
sh init_server_google.sh esle-server9 $RAM
sh init_server_google.sh esle-server10 $RAM
sh init_server_google.sh esle-benchmark $RAM

export SERVER_IP_1=$(gcloud compute instances describe esle-server1 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_2=$(gcloud compute instances describe esle-server2 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_3=$(gcloud compute instances describe esle-server3 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_4=$(gcloud compute instances describe esle-server4 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_5=$(gcloud compute instances describe esle-server5 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_6=$(gcloud compute instances describe esle-server1 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_7=$(gcloud compute instances describe esle-server2 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_8=$(gcloud compute instances describe esle-server3 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_9=$(gcloud compute instances describe esle-server4 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_10=$(gcloud compute instances describe esle-server5 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_BENCHMARK=$(gcloud compute instances describe esle-benchmark --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

gcloud compute firewall-rules create firewall-cockroachdb \
    --project=esle-project \
    --allow=tcp:26257,tcp:26357,tcp:26258,tcp:8080,tcp:22 \
    --source-ranges=0.0.0.0/0 

gcloud compute firewall-rules update firewall-cockroachdb \
    --project=esle-project \
    --allow=tcp:26257,tcp:26357,tcp:8080,tcp:26258,tcp:22 \
    --source-ranges=0.0.0.0/0

gcloud compute firewall-rules update firewall-cockroachdb --target-tags=firewall

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_1 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_1 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_2 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_2 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_3 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_3 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_4 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_5 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_5 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_5 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_6 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_6 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_7 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_7 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_8 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_8 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_9 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_9 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_10 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_10 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure


ssh $SERVER_IP_1 "sudo docker exec roach1 ./cockroach --host=$SERVER_IP_1:26257 init --insecure"
echo $SERVER_IP_1:8080

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload init kv postgresql://root@$SERVER_IP_1:26257?sslmode=disable

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_1 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_2 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_3 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_4 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_5 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_6 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_7 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_8 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_9 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_10 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"

#BENCHMARKS
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=1024 --duration=1m --display-every=30s --tolerate-errors "postgresql://root@$SERVER_IP_1:26257?sslmode=disable" > ./benchmarks/Benchmark-1/benchmark-nodes1-test-$(date +%F_%H-%M-%S)""


sh run_benchmark.sh $SERVER_IP_BENCHMARK $SERVER_IP_1 $EXPERIMENT_NUMBER
sh run_benchmark.sh $SERVER_IP_BENCHMARK $SERVER_IP_1 $EXPERIMENT_NUMBER
sh run_benchmark.sh $SERVER_IP_BENCHMARK $SERVER_IP_1 $EXPERIMENT_NUMBER
sh run_benchmark.sh $SERVER_IP_BENCHMARK $SERVER_IP_1 $EXPERIMENT_NUMBER
sh run_benchmark.sh $SERVER_IP_BENCHMARK $SERVER_IP_1 $EXPERIMENT_NUMBER

