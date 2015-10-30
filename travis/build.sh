#!/bin/bash
set -ex

PATH=`pwd`/depot_tools:"$PATH"
cd src
#./sky/tools/gn --release
# ninja -C out/Release sky_snapshot

GIT_REVISION=`git rev-parse HEAD`
$HOME/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file ../gcloud_key_file.json
$HOME/google-cloud-sdk/bin/gsutil cp LICENSE gs://mojo_infra/travis-test/$GIT_REVISION/foo
