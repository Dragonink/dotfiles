# Configure yt-dlp for music
alias music-dlp='yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 --no-mtime -o "$XDG_DOWNLOAD_DIR/%(title)s.%(ext)s"'
