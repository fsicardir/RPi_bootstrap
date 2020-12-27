#!/usr/bin/env bash

SD_DEVICE=$1
INSTANCE_NAME=$2

IMAGE_PATH="./hypriotos-rpi-v1.12.3.img" 
MOUNTPOINT="/tmp/mountpoint"

cp "$IMAGE_PATH" "$SD_DEVICE"

mkdir -p "$MOUNTPOINT"
mount -o loop,offset=$((2048 * 512)) "$SD_DEVICE" "$MOUNTPOINT"

sed -e "s/___instance_name___/$INSTANCE_NAME/" "./user-data.template" > "$MOUNTPOINT/user-data"
sed -e "s/___instance_name___/$INSTANCE_NAME/" "./meta-data.template" > "$MOUNTPOINT/meta-data"

umount "$MOUNTPOINT"
rmdir "$MOUNTPOINT"

