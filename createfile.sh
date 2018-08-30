#!/bin/bash
filepath=$(pwd)
#versions
KUBE_VERSION=v1.11.2
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.2.18
DNS_VERSION=1.14.8

#url
k8s=k8s.gcr.io

kubedirs=(kube-apiserver-amd64 
kube-scheduler-amd64 
kube-controller-manager-amd64 
kube-proxy-amd64)

dnsdirs=(k8s-dns-dnsmasq-nanny-amd64 
k8s-dns-sidecar-amd64 
k8s-dns-kube-dns-amd64)

#create  kubedirs
for   fileDir in ${kubedirs[@]} ; do 
  cd $filepath
  mkdir -p $fileDir && cd $fileDir
  cat >Dockerfile<<EOF
FROM $k8s/$fileDir:$KUBE_VERSION
MAINTAINER  chengzhihui007
EOF
done

#create etcddir
cd $filepath
  mkdir -p etcd-amd64 && cd etcd-amd64
  cat >Dockerfile<<EOF
FROM $k8s/etcd-amd64:$ETCD_VERSION
MAINTAINER  chengzhihui007
EOF

#create  dnsdirs
for   dnsDir in ${dnsdirs[@]} ; do 
  cd $filepath
  mkdir -p $dnsDir && cd $dnsDir
  cat >Dockerfile<<EOF
FROM $k8s/$dnsDir:$DNS_VERSION
MAINTAINER  chengzhihui007
EOF
done

#create  pausedir
cd $filepath
  mkdir -p pause && cd pause
  cat >Dockerfile<<EOF
FROM $k8s/pause:$KUBE_PAUSE_VERSION
MAINTAINER  chengzhihui007
EOF


#create corednsdir
cd $filepath
  mkdir -p coredns && cd  coredns
  cat >Dockerfile<<EOF
FROM $k8s/coredns:1.1.3
MAINTAINER chengzhihui007
EOF 


#create  flanneldir
cd $filepath
  mkdir -p coreos/flannel && cd coreos/flannel
  cat >Dockerfile<<EOF
FROM quay.io/coreos/flannel:v0.10.0-amd64
MAINTAINER  chengzhihui007
EOF
