#!/bin/bash
set -e

echo "--- 🗑️ Rimozione Configurazioni Kubernetes per 'tirocinio-smart' ---"
kubectl delete -f ./tirocinio-smart/ -n tirocinio-smart

echo "Eliminazione del namespace 'tirocinio-smart'..."
kubectl delete namespace tirocinio-smart

echo "--- ✅ Rimozione Configurazioni Kubernetes per 'tirocinio-smart' completata ---"