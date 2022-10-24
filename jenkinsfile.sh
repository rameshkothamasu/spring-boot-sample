#!/bin/bash
echo "Pipeline is running"
./gradlew test
./gradlew build
./gradlew assemble
IMAGE_NAME="${DOCKER_HUB_USER_NAME}/my-app:${BUILD_NUMBER}"
docker build -t $IMAGE_NAME . --build-arg JAR_FILE=./build/libs/spring-boot-api-example-0.1.0-SNAPSHOT.jar
docker login -u "${DOCKER_HUB_USER_NAME}" -p "${DOCKER_HUB_USER_PASSWORD}"
docker push $IMAGE_NAME
helm package --destination . helm/springbootsample
helm upgrade --install --wait --set image.repository=$DOCKER_HUB_USER_NAME --set image.tag=$BUILD_NUMBER --set --namespace=springbootapp --create-namespace springbootapp ./springbootsample-1.0.0.tgz
