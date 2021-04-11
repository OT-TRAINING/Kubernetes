#!/bin/bash

source recreate_strategy.sh

# Creating ReplicaSet and its Service
kubectl apply -f rs1.yaml
kubectl apply -f service.yaml


replica_count=`kubectl get rs my-app-v1 -o json | jq '.status.readyReplicas'`
while [ $replica_count != 5 ] 
    do
        echo "Reday replicas of Version 1 :    $replica_count"
        sleep 1s
        replica_count=`kubectl get rs my-app-v1 -o json | jq '.status.readyReplicas'`
    done 

# Current ReplicaSet Host and Version Details
service=$(minikube service my-app --url)
version=$(curl "$service")
echo "Current ReplicaSet host and version -------- $version"

# Scaling ReplicaSet
echo -n " Do you want to scale Replica set select yes(y) or no(n) -->  "
read option
case $option in
y)
    rc=0
    scaleReplicas "$rc"
;;
n)
    exit;
;;
*)
    echo "Invalid option select y to yes and n to exit"
;;
esac