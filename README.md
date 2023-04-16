# FFmpeg-WASI

FFmpeg-WASI compiles FFmpeg to WASM. Unlike [ffmpeg.wasm](https://github.com/ffmpegwasm/ffmpeg.wasm) the code is compiled using WASI, which means you get no JavaScript glue.

## Clone

To get started you can clone the repository and its submodules.

```sh
git clone --recursive git@github.com:SebastiaanYN/FFmpeg-WASI.git
```

## Build

Building the project requires several dependencies and steps to be executed. To make it easier to build the project a Dockerfile is provided. Simply run the following command to build `ffmpeg.wasm` and `ffprobe.wasm`.

```sh
DOCKER_DEFAULT_PLATFORM=linux/amd64 DOCKER_BUILDKIT=1 docker build -t ffmpeg-wasi --output . .
```

## Examples

You can use any WASI compatible WASM runtime, like `wasmtime` and `wasmer`, to run the binary.

Generating a thumbnail from a video.

```sh
wasmtime --dir videos ffmpeg.wasm -- -i videos/video-1080p-60fps-2s.mp4 -ss 1 -vframes 1 videos/out.png
```

Converting from one video format to another.

```sh
wasmtime --dir videos ffmpeg.wasm -- -i videos/video-15s.avi -c:v libx264 videos/out.mp4
```

## Encoders

Currently only `zlib` and `x264` are included in the build, but adding more should be fairly straightforward.

## Limitations

Some codecs require multiple iterations over the input/output (like mp4), which means you cannot pipe the input/output. Instead you need to write the file to disk so FFmpeg can read it from there. Depending on where you're running your code this may not be possible.

Additionally, WASI is still a very young technology so some FFmpeg features, like threading and networking, have to be disabled. In the future it might be possible to enable these features.

## License

This project is licensed under MIT. Be aware that the licenses of FFmpeg and other dependencies may still apply.
