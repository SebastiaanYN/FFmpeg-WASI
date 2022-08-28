# Setup
FROM ubuntu:20.04 AS setup

WORKDIR /app

# https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git-core \
  libass-dev \
  libfreetype6-dev \
  libgnutls28-dev \
  libmp3lame-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  meson \
  ninja-build \
  pkg-config \
  texinfo \
  wget \
  yasm \
  zlib1g-dev \
  # libx264
  libx264-dev \
  # optimizations
  binaryen

# Install script
COPY scripts/install.sh scripts/install.sh
RUN ./scripts/install.sh

# Copy sources
COPY FFmpeg FFmpeg
COPY deps deps
COPY scripts scripts

# Build scripts
FROM setup AS build
RUN ./scripts/build-deps.sh
RUN ./scripts/configure.sh
RUN ./scripts/build.sh
RUN ./scripts/optimize.sh

# Export
FROM scratch AS export
COPY --from=build /app/ffmpeg.wasm /app/ffprobe.wasm ./
