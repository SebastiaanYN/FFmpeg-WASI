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
  zlib1g-dev

# Install deps
RUN apt-get -y install \
    # libx264
    libx264-dev

# Copy sources
COPY FFmpeg FFmpeg
COPY deps deps
COPY patches patches
COPY scripts scripts

# Setup scripts
RUN ./scripts/install.sh
RUN ./scripts/build-deps.sh
RUN ./scripts/configure.sh

# Build
FROM setup AS build
RUN ./scripts/build.sh

# Export
FROM scratch AS export
COPY --from=build /app/ffmpeg.wasm /app/ffprobe.wasm ./
