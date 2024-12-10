#!/bin/bash

# Mettre à jour les paquets et installer OpenSSH, net-tools, iputils-ping, et nano
apt-get update
apt-get install -y openssh-server net-tools iputils-ping nano

# Configurer le mot de passe root
echo "root:sae" | chpasswd

# Activer le service SSH
mkdir -p /var/run/sshd
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Démarrer le service SSH
service ssh start

# Terminer l'exécution du script
exit 0



