#!/bin/bash
KUBE_VERSION=v1.11.2
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.2.18
DNS_VERSION=1.14.8
FLANNEL_VERSION=v0.10.0-amd64
username=chengzhihui007
images=(kube-apiserver-amd64:${KUBE_VERSION}
kube-scheduler-amd64:${KUBE_VERSION}
kube-controller-manager-amd64:${KUBE_VERSION}
kube-proxy-amd64:${KUBE_VERSION}
etcd-amd64:${ETCD_VERSION}
k8s-dns-dnsmasq-nanny-amd64:${DNS_VERSION}
k8s-dns-sidecar-amd64:${DNS_VERSION}
k8s-dns-kube-dns-amd64:${DNS_VERSION}
pause-amd64:${KUBE_PAUSE_VERSION}
pause:${KUBE_PAUSE_VERSION}
coredns:1.1.3
coreos-flannel:${FLANNEL_VERSION})
for image in ${images[@]}
do
    if [ "${image}" == "coreos-flannel:${FLANNEL_VERSION}" ];
	then
	docker pull ${username}/${image}
	docker tag ${username}/${image} quay.io/coreos/flannel:${FLANNEL_VERSION}
	docker rmi ${username}/${image}
	else
	docker pull ${username}/${image}
    docker tag ${username}/${image} k8s.gcr.io/${image}
    #docker tag ${username}/${image} gcr.io/google_containers/${image}
    docker rmi ${username}/${image}
	fi
done
