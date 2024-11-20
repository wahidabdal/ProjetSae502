# ProjetSae502
Sujet: Déploiement d’un système de détection d’intrusion réseau (Security Onion) et d’un serveur FTP sécurisé

Cahier des charges 

1. Introduction
Objectif du Projet

Le projet vise à mettre en place un système de détection d’intrusion réseau (Security Onion) et un serveur FTP sécurisé pour simuler un environnement de production.
L’objectif est de permettre aux administrateurs système de surveiller et de gérer efficacement la sécurité du réseau et les transferts de fichiers.

2. Outils Utilisés

    Docker : Pour la conteneurisation des services.
    Ansible : Pour l’automatisation du déploiement et de la configuration.
    Security Onion : Pour la détection d’intrusion réseau et la surveillance de la sécurité.
    Serveur FTP sécurisé : Pour simuler un environnement de production.

3. Architecture
Conteneurs Docker

    Conteneur Security Onion : Pour la détection d’intrusion réseau et la surveillance de la sécurité.
    Conteneur FTP sécurisé : Pour les transferts de fichiers sécurisés.
    Conteneur Mailu : Pour la gestion des alertes par email.
    Machine/Conteneur de test : Pour valider le bon fonctionnement du projet.

4. Mise en œuvre

Préparation de l’environnement

    Mise en place d’un script pour le déploiement des conteneurs.
    Installation de Docker et Docker Compose sur le serveur Ubuntu.
    Installation d’Ansible pour l’automatisation du déploiement.

Déploiement des services

    Création des playbooks Ansible pour l’installation et la configuration de Security Onion, du serveur FTP sécurisé et de Mailu.
    Configuration des certificats SSL/TLS pour sécuriser les communications.
    Configuration des règles de pare-feu pour protéger les services.

Configuration du système d’alerting

    Mise en place d’un système d’alerting pour notifier les administrateurs en cas de détection d’intrusions par Security Onion.

Tests et validation

    Test de bon fonctionnement des services déployés.
    Vérification de la détection d’intrusions par Security Onion.
    Vérification des transferts de fichiers sécurisés via le serveur FTP.
    Vérification de la réception des alertes par email.

5. Playbooks Ansible

    Un playbook pour le déploiement et la configuration du Security Onion.
    Un playbook pour le déploiement et la configuration du serveur FTP sécurisé avec SSL.
    Un playbook pour le déploiement et la configuration du serveur mail Mailu.
    Un playbook pour la configuration des règles de pare-feu et des certificats SSL/TLS.
    Un playbook pour la configuration du système d’alerting pour Security Onion.
    Un playbook pour le lancement des autres playbooks codés.
