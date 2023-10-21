Voici le texte converti en Markdown :

#### Repositories HELM :
- [Grafana](https://artifacthub.io/packages/helm/grafana/grafana)
- [Prometheus](https://artifacthub.io/packages/helm/prometheus-community/prometheus)
- [Prometheus MySQL Exporter](https://artifacthub.io/packages/helm/prometheus-community/prometheus-mysql-exporter)
- [WordPress](https://artifacthub.io/packages/helm/bitnami/wordpress)

#### URL de Prometheus pour Grafana :
- http://my-prometheus-server (nom du service)

#### WordPress :
- Host : my-wordpress-mariadb:3306
- DB : bitnami_wordpress
- User : bn_wordpress

#### Commandes importantes pour l'administration de WordPress :
```bash
export WORDPRESS_PASSWORD=$(kubectl get secret --namespace default wordpress -o jsonpath="{.data.wordpress-password}" | base64 -d)
export MARIADB_ROOT_PASSWORD=$(kubectl get secret --namespace default wordpress-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 -d)
export MARIADB_PASSWORD=$(kubectl get secret --namespace default wordpress-mariadb -o jsonpath="{.data.mariadb-password}" | base64 -d)
export MARIADB_PVC=$(kubectl get pvc -l app.kubernetes.io/instance=wordpress,app.kubernetes.io/name=mariadb,app.kubernetes.io/component=primary -o jsonpath="{.items[0].metadata.name}")
```

**Important :** Le fichier `/etc/grafana/grafana.ini` est en lecture seule. Impossible de modifier via installation Kube.

#### SMTP : exemple pour GMAIL
```ini
[smtp]
enabled = true
host = smtp.gmail.com:465
user = USER@GMAIL
# If the password contains # or ; you have to wrap it with triple quotes. Ex """
password = USER@GMAIL_PWD
;cert_file =
;key_file =
skip_verify = true
from_address = USER@GMAIL
;from_address = admin@grafana.localhost
from_name = Grafana
# EHLO identity in SMTP dialog (defaults to instance_name)
;ehlo_identity = dashboard.example.com
# SMTP startTLS policy (defaults to 'OpportunisticStartTLS')
;startTLS_policy = NoStartTLS
```
