#! /bin/sh

WASI_SDK=${WASI_SDK:-/opt/wasi-sdk}

set -e

cmake -B build \
-DWASI_SDK_PREFIX=${WASI_SDK} \
-DCMAKE_TOOLCHAIN_FILE=${WASI_SDK}/share/cmake/wasi-sdk.cmake \
-DBUILD_STATIC=ON \
-DBUILD_SHARED_LIBS=OFF

cmake --build build

mkdir -p dist/include
mkdir -p dist/lib
cp build/libjpeg.a dist/lib
cp build/jconfig.h dist/include
cp jmorecfg.h jpeglib.h dist/include

cd dist
pax -wvzf ../libjpeg-wasm32-wasi.tgz include lib
