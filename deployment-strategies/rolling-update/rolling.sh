#!/bin/bash

source rolling_strategy.sh

kubectl apply -f rs1.yaml
kubectl apply -f rs2.yaml
kubectl apply -f service.yaml

replica_count_v1=`kubectl get rs my-app-v1 -o json | jq '.status.readyReplicas'`
while [ $replica_count_v1 != 5 ] 
    do
        echo "Ready replicas of Version 1 :    $replica_count_v1"
        sleep 1s
        replica_count_v1=`kubectl get rs my-app-v1 -o json | jq '.status.readyReplicas'`
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
    scaleReplicas 
;;
n)
    exit;
;;
*)
    echo "Invalid option select y to yes and n to exit"
;;
esac