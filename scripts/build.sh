#!/bin/bash

set -euox pipefail

cd FFmpeg
sed -i 's,tempnam,NULL; //tempnam,g' ./libavutil/file_open.c
../build/compile.sh
cp ffmpeg ../ffmpeg.wasm
cp ffprobe ../ffprobe.wasm
git rev-parse --is-inside-work-tree && git reset --hard
cd ..
