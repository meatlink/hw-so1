#!/bin/bash
set -e ; set -u

n="$1"

source trigger.config

for i in $( seq "$n" ) ; do
	curl \
		-X POST \
		"${HOST}:${PORT}/${IDX}/_doc/?pretty" \
		-H 'Content-Type: application/json' \
		-d"{\"text\": \"random string ${RANDOM}\"}"
done
