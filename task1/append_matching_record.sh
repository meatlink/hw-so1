#!/bin/bash
set -e ; set -u

source trigger.config

curl \
	-X POST \
	"${HOST}:${PORT}/${IDX}/_doc/?pretty" \
	-H 'Content-Type: application/json' \
	-d"{\"text\": \"random string ${RANDOM} Handbill not printed ${RANDOM}\"}"
