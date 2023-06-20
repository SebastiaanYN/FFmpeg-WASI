#!/bin/bash

set -euox pipefail

DOCKER_BUILDKIT=1 docker build -t ffmpeg-wasi --output . .
