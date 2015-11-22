#!/bin/bash
set -ex

PATH=`pwd`/depot_tools:"$PATH"
cd src

GSUTIL=$HOME/google-cloud-sdk/bin/gsutil
GCLOUD=$HOME/google-cloud-sdk/bin/gcloud

GIT_REVISION=`git rev-parse HEAD`

$GCLOUD auth activate-service-account --key-file ../gcloud_key_file.json

./sky/tools/gn --release

if [ $TRAVIS_OS_NAME = "linux" ]
then
  ninja -C out/Release
  STORAGE_BASE_URL=gs://mojo_infra/flutter/$GIT_REVISION/linux-x64
  zip -j /tmp/artifacts.zip out/Release/icudtl.dat out/Release/sky_shell out/Release/sky_snapshot out/Release/flutter.mojo
  $GSUTIL cp /tmp/artifacts.zip $STORAGE_BASE_URL/artifacts.zip
fi

if [ $TRAVIS_OS_NAME = "osx" ]
then
  ninja -C out/Release sky_snapshot
  STORAGE_BASE_URL=gs://mojo_infra/flutter/$GIT_REVISION/darwin-x64
  zip -j /tmp/artifacts.zip out/Release/sky_snapshot
  $GSUTIL cp /tmp/artifacts.zip $STORAGE_BASE_URL/artifacts.zip
fi
