#!/bin/bash
set -e

SERVICE_PORT="${SERVICE_PORT:-}"

echo "--- 🚀 Configurazione Kubernetes ---"
if ! kubectl get namespace tirocinio-smart >/dev/null 2>&1; then
  echo "Creazione namespace 'tirocinio-smart'"
  kubectl create namespace tirocinio-smart
else
  echo "Namespace 'tirocinio-smart' già esistente, skip create"
fi

echo "Applicazione configurazioni Kubernetes per 'tirocinio-smart'..."
# Usare -f per applicare directory o file
kubectl apply -f ./tirocinio-smart -n tirocinio-smart

# Creazione/aggiornamento del Secret in modo idempotente
kubectl create secret generic tirocinio-smart-secrets \
  --from-literal=DB_PASSWORD=asdfsa. \
  --from-literal=JWT_SECRET_KEY=sadfasd \
  -n tirocinio-smart --dry-run=client -o yaml | kubectl apply -f -

echo "--- ✅ Configurazione Kubernetes completata ---"
echo "Adesso puoi accedere all'applicazione all'indirizzo http://localhost:${SERVICE_PORT}/tirocinio-smart/"
