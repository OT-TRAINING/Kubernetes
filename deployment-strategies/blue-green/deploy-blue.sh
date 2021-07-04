#!/bin/bash
kubectl apply -f rs2.yaml
kubectl apply -f service-blue.yaml
echo "perform testing of your blue version --curl my-app-blue"
