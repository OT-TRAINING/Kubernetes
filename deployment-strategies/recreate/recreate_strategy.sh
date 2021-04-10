#!/bin/bash

scaleReplicas(){
    kubectl scale rs --replicas="$1" my-app
    # jq needs to be installed through sudo apt install jq
    replica_count=`kubectl get rs my-app -o json | jq '.status.readyReplicas'`
    while [ $replica_count != 'null' ] 
        do
            sleep 1s
            replica_count=`kubectl get rs my-app -o json | jq '.status.readyReplicas'`
        done
    
    kubectl apply -f rs2.yaml

    replica_count=`kubectl get rs my-app -o json | jq '.status.readyReplicas'`
    while [ $replica_count != 5 ] 
        do
            echo "Ready Replicas of Version 2 :   $replica_count"
            sleep 1s
            replica_count=`kubectl get rs my-app -o json | jq '.status.readyReplicas'`
        done

    echo "Scaling of replicaset v1 to v2 completed"    
    service=$(minikube service my-app --url)
    version=$(curl "$service")
    echo "Current ReplicaSet host and version -------- $version"
}