#!/bin/bash
echo "Pipeline is running"
./gradlew test
./gradlew assemble
docker build -t my-app .
