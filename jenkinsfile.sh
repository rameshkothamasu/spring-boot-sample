#!/bin/bash
echo "Pipeline is running"
./gradlew test
./gradlew assemble
./gradlew assemble docker dockerRun
