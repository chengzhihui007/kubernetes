#!/bin/bash
filepath=$(pwd)
newdirs=(kube-apiserver-amd64 kube-scheduler-amd64 kube-controller-manager-amd64 kube-proxy-amd64 etcd-amd64 
k8s-dns-dnsmasq-nanny-amd64 k8s-dns-sidecar-amd64 k8s-dns-kube-dns-amd64 pause-amd64 coreos/flannel)
for   dirName in ${newdirs[@]} ; do 
  cd $filepath
  mkdir -p $dirName && cd $dirName
  cat >Dockerfile<<EOF
FROM k8s.gcr.io/$dirName:v1.11.2
MAINTAINER  chengzhihui007
EOF
done
