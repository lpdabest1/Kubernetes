#!/bin/bash

# Create a local cluster

# Generate a cluster config
CLUSTER_NAME=dev-cluster
eksctl anywhere generate clusterconfig $CLUSTER_NAME \
   --provider docker > $CLUSTER_NAME.yaml


# Create Cluster
eksctl anywhere create cluster -f $CLUSTER_NAME.yaml

# Use the Cluster
export KUBECONFIG=${PWD}/${CLUSTER_NAME}/${CLUSTER_NAME}-eks-a-cluster.kubeconfig
kubectl get ns

