# ipod sync

Small set of scripts for downloading audio and syncing it to an iPod.

## Layout

```text
content-sync/
└── audio/
    ├── books/
    ├── music/
    ├── noise/
    └── podcasts/
```

The contents of these directories are ignored by Git. `.gitkeep` files are used to keep the directory structure in the repository.

## Requirements

- `yt-dlp`
- `ffmpeg`
- `rsync`

On Fedora:

```bash
sudo dnf install yt-dlp ffmpeg-free rsync
```

## Downloading

Configure playlist URLs in `download.sh`, then run:

```bash
./download.sh
```

Playlists are downloaded into the corresponding directories under:

```text
content-sync/audio/
```

`yt-dlp` uses archive files to avoid downloading the same video more than once.

Existing files are not overwritten.

## Syncing

Connect the iPod and run:

```bash
./sync.sh
```

The script syncs:

```text
content-sync/audio/
```

to the configured iPod mount point.

If the iPod is not mounted, the script exits with:

```text
ERROR: iPod not connected!
```

The sync does not delete files already present on the iPod.

The following files are excluded from syncing:

```text
*.bmark
.Trash*
.yt-dlp-archive
.gitkeep
```

## Configuration

Paths and playlist URLs are configured directly in:

```text
download.sh
sync.sh
```
