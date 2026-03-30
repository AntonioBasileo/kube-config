#!/bin/bash

# Script per rimuovere Prometheus e Grafana dal cluster Kubernetes
# Utilizzo: ./clean-monitoring.sh

echo "🗑️  --- Rimozione Stack di Monitoraggio (Prometheus + Grafana) ---"

echo ""
echo "Rimozione Grafana..."
kubectl delete -f /Users/antoniobasileo/progetti/kube-config/general-service/grafana-deployment.yaml --ignore-not-found=true
kubectl delete -f /Users/antoniobasileo/progetti/kube-config/general-service/grafana-configmap.yaml --ignore-not-found=true

echo ""
echo "Rimozione Prometheus..."
kubectl delete -f /Users/antoniobasileo/progetti/kube-config/general-service/prometheus-deployment.yaml --ignore-not-found=true
kubectl delete -f /Users/antoniobasileo/progetti/kube-config/general-service/prometheus-configmap.yaml --ignore-not-found=true

echo ""
echo "✅ --- Rimozione Stack di Monitoraggio completata ---"
echo ""

