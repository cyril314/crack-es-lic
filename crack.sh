#!/bin/bash
if  [ ! "$1" ] ;then
    echo "You have not entered a version"
    exit
fi
version=$1
echo -e "\033[36mRun for version: ${version}\033[0m"
mkdir output
service_name="elastic-crack"

docker build --no-cache -f Dockerfile --build-arg VERSION="${version}" --tag ${service_name}:${version} .

docker run -it --rm -v $(pwd)/output:/crack/output docker.io/library/${service_name}:${version}
