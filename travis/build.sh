#!/bin/bash
set -ex

PATH=`pwd`/depot_tools:"$PATH"
cd src
./sky/tools/gn --release
ninja -C out/Release sky_snapshot

GIT_REVISION=`git rev-parse HEAD`
$HOME/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file ../gcloud_key_file.json
$HOME/google-cloud-sdk/bin/gsutil cp out/Release/sky_snapshot gs://mojo_infra/flutter/darwin-x64/$GIT_REVISION/sky_snapshot
