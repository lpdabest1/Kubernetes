#!/bin/bash

# Install Kubernetes Components needed
# Kubelet, Kubectl, Kubeadm

# Update the apt package index and install packages needed to use the Kubernetes apt repo:
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add the Kubernetes apt repo:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Install Kubelet, Kubectl, Kubeadm
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


# Create a local cluster
# Note: for this specific creation of a local cluster, you should be under superuser permissions (root)

sudo su -

# Generate a cluster config
CLUSTER_NAME=dev-cluster
eksctl anywhere generate clusterconfig $CLUSTER_NAME \
   --provider docker > $CLUSTER_NAME.yaml


# Create Cluster
eksctl anywhere create cluster -f $CLUSTER_NAME.yaml

# Use the Cluster
export KUBECONFIG=${PWD}/${CLUSTER_NAME}/${CLUSTER_NAME}-eks-a-cluster.kubeconfig
kubectl get ns

