#!/bin/bash

# Lire l'incrément actuel depuis le fichier de configuration
INCREMENT=$(cat config.txt)

# Incrémenter les adresses IP et les noms de conteneurs
SECURITY_ONION_IP="192.168.119.$((2 + INCREMENT))"
FTP_SECURE_IP="192.168.119.$((3 + INCREMENT))"
MAILU_IP="192.168.119.$((4 + INCREMENT))"
TEST_CONTAINER_IP="192.168.119.$((5 + INCREMENT))"
NODE_MANAGER_IP="192.168.119.$((6 + INCREMENT))"

SECURITY_ONION_NAME="security_onion_$INCREMENT"
FTP_SECURE_NAME="ftp_secure_$INCREMENT"
MAILU_NAME="mailu_$INCREMENT"
TEST_CONTAINER_NAME="test_container_$INCREMENT"
NODE_MANAGER_NAME="node_manager_$INCREMENT"

# Créer le réseau Docker si nécessaire
docker network create --driver bridge --subnet=192.168.119.0/24 sae502 2>/dev/null || true

# Lancer le conteneur Security Onion
docker run --name $SECURITY_ONION_NAME --hostname $SECURITY_ONION_NAME \
--network sae502 --ip $SECURITY_ONION_IP \
--add-host $SECURITY_ONION_NAME:$SECURITY_ONION_IP \
--add-host $FTP_SECURE_NAME:$FTP_SECURE_IP \
--add-host $MAILU_NAME:$MAILU_IP \
--add-host $TEST_CONTAINER_NAME:$TEST_CONTAINER_IP \
--add-host $NODE_MANAGER_NAME:$NODE_MANAGER_IP \
-v $(pwd)/init-ssh.sh:/init-ssh.sh \
ubuntu:latest /bin/bash /init-ssh.sh

# Lancer le conteneur FTP sécurisé
docker run --name $FTP_SECURE_NAME --hostname $FTP_SECURE_NAME \
--network sae502 --ip $FTP_SECURE_IP \
--add-host $SECURITY_ONION_NAME:$SECURITY_ONION_IP \
--add-host $FTP_SECURE_NAME:$FTP_SECURE_IP \
--add-host $MAILU_NAME:$MAILU_IP \
--add-host $TEST_CONTAINER_NAME:$TEST_CONTAINER_IP \
--add-host $NODE_MANAGER_NAME:$NODE_MANAGER_IP \
-v $(pwd)/init-ssh.sh:/init-ssh.sh \
ubuntu:latest /bin/bash /init-ssh.sh

# Lancer le conteneur Mailu
docker run --name $MAILU_NAME --hostname $MAILU_NAME \
--network sae502 --ip $MAILU_IP \
--add-host $SECURITY_ONION_NAME:$SECURITY_ONION_IP \
--add-host $FTP_SECURE_NAME:$FTP_SECURE_IP \
--add-host $MAILU_NAME:$MAILU_IP \
--add-host $TEST_CONTAINER_NAME:$TEST_CONTAINER_IP \
--add-host $NODE_MANAGER_NAME:$NODE_MANAGER_IP \
-v $(pwd)/init-ssh.sh:/init-ssh.sh \
ubuntu:latest /bin/bash /init-ssh.sh

# Lancer le conteneur Test
docker run --name $TEST_CONTAINER_NAME --hostname $TEST_CONTAINER_NAME \
--network sae502 --ip $TEST_CONTAINER_IP \
--add-host $SECURITY_ONION_NAME:$SECURITY_ONION_IP \
--add-host $FTP_SECURE_NAME:$FTP_SECURE_IP \
--add-host $MAILU_NAME:$MAILU_IP \
--add-host $TEST_CONTAINER_NAME:$TEST_CONTAINER_IP \
--add-host $NODE_MANAGER_NAME:$NODE_MANAGER_IP \
-v $(pwd)/init-ssh.sh:/init-ssh.sh \
ubuntu:latest /bin/bash /init-ssh.sh

# Lancer le conteneur Node Manager
docker run --name $NODE_MANAGER_NAME --hostname $NODE_MANAGER_NAME \
--network sae502 --ip $NODE_MANAGER_IP \
--add-host $SECURITY_ONION_NAME:$SECURITY_ONION_IP \
--add-host $FTP_SECURE_NAME:$FTP_SECURE_IP \
--add-host $MAILU_NAME:$MAILU_IP \
--add-host $TEST_CONTAINER_NAME:$TEST_CONTAINER_IP \
--add-host $NODE_MANAGER_NAME:$NODE_MANAGER_IP \
-v $(pwd)/init-ssh.sh:/init-ssh.sh \
ubuntu:latest /bin/bash /init-ssh.sh

# Démarrer les conteneurs en arrière-plan
docker start $SECURITY_ONION_NAME
docker start $FTP_SECURE_NAME
docker start $MAILU_NAME
docker start $TEST_CONTAINER_NAME
docker start $NODE_MANAGER_NAME

# Incrémenter le fichier de configuration
echo $((INCREMENT + 1)) > config.txt

# Vérifier que les conteneurs sont en cours d'exécution
docker ps


