#!/bin/bash

mkdir build
cd build

export CXXFLAGS="$CXXFLAGS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS"

cmake ${CMAKE_ARGS} \
    -DLLVM_DIR=$PREFIX/lib/cmake/llvm \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DIGC_TARGET__TOOLS_CLANG_DIR=$PREFIX/lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DCOMMON_CLANG_LIBRARY_NAME=opencl_clang \
    -DINTRSRC=$SRC_DIR/vc-intrinsics/GenXIntrinsics \
    -DIGC_OPTION__USE_KHRONOS_SPIRV_TRANSLATOR=1 \
    -DSPIRV_TRANSLATOR_DIR=$PREFIX \
    -DIGC_OPTION__LLVM_FROM_SYSTEM=1 \
    -DINSTALL_SPIRVDLL=0 \
    -DIGC_PREFERRED_LLVM_VERSION=11.0.0 \
    -DFOUND_VCS=$PREFIX/lib/cmake/llvm/VersionFromVCS.cmake \
    ..

make -j${CPU_COUNT}
make install

