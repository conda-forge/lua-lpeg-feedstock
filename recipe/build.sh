#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export LUA_INCLUDE_DIR=$PREFIX/include/luajit-2.1

cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DLUA_INCLUDE_DIR=$LUA_INCLUDE_DIR \
    $CMAKE_ARGS
cmake --build build --config Release
cmake --install build
