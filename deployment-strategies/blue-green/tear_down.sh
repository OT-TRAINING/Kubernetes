#!/bin/bash

teardown (){

kubectl delete -f rs1.yaml -f rs2.yaml
kubectl delete -f service-green.yaml -f service-blue.yaml
}
teardown
