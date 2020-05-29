#!/bin/bash

# This is it was configured for mysql from helm
# host="task3-mysql.default.svc.cluster.local"
# port="$( kubectl get svc task3-mysql -o jsonpath='{.spec.ports[?(@.name=="mysql")].port}' )"
# db_name="my_database"
# export MYSQL_USERS_MYSQL_URL="jdbc:mysql://${host}:${port}/${db_name}?useSSL=false"
# export MYSQL_USERS_MYSQL_PASSWORD="$(kubectl get secret --namespace default task3-mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode)"

export MYSQL_USERS_MYSQL_URL="jdbc:mysql://mysql.default.svc.cluster.local:3306/test?useSSL=false"
export MYSQL_USERS_MYSQL_PASSWORD="HelloWorld"
export MYSQL_USERS_MYSQL_USERNAME="root"

test -e docker-mysql-spring-boot-example || git clone https://github.com/TechPrimers/docker-mysql-spring-boot-example
sha1="$( cd docker-mysql-spring-boot-example ; git rev-parse HEAD )"
cp edit_config.sh docker-mysql-spring-boot-example/
docker build \
	--build-arg MYSQL_USERS_MYSQL_URL \
	--build-arg MYSQL_USERS_MYSQL_USERNAME \
	--build-arg MYSQL_USERS_MYSQL_PASSWORD \
	-t "localhost:5000/mysql-users:${sha1}" \
	-t "localhost:5000/mysql-users:latest" \
	-t "localhost:5000/mysql-users:v1" \
	-f ./Dockerfile \
	./docker-mysql-spring-boot-example

docker start registry
docker push "localhost:5000/mysql-users:${sha1}"
docker push "localhost:5000/mysql-users:v1"
docker push "localhost:5000/mysql-users:latest"

