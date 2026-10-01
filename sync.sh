#!/usr/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.ipod.conf"

if ! mountpoint -q "$IPOD"; then
    echo "ERROR: iPod not connected!" >&2
    exit 1
fi

rsync -rvhP \
    --no-perms --no-owner --no-group \
    --ignore-existing \
    --modify-window=1 \
    --exclude='*.bmark' \
    --exclude='.Trash*' \
    --exclude='.yt-dlp-archive' \
    --exclude='.gitkeep' \
    "$BASE/" "$IPOD/"

sync
