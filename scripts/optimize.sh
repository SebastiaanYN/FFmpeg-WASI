#!/bin/bash

set -euox pipefail

./binaryen/bin/wasm-opt -O3 -o ffmpeg.wasm ffmpeg.wasm
./binaryen/bin/wasm-opt -O3 -o ffprobe.wasm ffprobe.wasm
