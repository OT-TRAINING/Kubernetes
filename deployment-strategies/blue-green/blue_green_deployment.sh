#!/bin/bash


echo "performing initial deployment"
./deploy-green.sh


replica_count=`kubectl get rs my-app-v1 -o json | jq '.status.readyReplicas'`
while [ $replica_count != 5 ] 
    do
        echo "Ready replicas of Version 1 :    $replica_count"
        sleep 1s
        replica_count=`kubectl get rs my-app-v1 -o json | jq '.status.readyReplicas'`
    done 

echo "checking if v1/green is working as expected"
service=$(minikube service my-app-green --url)
version=$(curl "$service")
echo "Current ReplicaSet host and version -------- $version"

echo "deploying v2 i.e. blue"
./deploy-blue.sh
echo "checking if v2 i.e. blue is working as expected"
service=$(minikube service my-app-blue --url)
version=$(curl "$service")
echo "Current ReplicaSet host and version -------- $version"

echo "if blue i.e. v2 is working fine then we can shift traffic to v2"
echo -n " Do you want to start the deployment? yes(y) or no(n) -->  "
read option
case $option in
y)
    ./chnangeservice.sh
;;
n)
    exit;
;;
*)
    echo "Invalid option select y to yes and n to exit"
;;
esac

echo " if in case we found there is any issue with my-app-v2 we can easily roll back to v1"
echo -n " Do you want to rollback? yes(y) or no(n) -->  "
read option
case $option in
y)
    ./rollbacksh
;;
n)
    exit;
;;
*)
    echo "Invalid option select y to yes and n to exit"
;;
esac