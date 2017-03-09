#!/bin/sh

BUILD_TAG="build"
DOCKER_TAG="${DOCKER_TAG:-snyk-test}"
docker build -t "$BUILD_TAG" .

# Flatten
if [ "$FLATTEN" = "true" ]; then
  # "Flatten" the docker image using export | import
  # This has the effect of copying the filesystem (but not the layers or config) from build to $DOCKER_TAG.
  # Use the --change option to import to "re-apply" the relevant "runtime" commands to the new image.

  # Run the container first (to export). We assume that the default run command is ok to do in this context.
  CONTAINER_ID=$(docker run -d $BUILD_TAG)
  # h/t @mh for this code
  #
  # Annotated:
  #
  # eval \ # Interpolate the "grep" results literally
  #   docker import \ # Run docker import
  #   $(grep -E '^ENV|^WORKDIR|^EXPOSE|^CMD' Dockerfile | tr "\n" "\0" | xargs -0 -n1 -IZ echo --change="'Z'") \ # with runtime change flags
  #   - \ # From stdin
  #   $DOCKER_TAG # To $DOCKER_TAG
  docker export $CONTAINER_ID \
   | eval docker import \
     $(grep -E '^ENV|^WORKDIR|^EXPOSE|^CMD' Dockerfile | tr "\n" "\0" | xargs -0 -n1 -IZ echo --change="'Z'") \
     - \
     $DOCKER_TAG

  # clean up (kill and delete)
  docker rm -f $CONTAINER_ID
else
  # Just "alias" $DOCKER_TAG to build
  docker tag $BUILD_TAG "${DOCKER_TAG}"
fi

# clean up intermediate image
docker rmi $BUILD_TAG

docker run "$DOCKER_TAG" $@
