#!/bin/sh

docker build -t snyk-test .
docker run snyk-test
