#!/bin/bash

# Функция-обёртка для kubectl через minikube
kubectl() {
    minikube kubectl -- "$@"
}

kubectl apply -f bindings/pods-reader-binding.yaml
kubectl apply -f bindings/pods-operator-binding.yaml
kubectl apply -f bindings/secrets-reader-binding.yaml