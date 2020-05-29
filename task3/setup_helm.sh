#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
# The app seems to be incompatible with mysql <= 8
# So last chart would be: https://hub.helm.sh/charts/bitnami/mysql/4.5.2
# But it doesn't seem to be available, so I will deploy mysql from scratch
helm install task3-mysql bitnami/mysql:4.5.2

echo "Waiting for mysql to enter running phase"
while ! test "$( kubectl get pod/task3-mysql-master-0 -o jsonpath='{.status.phase}' )" = "Running" ; do
	echo -n "."
	sleep 5
done
echo ; echo "Done"

