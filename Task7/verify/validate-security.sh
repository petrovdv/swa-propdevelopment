#!/bin/bash

# Функция-обёртка для kubectl через minikube
kubectl() {
    minikube kubectl -- "$@"
}

kubectl apply -f ./02-create-unrestricted-namespace.yaml

kubectl apply -f ./gatekeeper/constraint-templates/hostpath.yaml
kubectl apply -f ./gatekeeper/constraint-templates/privileged.yaml
kubectl apply -f ./gatekeeper/constraint-templates/runasnonroot.yaml

kubectl apply -f ./gatekeeper/constraints/hostpath.yaml
kubectl apply -f ./gatekeeper/constraints/privileged.yaml
kubectl apply -f ./gatekeeper/constraints/runasnonroot.yaml

kubectl apply -f ./insecure-manifests/01-privileged-pod.yaml
kubectl apply -f ./insecure-manifests/02-hostpath-pod.yaml
kubectl apply -f ./insecure-manifests/03-root-user-pod.yaml

kubectl apply -f ./secure-manifests/01-secure.yaml
kubectl apply -f ./secure-manifests/02-secure.yaml
kubectl apply -f ./secure-manifests/03-secure.yaml

