#!/bin/bash
#primary=$1
#blue_app=$1
#blue_svc=$2
#rs2.yaml
#service-blue.yaml
kubectl apply -f $blue_app
kubectl apply -f $blue_svc
#kubectl apply -f rs2.yaml
#kubectl apply -f service-blue.yaml
echo "perform testing of your blue version --curl my-app-blue"
