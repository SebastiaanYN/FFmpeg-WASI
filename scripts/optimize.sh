#!/bin/bash

set -euo pipefail

wasm-opt -Oz -o ffmpeg.wasm ffmpeg.wasm
wasm-opt -Oz -o ffprobe.wasm ffprobe.wasm
