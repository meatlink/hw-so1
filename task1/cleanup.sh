#!/bin/bash

helm uninstall task1-es
kubectl delete pvc elasticsearch-master-elasticsearch-master-0
