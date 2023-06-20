#!/bin/bash

set -euox pipefail

cd deps/zlib
CC=../../wasi-sdk/bin/clang \
    AR=../../wasi-sdk/bin/ar \
    RANLIB=../../wasi-sdk/bin/ranlib \
    prefix=../../build \
    CFLAGS="-msimd128" \
    ./configure --static
make install
git rev-parse --is-inside-work-tree && git reset --hard
cd ../..
