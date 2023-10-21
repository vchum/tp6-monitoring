#Installation Prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install my-prometheus prometheus-community/prometheus --version 25.1.0
helm install my-prometheus-mysql-exporter prometheus-community/prometheus-mysql-exporter --version 2.1.0

#Installation Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm install my-grafana grafana/grafana --version 6.61.1

#Installationn Wordpress
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-wordpress bitnami/wordpress --version 18.0.7