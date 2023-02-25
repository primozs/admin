#!/bin/sh

echo "BUILD PROD IMAGE"
VERSION_ARG=$1

REGISTRY="registry.susa.cloud"

PACKAGE_VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]')

VERSION=${VERSION_ARG:=$PACKAGE_VERSION}
echo $VERSION

VERSION_TAG="${REGISTRY}/stenar-admin:v${VERSION}"
echo $VERSION_TAG

LATEST_TAG="${REGISTRY}/stenar-admin:latest"

docker build --file deploy/Dockerfile --target release -t $VERSION_TAG -t $LATEST_TAG .
