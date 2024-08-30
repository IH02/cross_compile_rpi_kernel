#!/bin/bash

echo "Configure build output path"

# 현재 스크립트의 디렉토리를 절대 경로로 설정
KERNEL_TOP_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
OUTPUT="$KERNEL_TOP_PATH/out"
echo "Output directory: $OUTPUT"

KERNEL=kernel7l
BUILD_LOG="$KERNEL_TOP_PATH/rpi_build_log.txt"

echo "Move to kernel source directory"
cd linux

echo "Make defconfig for bcm2711"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=$OUTPUT bcm2711_defconfig

echo "Build kernel, modules, and device tree blobs"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=$OUTPUT zImage modules dtbs -j12 2>&1 | tee $BUILD_LOG

echo "Kernel build completed. Log saved to $BUILD_LOG"

# 현재 디렉토리에 모듈 설치 디렉토리 생성
MODULES_DIR=$KERNEL_TOP_PATH/modules
mkdir -p $MODULES_DIR

echo "Install modules"
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=$OUTPUT INSTALL_MOD_PATH=$MODULES_DIR modules_install

echo "Kernel image and modules have been installed to $MODULES_DIR"
