sudo apt-get update -y
echo "yes" | sudo apt-get install ca-certificates curl gnupg
echo "yes" | sudo install -m 0755 -d /etc/apt/keyrings
echo "yes" | curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "yes" | sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install telnet -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# sudo docker volume create roach1


# Nodes (3 vs 5 or 10 ?)
# Memory (4 vs 8 gb)
# Cache (default 25% ish)
# max-sql-memory (default 25% ish)

# Replication factor (3 vs 5). NOTE: Can only be used when number of nodes is bigger than 3
# Range max size (default 512 Mib, maybe try halving it?)