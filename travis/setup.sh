#!/bin/bash
set -e

echo $KEY_FILE | base64 --decode > gcloud_key_file.json

set -x

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
