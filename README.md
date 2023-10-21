# TP6


## Ojectif:
Mettre en place une solution de monitoring centralisé pour stocker les métriques et fournir des tableaux de bord de surveillance de son cluster Kubernetes et des applications qu’il contient.


### Description des fichiers fournis:

- info.md: liste des commandes à exécuter manuellement afin de pouvoir configurer les différents packages.
  Il contient également des instructions de configuration pour Prometheus, Grafana et Wordpress(Bitnami).

- Dans le dossier install:
  - script.sh: permet d'ajouter et de déclencher l'installation des repos helm au sein de notre cluster Minikube, ainsi que de déployer le serveur Nginx.

- Dans le dossier config/json : 
  - alerte-rule.json: fichier de configuration de l'alerte qui se déclenche quand le nombre de pods descend en dessous de 18.
  - minikube-dashboard.json: fichier de paramétrages métriques du dashboard pour le cluster minikube.
  - wordpress-dashboard.json: fichier de paramétrages métriques du dashboard pour l'application wordpress.
- Dans le dossier config/capture :
  - contient les captures d'écran pour les différents paramétres de Grafana (base de données, point de contact, notification policies, dashboard wordpress)

#### Description des pré-requis:
- Système Linux.
- Configuration: Minikube
- Installer HELM
- Installer kubectl


###### Quels sont les métriques utilisées, d’où viennent t’elles et pourquoi ces métriques-là sont importantes:

Les métriques ci-dessous permettent d'effectuer différents contrôles, sur notamment la montée en charge du cpu et l'évolution de la mémoire rss.

Elles permettent également de contrôler le trafic entrant et sortant.

Ce sont des métriques utilisées dans de nombreux projets lorsque l'on veut mettre en place une solution de monitoring.

Elle permettent de prévenir une montée en charge du cpu et donc, de pouvoir réagir efficacement et rapidement afin d'éviter que les machines ne s'arrêtent.

Contrôler le trafic en e/s est également très important pour éviter un arrêt des machines, ou simplement que l'application se retrouve down.

- Suivi de l'évolution de la mémoire RSS au cours des 5 dernières minutes:
  rate(container_memory_rss[5m])

- Taux de l'utilisation du CPU pour chaque conteneur:
  rate(container_cpu_usage_seconds_total{}[5m])

- Trafic réseau reçu:
  sum(rate(container_network_receive_bytes_total[5m])) by (name)

- Traffic réseau sortant:
  sum(rate(container_network_transmit_bytes_total[5m])) by (namespace)


###### Comment utiliser les fichiers de tableaux de bord, et à quoi correspond chaque tableau de bord fourni:

Les fichiers JSON des tableaux de bord dans Grafana servent à définir et à exporter la configuration complète d'un tableau de bord, sous une forme lisible par machine.

Ces fichiers permettent aux utilisateurs de sauvegarder, de partager et de restaurer des tableaux de bord, ainsi que de les versionner en utilisant des systèmes de gestion de versions.

Les fichiers JSON des tableaux de bord sont un moyen pratique de gérer, partager et collaborer sur la configuration des tableaux de bord dans Grafana.

Il est ensuite pratique de gérer, partager et de pouvoir collaborer sur la configuration des tableaux de bord.

Dans notre solution de monitoring, les tableaux de bord possèdent des graphiques appropriés et lisibles par les utilisateurs.

Il est donc facile de suivre les données rapidement en temps réel.

Nous avons mis en place une surveillance du CPU et de la mémoire, ainsi que l'évolution du trafic entrant et sortant.


###### Description et utilisation des alertes:

Les alertes dans Grafana servent à surveiller et à signaler des événements ou des conditions spécifiques pour nos données ou métriques.

Elles sont essentielles pour la gestion des systèmes et la surveillance des performances, car elles permettent de réagir rapidement aux situations anormales.

Elles permettent notamment de prévenir d'éventuelles pannes, de détecter des anomalies, de pouvoir réagir rapidement, de garder une surveillance en continu, d'optimiser les performances et de tout centraliser au même endroit.

Pour les utiliser, il faut créer une règle d'alerte.

Dans notre cas, deux rêgles ont été créés:

- rulescpu: cette rêgle prévient d'un pic de charge du cpu si celui-ci atteint les 90%.

- rulesgroup-pods: cette règle là, vérifie que l'intégralité des pods ont été mis en place.

Si une alerte se déclenche, le voyant passe au rouge: Alert -> un email est immédiatement envoyée dans la boite mail de l'utilisateur qui a été défini pour gérer ces alertes.

L'utilisateur se définit dans: Contact Point et s'appelle dans notre cas: user_alert

C'est lui qui va recevoir les deux alertes précédentes mises en place.

Il est possible de définir un utilisateur par alerte ou par alerte précise.

Les alertes sont routés vers le user-alert dans les Notifications Policies qu'il faut également préciser.

Dans la rubrique Contact Point, nous indiquons que nous envoyons un format de type email en cas d'alerte.

###### Comment ajouter les métriques d’une nouvelle application:

Pour ajouter les métriques d'une nouvelle application, il faut créer une connection.

Ici nous avons ajouté une connexion à MySql pour pouvoir travailler sur la base de données, et définir un dashboard spécifique à Wordpress.

Ainsi, je possède deux dashboard qui correspondent à l'application voulue.

Je définis les métriques dans chacun de mes dashboard de la même manière.

Dans le cas de Wordpress, une métrique a été défini permettant de contrôler le nombre d'utilisateurs de Wordpress.

Je sélectionne dans l'onglet datasource mon Wordpress, et dans l'onglet code, je vérifie le nombre d'utilisateurs en effectuant une requête SQL:
SELECT * FROM bitnami_wordpress.wp_users, dans laquelle je lui demande le nombre d'utilisateurs de la table wp_users.

On peut donc observer dans le graphique, qu'il n'y a aucun utilisateur enregistré pour le moment et que le compteur est donc à zéro.

Cette query se trouve classé A, et je peux effectuer d'autres requêtes en cliquant sur le bouton Add Query qui seront ensuite classés.









