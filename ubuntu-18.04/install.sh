#!/bin/bash
echo "Instalando dependências. Será necessária conexão de rede."
wget -O /tmp/key.gpg https://download.docker.com/linux/ubuntu/gpg 
cat /tmp/key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Adicionando repositório do docker."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "atualizando lista de repositórios"
sudo apt update
sudo apt install -y git apt-transport-https ca-certificates curl gnupg lsb-release docker-ce docker-ce-cli containerd.io python3-pip
sudo groupadd docker
sudo adduser $(whoami) docker

python -m pip3 install -U pip setuptools
sudo pip3 install docker-compose

echo "Download"
wget -O /tmp/master-2x.zip https://github.com/NeoResearch/neocompiler-eco/archive/refs/heads/master-2x.zip
unzip -d /tmp/ /tmp/master-2x.zip
sudo mv /tmp/neocompiler-eco-master-2x /opt/
sudo chmod 775 /opt/neocompiler-eco-master-2x -R
sudo chown $(whoami):$(whoami) /opt/neocompiler-eco-master-2x -R

echo "Iniciando Build"
sudo chmod 777 /var/run/docker.sock
cd /opt/neocompiler-eco-master-2x/
/opt/neocompiler-eco-master-2x/build_everything.sh
