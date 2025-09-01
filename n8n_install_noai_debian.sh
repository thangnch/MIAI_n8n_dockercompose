#!/bin/bash
echo "--------- 🟢 Start install docker -----------"
apt-get remove docker docker-engine docker.io containerd runc
apt-get install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
echo "--------- 🔴 Finish install docker -----------"
echo "--------- 🟢 Start creating folder -----------"
cd ~
mkdir vol_n8n
sudo chown -R 1000:1000 vol_n8n
sudo chmod -R 755 vol_n8n
echo "--------- 🔴 Finish creating folder -----------"
echo "--------- 🟢 Start docker compose up  -----------"
wget https://raw.githubusercontent.com/thangnch/MIAI_n8n_dockercompose/refs/heads/main/compose_noai.yaml -O compose.yaml
export EXTERNAL_IP=http://"$(hostname -I | cut -f1 -d' ')"
export CURR_DIR=$(pwd)
sudo -E docker compose up -d
echo "--------- 🔴 Finish! Wait a few minutes and test in browser at url $EXTERNAL_IP for n8n UI -----------"
