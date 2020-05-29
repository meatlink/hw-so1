#!/bin/bash
set -e ; set -u

if ! kubectl > /dev/null 2>&1 ; then
	curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
	chmod +x ./kubectl
	mv ./kubectl /usr/local/bin/
fi

if ! docker > /dev/null 2>&1 ; then
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
fi

if ! minikube > /dev/null 2>&1 ; then
	apt update
	apt install -y conntrack
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x minikube
	mv ./minikube /usr/local/bin/
	minikube --driver=none start
fi

if ! helm > /dev/null 2>&1 ; then
	curl -Lo helm.tar.gz https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
	tar -zxvf helm.tar.gz
	mv linux-amd64/helm /usr/local/bin 
	helm repo add stable https://kubernetes-charts.storage.googleapis.com/
fi

apt update
apt install -y openjdk-8-jre

docker run -d -p 5000:5000 --name registry registry:2
