#!/bin/bash

source ../k8s_helper.sh

function startDeployment() {
    apply_manifest ../rs1.yaml
    apply_manifest ../rs2.yaml
    waitForRS my-app-v1 5
    apply_manifest ../service.yaml
    replicaSetStatus
}

function recreateDeployment() {
    rs1_replica_count=5
    rs2_replica_count=0
    while [[ $rs2_replica_count != "5" ]]
    do
        rs1_replica_count=$((rs1_replica_count-1))
        rs2_replica_count=$((rs2_replica_count+1))

        setReplicaForRS my-app-v1 ${rs1_replica_count}
        setReplicaForRS my-app-v2 ${rs2_replica_count}
        waitForRS my-app-v2 ${rs2_replica_count}            
        replicaSetStatus
    done
}

function rollback() {
    rs1_replica_count=0
    rs2_replica_count=5
    while [[ $rs1_replica_count != "5" ]]
    do
        rs1_replica_count=$((rs1_replica_count+1))
        rs2_replica_count=$((rs2_replica_count-1))

        setReplicaForRS my-app-v1 ${rs1_replica_count}
        setReplicaForRS my-app-v2 ${rs2_replica_count}
        waitForRS my-app-v2 ${rs2_replica_count}            
        replicaSetStatus
    done
}

function cleanUp() {
    deleteManifest ../rs1.yaml
    deleteManifest ../rs2.yaml
    deleteManifest ../service.yaml
    replicaSetStatus
}
