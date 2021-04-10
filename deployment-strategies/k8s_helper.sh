function getReplicaCount() {
    RS_NAME=$1
    kubectl get rs ${RS_NAME} -o json | jq '.status.readyReplicas'
}

function apply_manifest() {
    MANIFEST_FILE=$1
    kubectl apply -f ${MANIFEST_FILE}
}

function setReplicaForRS() {
    RS_NAME=$1
    RS_DESIRED_COUNT=$2
    kubectl scale rs --replicas="${RS_DESIRED_COUNT}" ${RS_NAME}
}

function deleteManifest() {
    MANIFEST_FILE=$1
    kubectl delete -f ${MANIFEST_FILE}
}

function replicaSetStatus() {
    echo "Status of replicasets"
    kubectl get rs
}

function waitForRS() {
    RS_NAME=$1
    RS_DESIRED_COUNT=$2

    replica_count=`getReplicaCount ${RS_NAME}`
    if [ ${RS_DESIRED_COUNT} = "0" ]
    then
        #Just handling a boundary 
        return
    fi
    while [ $replica_count != ${RS_DESIRED_COUNT} ] 
    do
        echo "Reday replicas of ${RS_NAME}:$replica_count"
        echo "Wating to reach to ${RS_DESIRED_COUNT}"
        sleep 1s
        replica_count=`getReplicaCount ${RS_NAME}`
    done 
}