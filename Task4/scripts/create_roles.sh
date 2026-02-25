#!/bin/bash

# Функция-обёртка для kubectl через minikube
kubectl() {
    minikube kubectl -- "$@"
}

kubectl apply -f roles/pods-reader-role.yaml
kubectl apply -f roles/pods-operator-role.yaml
kubectl apply -f roles/secrets-reader-role.yaml