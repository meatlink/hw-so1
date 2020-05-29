#!/bin/bash
set -e ; set -u

source trigger.config

main () {
	local count
	count="$( request_elastic | extract_count )"
	if test "$count" -ge "$THRESHOLD" ; then
		echo "Trigger!"
	else
		echo "No trigger."
	fi
}
request_elastic () {
	curl \
		-s \
		-X GET \
		"${HOST}:${PORT}/${IDX}/_search?pretty" \
		-H 'Content-Type: application/json' \
		-d "{\"query\": {\"match\": {\"text\": \"${INTERESTING_TEXT}\"}}}"
}

extract_count () {
	ensure_jq_installed
	jq '.hits.total.value'
}

ensure_jq_installed () {
	if ! is_jq_installed ; then
		install_jq >/dev/null 2>&1
	fi
}

is_jq_installed () {
	jq > /dev/null 2>&1
}

install_jq () {
	apt update
	apt install -y jq
}

main
