#!/bin/bash

set -euox pipefail

FFMPEG_CONFIG_FLAGS_BASE=(
  --target-os=none        # use none to prevent any os specific configurations
  --arch=x86_32           # use x86_32 to achieve minimal architectural optimization
  --enable-cross-compile  # enable cross compile
  --disable-x86asm        # disable x86 asm
  --disable-inline-asm    # disable inline asm
  --disable-stripping     # disable stripping
  --disable-doc           # disable doc
  --disable-debug         # disable debug info, required by closure
  --disable-runtime-cpudetect   # disable runtime cpu detect
  --disable-autodetect    # disable external libraries auto detect
  --disable-network       # https://github.com/WebAssembly/wasi-sdk/issues/112
  --disable-pthreads
  --disable-w32threads
  --disable-os2threads
  --pkg-config-flags="--static"
  --enable-lto            # use link-time optimization

  --nm=../wasi-sdk/bin/nm
  --ar=../wasi-sdk/bin/ar
  --ranlib=../wasi-sdk/bin/ranlib
  --cc=../wasi-sdk/bin/clang
  --cxx=../wasi-sdk/bin/clang++
  --objcc=../wasi-sdk/bin/clang
  --dep-cc=../wasi-sdk/bin/clang

  --enable-gpl
  --enable-libx264
  --enable-zlib

  --extra-cflags="-I../build/include"
  --extra-ldflags="-L../build/lib"
)

mkdir -p build

cd FFmpeg
./configure ${FFMPEG_CONFIG_FLAGS_BASE[@]}

make -n |
  # Add cflags that ./configure does not accept
  sed 's/clang /clang -D_WASI_EMULATED_PROCESS_CLOCKS -lwasi-emulated-process-clocks /g' |
  sed 's/clang /clang -D_WASI_EMULATED_SIGNAL -lwasi-emulated-signal /g' |
  sed 's/clang /clang -msimd128 /g' |
  cat > ../build/compile.sh
chmod +x ../build/compile.sh
cd ..
