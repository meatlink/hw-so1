#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install task2-kafka bitnami/kafka \
	--set replicaCount=3 \
	--set externalAccess.enabled=true \
	--set externalAccess.service.type=NodePort \
	--set externalAccess.autoDiscovery.enabled=true \
	--set serviceAccount.create=true \
	--set rbac.create=true \
	--set externalAccess.service.domain=localhost

if ! test -e kafka_2.12-2.5.0.tgz ; then
	wget https://mirror.synyx.de/apache/kafka/2.5.0/kafka_2.12-2.5.0.tgz
	tar xzf kafka_2.12-2.5.0.tgz
fi

port="$( kubectl get svc task2-kafka-0-external -o jsonpath='{.spec.ports[?(@.name=="tcp-kafka")].nodePort}' )"

cat > trigger.config <<-EOF
	BOOTSTRAP_SERVER="localhost:${port}"
	NUM_NODES="3"
	KAFKA_DIR="./kafka_2.12-2.5.0"
EOF

echo "Waiting for things to start"

while ! nc -z localhost "$port" ; do
	echo -n "."
	sleep 5
done
echo ; echo "Done"
