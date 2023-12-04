#!/bin/bash
kubectl delete -f ./manifest/grafana.yaml
kubectl delete -f ./manifest/prometheus.yaml
kubectl delete -f ./manifest/node-exporter.yaml
minikube delete -p grafana
