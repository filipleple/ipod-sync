#!/usr/bin/bash

set -euo pipefail

BASE="/home/flewinski/workspace/offtop/ipod/content-sync/audio"

PODCAST_PLAYLIST_URL="PUT_URL_HERE"
MUSIC_PLAYLIST_URL="PUT_URL_HERE"
BOOKS_PLAYLIST_URL="PUT_URL_HERE"

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
download_playlist "$MUSIC_PLAYLIST_URL"   "$BASE/music"
download_playlist "$BOOKS_PLAYLIST_URL"   "$BASE/books"
