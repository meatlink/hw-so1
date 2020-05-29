FROM maven:3-openjdk-8 as builder

ARG MYSQL_USERS_MYSQL_URL
ARG MYSQL_USERS_MYSQL_USERNAME
ARG MYSQL_USERS_MYSQL_PASSWORD

COPY pom.xml /opt/build/
COPY edit_config.sh /opt/build/
COPY src/ /opt/build/src/

WORKDIR /opt/build

RUN ./edit_config.sh
RUN cat src/main/resources/application.properties
RUN mvn test
RUN mvn package

FROM openjdk:8
COPY --from=builder /opt/build/target/users-mysql.jar users-mysql.jar
EXPOSE 8086
ENTRYPOINT ["java", "-jar", "users-mysql.jar"]
