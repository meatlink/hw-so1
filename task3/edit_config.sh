#!/bin/bash
set -e ; set -u

FILENAME="src/main/resources/application.properties"

main () {
	replace "spring.datasource.url" "$MYSQL_USERS_MYSQL_URL"
	replace "spring.datasource.username" "$MYSQL_USERS_MYSQL_USERNAME"
	replace "spring.datasource.password" "$MYSQL_USERS_MYSQL_PASSWORD"
}

replace () {
	local param value ; param="$1" ; value="$2"
	param="$( echo "$param" | quote_dot )"
	value="$( echo "$value" | quote_slash )"
	sed "s/\(^[[:space:]]*${param}[[:space:]]*=[[:space:]]*\).*\$/\1${value}/" \
		-i "$FILENAME"
}

quote_slash () {
	sed 's/\//\\\//g'
}

quote_dot () {
	sed 's/\./\\./g'
}

main
