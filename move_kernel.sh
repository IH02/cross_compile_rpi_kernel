#!/bin/bash

# 라즈베리 파이의 사용자명과 IP 주소 설정
PI_USER="aoddudwo"
PI_IP="219.241.133.179"
REMOTE_PATH="/home/$PI_USER/cross_kernel"
REMOTE_OVERLAYS_PATH="$REMOTE_PATH/overlays"
REMOTE_DTB_PATH="$REMOTE_PATH/dtb"

# 빌드된 파일 경로 설정
KERNEL_IMAGE="$PWD/out/arch/arm/boot/zImage"
MODULES_DIR="$PWD/modules/lib/modules"
DTB_FILES="$PWD/out/arch/arm/boot/dts/broadcom/*.dtb"
OVERLAYS_DIR="$PWD/out/arch/arm/boot/dts/overlays"


# 커널 이미지 전송
echo "Transferring kernel image..."
scp -P 100 $KERNEL_IMAGE $PI_USER@$PI_IP:$REMOTE_PATH/

# 모듈 디렉토리 전송
echo "Transferring modules..."
scp -r -P 100 $MODULES_DIR $PI_USER@$PI_IP:$REMOTE_PATH/modules

# 디바이스 트리 블롭 전송
echo "Transferring device tree blobs..."
scp -P 100 $DTB_FILES $PI_USER@$PI_IP:$REMOTE_DTB_PATH/

# overlays 디렉토리 전송
echo "Transferring overlays..."
scp -P 100 $OVERLAYS_DIR/*.dtb* $PI_USER@$PI_IP:$REMOTE_OVERLAYS_PATH/

echo "File transfer completed."
