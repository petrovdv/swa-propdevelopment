#!/bin/bash

# Функция-обёртка для kubectl через minikube
kubectl() {
    minikube kubectl -- "$@"
}

kubectl apply -f users/pods-reader-user.yaml
kubectl apply -f users/pods-operator-user.yaml
kubectl apply -f users/secrets-reader-user.yaml