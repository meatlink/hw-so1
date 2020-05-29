#!/bin/bash

helm repo add elastic https://helm.elastic.co
helm repo update
helm install task1-es elastic/elasticsearch --set replicas=1 --set service.type=NodePort
port="$( kubectl get svc elasticsearch-master -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}' )"
echo "port: ${port}"

echo "Generating trigger config"
cat > trigger.config <<-EOF
	HOST="localhost"
	PORT="$port"
	IDX="poc"
	INTERESTING_TEXT="Handbill not printed"
	THRESHOLD="3"
EOF

echo "Waiting for elastic to become available"
while ! curl -m 5 "localhost:${port}" > /dev/null 2>&1 ; do
	echo -n '.'
	sleep 5
done
echo ; echo "Done"


