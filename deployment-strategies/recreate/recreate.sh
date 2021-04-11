#!/bin/bash
source ../k8s_helper.sh

function startDeployment() {
    apply_manifest ../rs1.yaml
    waitForRS my-app-v1 5
    apply_manifest ../service.yaml
    replicaSetStatus
}

function recreateDeployment() {
    setReplicaForRS my-app-v1 0
    apply_manifest ../rs2.yaml
    setReplicaForRS my-app-v2 5
    waitForRS my-app-v2 5
    replicaSetStatus
}

function rollback() {
    setReplicaForRS my-app-v2 0
    setReplicaForRS my-app-v1 5
    waitForRS my-app-v1 5
    replicaSetStatus
}

function cleanUp() {
    deleteManifest ../rs1.yaml
    deleteManifest ../rs2.yaml
    deleteManifest ../service.yaml
    replicaSetStatus
}