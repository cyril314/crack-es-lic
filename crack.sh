#!/bin/bash
if  [ ! "$1" ] ;then
    echo "You have not entered a version"
    exit
fi
version=$1
jdk_ver=$2
echo -e "\033[36mRun for version: ${version}\033[0m"
mkdir output
service_name="elastic-crack"
if [ -z "$jdk_ver" ];then
    if [[ "$(echo $version | cut -d'.' -f1)" -ge 8 ]]; then
      echo "Using JDK 17 for Elasticsearch version $version (>= 7.x)"
      jdk_ver="17"
    elif [[ "$(echo $version | cut -d'.' -f1)" -lt 7 ]]; then
      echo "Using JDK 8 for Elasticsearch version $version (< 7.x)"
      jdk_ver="8"
    else
      echo "Using JDK 11 for Elasticsearch version $version (<= 7.x)"
      jdk_ver="11"
    fi
else
    echo "Using JDK $jdk_ver for Elasticsearch version $version "
fi

docker build --no-cache -f Dockerfile --build-arg VERSION="${version}" --build-arg JDKVER="${jdk_ver}" --tag ${service_name}:${version} .

docker run --rm -v $(pwd)/output:/crack/output docker.io/library/${service_name}:${version}
