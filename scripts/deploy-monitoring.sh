#!/bin/bash

# Script per deployare Prometheus e Grafana nel cluster Kubernetes
# Utilizzo: ./deploy-monitoring.sh

echo "📊 --- Deployment Stack di Monitoraggio (Prometheus + Grafana) ---"

# Verifica che il namespace general esista
if ! kubectl get namespace general &> /dev/null; then
    echo "⚠️  Namespace 'general' non trovato, creazione in corso..."
    kubectl create namespace general
else
    echo "✅ Namespace 'general' già esistente"
fi

# Apply Prometheus
echo ""
echo "🔍 Deployment Prometheus..."
kubectl apply -f /Users/antoniobasileo/progetti/kube-config/general-service/prometheus-configmap.yaml
kubectl apply -f /Users/antoniobasileo/progetti/kube-config/general-service/prometheus-deployment.yaml

# Attendi che Prometheus sia pronto
echo "⏳ Attendo che Prometheus sia pronto..."
kubectl wait --for=condition=available --timeout=120s deployment/prometheus-deployment -n general

# Apply Grafana
echo ""
echo "📈 Deployment Grafana..."
kubectl apply -f /Users/antoniobasileo/progetti/kube-config/general-service/grafana-configmap.yaml
kubectl apply -f /Users/antoniobasileo/progetti/kube-config/general-service/grafana-deployment.yaml

# Attendi che Grafana sia pronto
echo "⏳ Attendo che Grafana sia pronto..."
kubectl wait --for=condition=available --timeout=120s deployment/grafana-deployment -n general

echo ""
echo "✅ --- Deployment Stack di Monitoraggio completato ---"
echo ""
echo "📊 Accesso ai servizi:"
echo "   Prometheus: http://localhost:30090"
echo "   Grafana:    http://localhost:30300"
echo ""
echo "🔑 Credenziali Grafana:"
echo "   Username: admin"
echo "   Password: admin"
echo ""
echo "📝 Note:"
echo "   - Prometheus sta già raccogliendo metriche da manage-orders"
echo "   - Grafana è pre-configurato con Prometheus come datasource"
echo "   - Per importare dashboard: usa i dashboard ID di Grafana.com"
echo "     • Spring Boot 2.1+ (ID: 11378)"
echo "     • JVM (Micrometer) (ID: 4701)"
echo "     • Kafka (ID: 7589)"
echo ""

