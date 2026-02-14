#!/bin/bash
set -e

NAMESPACE="${1:-}"
GENERAL_NAMESPACE="${2:-}"

echo "--- 🏷️ Creazione namespaces ---"
if ! kubectl get namespace "$GENERAL_NAMESPACE" >/dev/null 2>&1; then
  echo "Creazione namespace '${GENERAL_NAMESPACE}' per i servizi generali"
  kubectl create namespace "$GENERAL_NAMESPACE"
else
  echo "Namespace '${GENERAL_NAMESPACE}' per i servizi generali, skip create"
fi

if ! kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
  echo "Creazione namespace '${NAMESPACE}'"
  kubectl create namespace "$NAMESPACE"
else
  echo "Namespace '${NAMESPACE}' già esistente, skip create"
fi

echo "--- ⚙️ Applico configurazioni Kubernetes per '${NAMESPACE}' ---"
# Usare -f per applicare directory o file
kubectl apply -f ./general-service -n "$GENERAL_NAMESPACE"
kubectl apply -f ./"$NAMESPACE" -n "$NAMESPACE"

# Creazione/aggiornamento del Secret per le variabili d'ambiente sensibili
kubectl create secret generic "$NAMESPACE"-secrets \
  --from-literal=DB_PASSWORD=tuadbpassword \
  --from-literal=JWT_SECRET_KEY=tuajwtsecret \
  -n "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

echo "--- ✅ Configurazione Kubernetes completata ---"

