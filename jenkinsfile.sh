#!/bin/bash
echo "Pipeline is running"
./gradlew test
./gradlew assemble
IMAGE_NAME="${DOCKER_HUB_USER_NAME}/my-app:${BUILD_NUMBER}"
docker build -t $IMAGE_NAME .
docker login -u "${DOCKER_HUB_USER_NAME}" -p "${DOCKER_HUB_USER_PASSWORD}"
docker push $IMAGE_NAME
