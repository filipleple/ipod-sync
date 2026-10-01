#!/usr/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.ipod.conf"

download_playlist() {
    local url="$1"
    local dir="$2"

    mkdir -p "$dir"

    yt-dlp \
        -f "bestaudio[ext=m4a]/bestaudio" \
        --no-overwrites \
        --download-archive "$dir/.yt-dlp-archive" \
        --output "$dir/%(title)s.%(ext)s" \
        "$url"
}

download_playlist "$PODCAST_PLAYLIST_URL" "$BASE/podcasts"
download_playlist "$BOOKS_PLAYLIST_URL"   "$BASE/books"
download_playlist "$NOISE_PLAYLIST_URL"   "$BASE/noise"
download_playlist "$MUSIC_PLAYLIST_URL"   "$BASE/music"
