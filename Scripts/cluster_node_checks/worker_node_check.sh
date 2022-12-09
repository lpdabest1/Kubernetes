#!/bin/bash

printf "Versions: \n"
sleep 1

printf "Kubelet Version: $(kubelet --version) \n"
sleep 1

printf "Kubectl Version: \n"
printf "$(kubectl version --short --client=true) \n"
sleep 1

printf "Kubeadm Version: $(kubeadm version --output short) \n"
sleep 1
