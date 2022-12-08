#!bin/bash

printf "Nodes Status:\n $(kubectl get nodes)\n\n"
sleep 2

printf "Pods Status:\n $(kubectl get pods -A)\n\n"
sleep 2

printf "Versions: \n"
sleep 1

printf "Kubelet Version: $(kubelet --version) \n"
sleep 1

printf "Kubectl Version: \n"
printf "$(kubectl version --short) \n"
sleep 1

printf "Kubeadm Version: $(kubeadm version --output short) \n"
sleep 1
