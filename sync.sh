#!/usr/bin/bash

set -euo pipefail

IPOD="/run/media/flewinski/IPOD DI CIN"
SOURCE="/home/flewinski/workspace/offtop/ipod/content-sync/audio"

if ! mountpoint -q "$IPOD"; then
    echo "ERROR: iPod not connected!" >&2
    exit 1
fi

rsync -rvhP \
    --no-perms --no-owner --no-group \
    --modify-window=1 \
    --exclude='*.bmark' \
    --exclude='.Trash*' \
    --exclude='.yt-dlp-archive' \
    "$SOURCE/" "$IPOD/"
