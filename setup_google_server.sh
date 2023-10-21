sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

docker network create -d bridge roachnet
docker volume create roach1
docker run -d \
--name=roach1 \
--hostname=roach1 \
--net=roachnet \
-p 26257:26257 \
-p 8080:8080 \
-v "roach1:/cockroach/cockroach-data" \
cockroachdb/cockroach:v23.1.11 start \
  --advertise-addr=roach1:26357 \
  --http-addr=roach1:8080 \
  --listen-addr=roach1:26357 \
  --sql-addr=roach1:26257 \
  --cache=128MiB #default
  --max-sql-memory=25% #
  --insecure \
  --join= GOOGLE_SERVER_EXTERNAL_IP_1:26357,GOOGLE_SERVER_EXTERNAL_IP_2:26357,GOOGLE_SERVER_EXTERNAL_IP_3:26357, etc...

Nodes (3 vs 5 or 10 ?)
Memory (4 vs 8 gb)
Cache (default 25% ish)
max-sql-memory (default 25% ish)

Replication factor (3 vs 5). NOTE: Can only be used when number of nodes is bigger than 3
Range max size (default 512 Mib, maybe try halving it?)