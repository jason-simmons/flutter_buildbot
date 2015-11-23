#!/bin/bash
set -e

echo $KEY_FILE | base64 --decode > gcloud_key_file.json

set -x

if [ $TRAVIS_OS_NAME = "osx" ] && [ $BUILD_TARGET = "device" ]; then
  mkdir src
  # We don't yet build an iOS artifacts from this repository.
  exit 0
fi

export CLOUDSDK_CORE_DISABLE_PROMPTS=1
curl https://sdk.cloud.google.com | bash

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
PATH=`pwd`/depot_tools:"$PATH"
gclient help

GIT_REVISION=`cat REVISION`
git clone https://github.com/flutter/engine.git src
cd src
git checkout $GIT_REVISION
gclient sync

if [ $BUILD_TARGET = "device" ]; then
  sudo dpkg --print-foreign-architectures
  sudo dpkg --add-architecture i386
  sudo apt-get update
  sudo apt-get install -y ant openjdk-7-jdk openjdk-7-jre \
      libncurses5:i386 libstdc++6:i386 libgcc1:i386 zlib1g:i386

  ./tools/android/download_android_tools.py

  # Remove unused toolchains to save space inside the VM.
  rm -rf third_party/android_tools/ndk/toolchains/mips*
  rm -rf third_party/android_tools/ndk/toolchains/aarch64*
  rm -rf third_party/android_tools/ndk/toolchains/x86*
fi
