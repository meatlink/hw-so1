#!/bin/bash

source trigger.config

main () {
	local replication_factors
	replication_factors="$( get_topics_description | filter_replication_factor )"
	find_underreplicated_and_trigger
	echo "No trigger."
}

get_topics_description () {
	"${KAFKA_DIR}/bin/kafka-topics.sh" \
		--bootstrap-server="$BOOTSTRAP_SERVER" \
		--describe
}

filter_replication_factor () {
	grep -o 'ReplicationFactor:[[:space:]]\+[[:digit:]]\+' \
		| grep -o '[[:digit:]]\+' \
		| tr '\n' ' '
}

find_underreplicated_and_trigger () {
	for replication_factor in $replication_factors ; do
		if is_underreplicated ; then
			echo "Trigger!"
			exit
		fi
	done
}

is_underreplicated () {
	test "$replication_factor" -lt "$NUM_NODES"
}



main

