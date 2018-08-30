#!/bin/bash
images=(kube-proxy-amd64:v1.11.2 kube-scheduler-amd64:v1.11.2 kube-controller-manager-amd64:v1.11.2 kube-apiserver-amd64:v1.11.2
etcd-amd64:3.1.12 pause-amd64:3.1 kubernetes-dashboard-amd64:v1.8.3 k8s-dns-sidecar-amd64:1.14.8 k8s-dns-kube-dns-amd64:1.14.8
k8s-dns-dnsmasq-nanny-amd64:1.14.8)
for image in ${images[@]} ; do
  docker pull chengzhihui007/$image
  docker tag chengzhihui007/$image gcr.io/google_containers/$image
  docker rmi chengzhihui007/$image
done
