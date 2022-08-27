#!/bin/bash

set -euo pipefail

cd FFmpeg
cp ../patches/file_open.c ./libavutil/file_open.c
../build/compile.sh
cp ffmpeg ../ffmpeg.wasm
cp ffprobe ../ffprobe.wasm
git reset --hard
cd ..
