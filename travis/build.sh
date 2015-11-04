#!/bin/bash
set -ex

if [ $TRAVIS_OS_NAME = "osx" ] && [ $BUILD_TARGET = "device" ]; then
  # We don't yet build an iOS artifacts from this repository.
  exit 0
fi

PATH=`pwd`/depot_tools:"$PATH"
cd src

GSUTIL=$HOME/google-cloud-sdk/bin/gsutil
GCLOUD=$HOME/google-cloud-sdk/bin/gcloud

GIT_REVISION=`git rev-parse HEAD`

# $GCLOUD auth activate-service-account --key-file ../gcloud_key_file.json

if [ $TRAVIS_OS_NAME = "linux" ]; then
  if [ $BUILD_TARGET = "device" ]; then
    ./sky/tools/gn --release --android
    ninja -C out/android_Release apks/SkyShell.apk sky_viewer.mojo
    # STORAGE_BASE_URL=gs://mojo_infra/flutter/android-arm/$GIT_REVISION
    # $GSUTIL cp out/android_Release/apks/SkyShell.apk $STORAGE_BASE_URL/SkyShell.apk
    # $GSUTIL cp -z mojo out/android_Release/sky_viewer.mojo $STORAGE_BASE_URL/sky_viewer.mojo
  fi

  if [ $BUILD_TARGET = "host" ]; then
    echo "****** OOPS(host) ******"
    # ninja -C out/Release

    # rm -rf out/Release/gen/dart-pkg/sky_engine/packages
    # (cd out/Release/gen/dart-pkg/sky_engine; tar -czhf ../../../../../sky_engine.tar.gz *)
    #
    # rm -rf out/Release/gen/dart-pkg/sky_services/packages
    # (cd out/Release/gen/dart-pkg/sky_services; tar -czhf ../../../../../sky_services.tar.gz *)

    # STORAGE_BASE_URL=gs://mojo_infra/flutter/linux-x64/$GIT_REVISION
    # # Is there some way to use gzip with files that lack extensions?
    # $GSUTIL cp out/Release/sky_snapshot $STORAGE_BASE_URL/sky_snapshot
    # $GSUTIL cp out/Release/sky_shell $STORAGE_BASE_URL/sky_shell
    # $GSUTIL cp -z dat out/Release/icudtl.dat $STORAGE_BASE_URL/icudtl.dat
    # $GSUTIL cp -z mojo out/Release/sky_viewer.mojo $STORAGE_BASE_URL/sky_viewer.mojo

    # STORAGE_DART_BASE_URL=gs://mojo_infra/flutter/dart/$GIT_REVISION
    # $GSUTIL cp sky_engine.tar.gz $STORAGE_DART_BASE_URL/sky_engine.tar.gz
    # $GSUTIL cp sky_services.tar.gz $STORAGE_DART_BASE_URL/sky_services.tar.gz
  fi
fi

if [ $TRAVIS_OS_NAME = "osx" ]; then
  echo "****** OOPS(osx) ******"
# ninja -C out/Release sky_snapshot
# STORAGE_BASE_URL=gs://mojo_infra/flutter/darwin-x64/$GIT_REVISION
# $GSUTIL cp out/Release/sky_snapshot $STORAGE_BASE_URL/sky_snapshot
fi
