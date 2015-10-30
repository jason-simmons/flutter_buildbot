#!/bin/bash
set -ex

PATH=`pwd`/depot_tools:"$PATH"
cd src
./sky/tools/gn --release
ninja -C out/Release sky_snapshot
