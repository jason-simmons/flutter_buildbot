#!/bin/bash
set -ex

echo $KEY_FILE > gcloud_key_file

CLOUDSDK_CORE_DISABLE_PROMPTS=1
curl https://sdk.cloud.google.com | bash

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
PATH=`pwd`/depot_tools:"$PATH"

gclient sync
