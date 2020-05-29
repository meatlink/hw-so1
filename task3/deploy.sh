#!/bin/bash

kubectl apply -f mysql-users.yaml
port="$( kubectl get svc mysql-users -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}' )"
echo "curl localhost:${port}"

