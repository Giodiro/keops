#!/bin/bash

# --------- # PATH: --------- #

CUDAROOT="/usr/lib/x86_64-linux-gnu"
NVCC="/usr/bin/nvcc"
CC="/usr/bin/gcc"
LIBDSROOT=".."

INSTALL_DIR="$LIBDSROOT/build"

# --------- # GPU PARAMETERS: --------- #

COMPUTECAPABILITY=35
USE_DOUBLE=0
BLOCKSIZE=192

# --------- # NVCC PARAMETERS: --------- #

NVCCFLAGS="-ccbin=$CC -arch=sm_$COMPUTECAPABILITY -Xcompiler -fPIC -shared"
LIBDSPATH="$LIBDSROOT/cuda"

#clean 
rm -f "$INSTALL_DIR/cuda_conv.so"       
rm -f "$INSTALL_DIR/cuda_grad1conv.so"  
rm -f "$INSTALL_DIR/cuda_gradconv_xa.so"
rm -f "$INSTALL_DIR/cuda_gradconv_xx.so"
rm -f "$INSTALL_DIR/cuda_gradconv_xy.so"
rm -f "$INSTALL_DIR/cuda_gradconv_xb.so"

#compile
$NVCC -D "USE_DOUBLE_PRECISION=$USE_DOUBLE" -D "CUDA_BLOCK_SIZE=$BLOCKSIZE" $NVCCFLAGS -I$LIBDSPATH -o "$INSTALL_DIR/cuda_conv.so"        "$LIBDSPATH/cuda_conv.cu"
$NVCC -D "USE_DOUBLE_PRECISION=$USE_DOUBLE" -D "CUDA_BLOCK_SIZE=$BLOCKSIZE" $NVCCFLAGS -I$LIBDSPATH -o "$INSTALL_DIR/cuda_grad1conv.so"   "$LIBDSPATH/cuda_grad1conv.cu"
$NVCC -D "USE_DOUBLE_PRECISION=$USE_DOUBLE" -D "CUDA_BLOCK_SIZE=$BLOCKSIZE" $NVCCFLAGS -I$LIBDSPATH -o "$INSTALL_DIR/cuda_gradconv_xa.so" "$LIBDSPATH/cuda_gradconv_xa.cu"
$NVCC -D "USE_DOUBLE_PRECISION=$USE_DOUBLE" -D "CUDA_BLOCK_SIZE=$BLOCKSIZE" $NVCCFLAGS -I$LIBDSPATH -o "$INSTALL_DIR/cuda_gradconv_xx.so" "$LIBDSPATH/cuda_gradconv_xx.cu"
$NVCC -D "USE_DOUBLE_PRECISION=$USE_DOUBLE" -D "CUDA_BLOCK_SIZE=$BLOCKSIZE" $NVCCFLAGS -I$LIBDSPATH -o "$INSTALL_DIR/cuda_gradconv_xy.so" "$LIBDSPATH/cuda_gradconv_xy.cu"
$NVCC -D "USE_DOUBLE_PRECISION=$USE_DOUBLE" -D "CUDA_BLOCK_SIZE=$BLOCKSIZE" $NVCCFLAGS -I$LIBDSPATH -o "$INSTALL_DIR/cuda_gradconv_xb.so" "$LIBDSPATH/cuda_gradconv_xb.cu"