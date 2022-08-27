#!/bin/bash

set -euo pipefail

cd deps/zlib
CC=../../wasi-sdk/bin/clang \
    AR=../../wasi-sdk/bin/ar \
    RANLIB=../../wasi-sdk/bin/ranlib \
    prefix=../../build \
    ./configure --static
make install
git reset --hard
cd ../..
