#!/bin/bash

declare -r env=${1:?"$(echo "FATAL Give an ENV")"}
declare -r app_host_port=${2:?"$(echo "FATAL You must pass the port to be exposed on the host for accessing the container")"}
declare -r app_container_port=${2:?"$(echo "FATAL You must pass the port that the application will start on inside the container")"}
declare -r docker_container_name="hello"
declare -r docker_image_tag="${docker_container_name}_${env}"
declare -r app_healthcheck_url="http://localhost:$app_host_port"

# Build Source!
echo "INFO Clean build kotlin source for environment."

./gradlew clean build shadowJar

# Dockerize!
echo "INFO Dockerise the source on top of the latest-greatest openjdk11 alpine-slim base image."
docker pull "adoptopenjdk/openjdk11:alpine-slim" #???

docker build -f ./Dockerfile ./ -t "$docker_image_tag"

echo "INFO Start container named $docker_container_name from the image tagged $docker_image_tag."
docker run --name "$docker_container_name"  -d -i -p $app_host_port:$app_container_port -t $docker_image_tag:latest

echo "INFO Wait a few seconds for health check to succeed."
for backoff_sec in 1 2 3 4 5 2 3; do
    sleep $backoff_sec
    if [[ "$(curl -s $app_healthcheck_url)" != "Hello, world!" ]]
    then echo "INFO Waited for ${backoff_sec} sec before running health check."
    else echo "INFO Health check succeeded."
         break
    fi
done

echo "INFO Display $docker_container_name docker container process status."
docker container ps --filter "name=$docker_container_name"

echo "INFO Spit out last few log lines to indicate what's happened."
docker logs "$docker_container_name" | tail
