#!/bin/bash
set -ex

PATH=`pwd`/depot_tools:"$PATH"
cd src

GSUTIL=$HOME/google-cloud-sdk/bin/gsutil
GCLOUD=$HOME/google-cloud-sdk/bin/gcloud

GIT_REVISION=`git rev-parse HEAD`

# $GCLOUD auth activate-service-account --key-file ../gcloud_key_file.json

./sky/tools/gn --release --android
ninja -C out/android_Release apks/SkyShell.apk sky_viewer.mojo

# if [ $TRAVIS_OS_NAME = "linux" ]
# then
#   ninja -C out/Release
#   STORAGE_BASE_URL=gs://mojo_infra/flutter/linux-x64/$GIT_REVISION
#   # Is there some way to use gzip with files that lack extensions?
#   $GSUTIL cp out/Release/sky_snapshot $STORAGE_BASE_URL/sky_snapshot
#   $GSUTIL cp out/Release/sky_shell $STORAGE_BASE_URL/sky_shell
#   $GSUTIL cp -z dat out/Release/icudtl.dat $STORAGE_BASE_URL/icudtl.dat
#   $GSUTIL cp -z mojo out/Release/sky_viewer.mojo $STORAGE_BASE_URL/sky_viewer.mojo
# fi
#
# if [ $TRAVIS_OS_NAME = "osx" ]
# then
#   ninja -C out/Release sky_snapshot
#   STORAGE_BASE_URL=gs://mojo_infra/flutter/darwin-x64/$GIT_REVISION
#   $GSUTIL cp out/Release/sky_snapshot $STORAGE_BASE_URL/sky_snapshot
# fi
