#!/bin/bash
set -ex

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
PATH=`pwd`/depot_tools:"$PATH"

gclient sync
