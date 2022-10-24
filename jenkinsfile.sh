#!/bin/bash
echo "Pipeline is running"
./gradlew test
./gradlew build
./gradlew assemble
IMAGE_NAME="${DOCKER_HUB_USER_NAME}/my-app:${BUILD_NUMBER}"
docker build -t $IMAGE_NAME . --build-arg JAR_FILE=./build/libs/spring-boot-api-example-0.1.0-SNAPSHOT.jar
docker login -u "${DOCKER_HUB_USER_NAME}" -p "${DOCKER_HUB_USER_PASSWORD}"
docker push $IMAGE_NAME
