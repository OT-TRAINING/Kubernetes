scaleReplicas(){
    replica_count_current_v1=`kubectl get rs my-app-v1 -o json | jq '.status.readyReplicas'`
    replica_count_current_v2=0
    echo $replica_count_current_v1
    echo $replica_count_current_v2
    while [[ $replica_count_current_v1 != 'null' && $replica_count_current_v2 != 5 ]]
        do
            ##V1
            replica_count_desired_v1=$((replica_count_current_v1-1))
            echo $replica_count_desired_v1
            kubectl scale rs --replicas="$replica_count_desired_v1" my-app-v1
            sleep 1s
            replica_count_current_v1="$replica_count_desired_v1"

            ## V2
            replica_count_desired_v2=$((replica_count_current_v2+1))
            kubectl scale rs --replicas="$replica_count_desired_v2" my-app-v2
            sleep 1s
            replica_count_current_v2=`kubectl get rs my-app-v2 -o json | jq '.status.readyReplicas'`
            while [ $replica_count_current_v2 != $replica_count_desired_v2 ] 
                do
                    echo "Ready replicas of Version 2 :    $replica_count_current_v2"
                    sleep 1s
                    replica_count_current_v2=`kubectl get rs my-app-v2 -o json | jq '.status.readyReplicas'`
                done
        done
    echo "Scaling of replicaset v1 to v2 completed"    
    service=$(minikube service my-app --url)
    version=$(curl "$service")
    echo "Current ReplicaSet host and version -------- $version"
}