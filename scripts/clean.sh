#!/bin/bash
set -e

NAMESPACE="${1:-}"

echo "--- 🗑️ Rimozione Configurazioni Kubernetes per '${NAMESPACE}' ---"
kubectl delete -f ./"$NAMESPACE"/ -n "$NAMESPACE" --ignore-not-found

echo "Eliminazione del namespace '${NAMESPACE}'..."
kubectl delete namespace "$NAMESPACE" --ignore-not-found

echo "--- ✅ Rimozione Configurazioni Kubernetes per '${NAMESPACE}' completata ---"