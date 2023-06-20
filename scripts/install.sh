#!/bin/bash

set -euox pipefail

WASI_VERSION=20
WASI_VERSION_FULL=${WASI_VERSION}.0
wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz
tar xvf wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz
rm wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz
mv wasi-sdk-${WASI_VERSION_FULL} wasi-sdk

BINARYEN_VERSION=113
wget https://github.com/WebAssembly/binaryen/releases/download/version_${BINARYEN_VERSION}/binaryen-version_${BINARYEN_VERSION}-x86_64-linux.tar.gz
tar xvf binaryen-version_${BINARYEN_VERSION}-x86_64-linux.tar.gz
rm binaryen-version_${BINARYEN_VERSION}-x86_64-linux.tar.gz
mv binaryen-version_${BINARYEN_VERSION} binaryen
