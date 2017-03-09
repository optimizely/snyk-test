#!/bin/sh

tag="${DOCKER_TAG:-snyk-test}"
docker build -t "$tag" .
docker run "$tag" $@
