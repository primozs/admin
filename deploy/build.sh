#!/bin/sh

echo "BUILD PROD IMAGE"
VERSION_ARG=$1
VERSION=${VERSION_ARG:="0.0.1"}

REGISTRY="registry.susa.cloud"

PACKAGE_VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]')

echo $PACKAGE_VERSION

VERSION_TAG="${REGISTRY}/stenar-admin:v${PACKAGE_VERSION}"
echo $VERSION_TAG

LATEST_TAG="${REGISTRY}/stenar-admin:latest"

docker build --file deploy/Dockerfile --target release -t $VERSION_TAG -t $LATEST_TAG .
