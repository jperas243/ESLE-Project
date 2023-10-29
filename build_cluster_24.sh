
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
sh init_server_google.sh esle-server7 $RAM
sh init_server_google.sh esle-server8 $RAM
sh init_server_google.sh esle-server9 $RAM
sh init_server_google.sh esle-server10 $RAM
sh init_server_google.sh esle-server11 $RAM
sh init_server_google.sh esle-server12 $RAM
sh init_server_google.sh esle-server13 $RAM
sh init_server_google.sh esle-server14 $RAM
sh init_server_google.sh esle-server15 $RAM
sh init_server_google.sh esle-server16 $RAM
sh init_server_google.sh esle-server17 $RAM
sh init_server_google.sh esle-server18 $RAM
sh init_server_google.sh esle-server19 $RAM
sh init_server_google.sh esle-server20 $RAM
sh init_server_google.sh esle-server21 $RAM
sh init_server_google.sh esle-server22 $RAM
sh init_server_google.sh esle-server23 $RAM
sh init_server_google.sh esle-server24 $RAM
sh init_server_google.sh esle-benchmark $RAM

export SERVER_IP_1=$(gcloud compute instances describe esle-server1 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_2=$(gcloud compute instances describe esle-server2 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_3=$(gcloud compute instances describe esle-server3 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_4=$(gcloud compute instances describe esle-server4 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_5=$(gcloud compute instances describe esle-server5 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_6=$(gcloud compute instances describe esle-server6 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_7=$(gcloud compute instances describe esle-server7 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_8=$(gcloud compute instances describe esle-server8 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_9=$(gcloud compute instances describe esle-server9 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_10=$(gcloud compute instances describe esle-server10 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_11=$(gcloud compute instances describe esle-server11 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_12=$(gcloud compute instances describe esle-server12 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_13=$(gcloud compute instances describe esle-server13 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_14=$(gcloud compute instances describe esle-server14 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_15=$(gcloud compute instances describe esle-server15 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_16=$(gcloud compute instances describe esle-server16 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_17=$(gcloud compute instances describe esle-server17 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_18=$(gcloud compute instances describe esle-server18 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_19=$(gcloud compute instances describe esle-server19 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_20=$(gcloud compute instances describe esle-server20 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_21=$(gcloud compute instances describe esle-server21 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_22=$(gcloud compute instances describe esle-server22 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_23=$(gcloud compute instances describe esle-server23 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
export SERVER_IP_24=$(gcloud compute instances describe esle-server24 --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
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

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_1 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_1 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_2 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_2 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_3 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_3 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_4 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_4 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_5 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_5 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_6 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_6 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_7 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_7 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_8 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_8 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_9 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_9 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_10 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_10 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_11 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_11 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_12 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_12 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_13 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_13 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_14 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_14 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_15 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_15 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_16 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_16 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_17 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_17 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_18 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_18 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_19 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_19 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_20 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_20 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_21 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_21 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_22 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_22 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_23 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_23 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_24 sudo docker run -d --name=roach1 --hostname=roach1 -p 26258:26258 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 start --advertise-addr=$SERVER_IP_24 --join=$SERVER_IP_1,$SERVER_IP_2,$SERVER_IP_3,$SERVER_IP_4,$SERVER_IP_5,$SERVER_IP_6,$SERVER_IP_7,$SERVER_IP_8,$SERVER_IP_9,$SERVER_IP_10,$SERVER_IP_11,$SERVER_IP_12,$SERVER_IP_13,$SERVER_IP_14,$SERVER_IP_15,$SERVER_IP_16,$SERVER_IP_17,$SERVER_IP_18,$SERVER_IP_19,$SERVER_IP_20,$SERVER_IP_21,$SERVER_IP_22,$SERVER_IP_23,$SERVER_IP_24 --cache=$CACHE --max-sql-memory=$MAX_SQL_MEMORY --insecure 

ssh $SERVER_IP_1 "sudo docker exec roach1 ./cockroach --host=$SERVER_IP_1:26257 init --insecure"
echo $SERVER_IP_1:8080

# #BENCHMARKS

CONNECT_STRING1="postgresql://root@${SERVER_IP_1}:26257?sslmode=disable"
CONNECT_STRING2="postgresql://root@${SERVER_IP_2}:26257?sslmode=disable"
CONNECT_STRING3="postgresql://root@${SERVER_IP_3}:26257?sslmode=disable"
CONNECT_STRING4="postgresql://root@${SERVER_IP_4}:26257?sslmode=disable"
CONNECT_STRING5="postgresql://root@${SERVER_IP_5}:26257?sslmode=disable"
CONNECT_STRING6="postgresql://root@${SERVER_IP_6}:26257?sslmode=disable"
CONNECT_STRING7="postgresql://root@${SERVER_IP_7}:26257?sslmode=disable"
CONNECT_STRING8="postgresql://root@${SERVER_IP_8}:26257?sslmode=disable"
CONNECT_STRING9="postgresql://root@${SERVER_IP_9}:26257?sslmode=disable"
CONNECT_STRING10="postgresql://root@${SERVER_IP_10}:26257?sslmode=disable"
CONNECT_STRING11="postgresql://root@${SERVER_IP_11}:26257?sslmode=disable"
CONNECT_STRING12="postgresql://root@${SERVER_IP_12}:26257?sslmode=disable"
CONNECT_STRING13="postgresql://root@${SERVER_IP_13}:26257?sslmode=disable"
CONNECT_STRING14="postgresql://root@${SERVER_IP_14}:26257?sslmode=disable"
CONNECT_STRING15="postgresql://root@${SERVER_IP_15}:26257?sslmode=disable"
CONNECT_STRING16="postgresql://root@${SERVER_IP_16}:26257?sslmode=disable"
CONNECT_STRING17="postgresql://root@${SERVER_IP_17}:26257?sslmode=disable"
CONNECT_STRING18="postgresql://root@${SERVER_IP_18}:26257?sslmode=disable"
CONNECT_STRING19="postgresql://root@${SERVER_IP_19}:26257?sslmode=disable"
CONNECT_STRING20="postgresql://root@${SERVER_IP_20}:26257?sslmode=disable"
CONNECT_STRING21="postgresql://root@${SERVER_IP_21}:26257?sslmode=disable"
CONNECT_STRING22="postgresql://root@${SERVER_IP_22}:26257?sslmode=disable"
CONNECT_STRING23="postgresql://root@${SERVER_IP_23}:26257?sslmode=disable"
CONNECT_STRING24="postgresql://root@${SERVER_IP_24}:26257?sslmode=disable"
CONNECTION_STRING_TOT="${CONNECT_STRING1} ${CONNECT_STRING2} ${CONNECT_STRING3} ${CONNECT_STRING4} ${CONNECT_STRING5} ${CONNECT_STRING6} ${CONNECT_STRING7} ${CONNECT_STRING8} ${CONNECT_STRING9} ${CONNECT_STRING10} ${CONNECT_STRING11} ${CONNECT_STRING12} ${CONNECT_STRING13} ${CONNECT_STRING14} ${CONNECT_STRING15} ${CONNECT_STRING16} ${CONNECT_STRING17} ${CONNECT_STRING18} ${CONNECT_STRING19} ${CONNECT_STRING20} ${CONNECT_STRING21} ${CONNECT_STRING22} ${CONNECT_STRING23} ${CONNECT_STRING24}"

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload init kv postgresql://root@${SERVER_IP_1}:26257?sslmode=disable

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
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_11 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_12 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_13 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_14 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_15 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_16 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_17 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_18 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_19 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_20 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_21 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_22 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_23 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_24 "sudo docker exec roach1 cockroach sql --database=kv --insecure --execute='ALTER TABLE kv CONFIGURE ZONE USING range_min_bytes = 0, range_max_bytes = $RANGE_MAX_BYTES, gc.ttlseconds = 89999, num_replicas = $NUM_REPLICAS;'"

ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=1024 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/24_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=1024 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/24_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=1024 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/24_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=1024 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/24_nodes/benchmark-test-$(date +%F_%H-%M-%S)""
ssh -o StrictHostKeyChecking=accept-new $SERVER_IP_BENCHMARK sudo docker run --rm --name=roach1 --hostname=roach1 -p 26257:26257 -p 26357:26357 -p 8080:8080 cockroachdb/cockroach:v23.1.11 workload run kv --concurrency=1024 --duration=1m --display-every=30s --tolerate-errors $CONNECTION_STRING_TOT > ./benchmarks/scalability_test/24_nodes/benchmark-test-$(date +%F_%H-%M-%S)""






