#!/bin/bash

# Script to manually mount ADATA HD330 (NTFS) on Debian
# Usage: sudo ./mount_adata.sh

DEVICE="/dev/sdd2"
MOUNT_POINT="/mnt/adata"

# Check if device is specified
if [ -z "$DEVICE" ]; then
    echo "Error: No device specified."
    echo "Usage: sudo $0 /dev/sddX"
    exit 1
fi

# Check if ntfs-3g is installed
if ! command -v ntfs-3g &> /dev/null; then
    echo "Error: ntfs-3g is not installed."
    echo "Install it with: sudo apt install ntfs-3g"
    exit 1
fi

# Create mount point directory
echo "Creating mount point: $MOUNT_POINT"
sudo mkdir -p "$MOUNT_POINT"

# Mount the device
echo "Mounting $DEVICE to $MOUNT_POINT..."
sudo mount -t ntfs-3g "$DEVICE" "$MOUNT_POINT"

# Check if mount was successful
if [ $? -eq 0 ]; then
    echo "Successfully mounted $DEVICE to $MOUNT_POINT"
    echo "Contents: "
    ls -la "$MOUNT_POINT"
else
    echo "Error: Failed to mount $DEVICE"
    echo "Try checking the device with: sudo blkid $DEVICE"
    exit 1
fi
