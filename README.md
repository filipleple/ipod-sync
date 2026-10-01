# ipod sync

Small set of scripts for downloading audio and syncing it to an iPod.

## Layout

```text
.
├── .ipod.conf
├── download.sh
├── sync.sh
└── content-sync/
    └── audio/
        ├── books/
        ├── music/
        ├── noise/
        └── podcasts/
```

The contents of the audio directories are ignored by Git. `.gitkeep` files are used to keep the directory structure in the repository.

## Requirements

- `yt-dlp`
- `ffmpeg`
- `rsync`

On Fedora:

```bash
sudo dnf install yt-dlp ffmpeg-free rsync
```

## Configuration

Paths and playlist URLs are configured in `.ipod.conf`, located next to `download.sh` and `sync.sh`.

Example:

```bash
BASE="/home/user/workspace/ipod/content-sync/audio"
IPOD="/run/media/user/IPOD"

PODCAST_PLAYLIST_URL="https://www.youtube.com/playlist?list=..."
BOOKS_PLAYLIST_URL="https://www.youtube.com/playlist?list=..."
NOISE_PLAYLIST_URL="https://www.youtube.com/playlist?list=..."
```

`BASE` is the local directory containing the audio library.

`IPOD` is the iPod mount point.

The playlist variables specify which YouTube playlists are downloaded into the corresponding audio directories.

Both scripts load `.ipod.conf` relative to their own location, so they can be run from any working directory.

If the configuration is machine-specific, `.ipod.conf` should be ignored by Git.

For example:

```gitignore
.ipod.conf
```

A `.ipod.conf.example` file can be committed to the repository as a template.

## Downloading

Configure the playlist URLs and local audio path in `.ipod.conf`, then run:

```bash
./download.sh
```

Playlists are downloaded into the corresponding directories under the configured `BASE` directory:

```text
content-sync/audio/
├── books/
├── noise/
└── podcasts/
```

`yt-dlp` uses an archive file in each directory to avoid downloading the same video more than once:

```text
.yt-dlp-archive
```

Existing files are not overwritten.

## Syncing

Connect the iPod and run:

```bash
./sync.sh
```

The script syncs the configured `BASE` directory to the configured `IPOD` mount point.

If the iPod is not mounted, the script exits with:

```text
ERROR: iPod not connected!
```

Existing files on the iPod are not overwritten, and files already present on the iPod are not deleted.

The following files are excluded from syncing:

```text
*.bmark
.Trash*
.yt-dlp-archive
.gitkeep
```
