#!/bin/bash

source trigger.config

main () {
	"${KAFKA_DIR}/bin/kafka-topics.sh" \
		--bootstrap-server="$BOOTSTRAP_SERVER" \
		--create \
		--topic "random${RANDOM}" \
		--replica-assignment '0:1,1:2,2:0'
}


main

