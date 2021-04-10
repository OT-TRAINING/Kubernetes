#!/bin/bash
#primary=$1

kubectl apply -f rs1.yaml
kubectl apply -f service-green.yaml