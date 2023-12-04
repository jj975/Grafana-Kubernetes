#!/bin/bash

minikube start --cpus=2 --memory=2048mb --disk-size=10g --vm-driver=virtualbox --nodes=1 -p grafana

kubectl apply -f ./manifest/grafana.yaml
kubectl apply -f ./manifest/prometheus.yaml
kubectl apply -f ./manifest/node-exporter.yaml

kubectl get nodes -o wide

kubectl get service