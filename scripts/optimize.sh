#!/bin/bash

set -euo pipefail

wasm-opt -O3 -o ffmpeg.wasm ffmpeg.wasm
wasm-opt -O3 -o ffprobe.wasm ffprobe.wasm
