#!/bin/bash

helm uninstall task2-kafka
kubectl get pvc -o name \
	| grep 'task2-kafka' \
	| while read pvc ; do
		kubectl delete "$pvc"
	done
