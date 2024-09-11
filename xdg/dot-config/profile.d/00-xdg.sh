# Define XDG user directories
#shellcheck disable=SC1091
. "$XDG_CONFIG_HOME/user-dirs.dirs"
export \
	XDG_DESKTOP_DIR \
	XDG_DOWNLOAD_DIR \
	XDG_TEMPLATES_DIR \
	XDG_PUBLICSHARE_DIR \
	XDG_DOCUMENTS_DIR \
	XDG_MUSIC_DIR \
	XDG_PICTURES_DIR \
	XDG_VIDEOS_DIR

# Export XDG environment variables to systemd
dbus-update-activation-environment --systemd \
	XDG_CONFIG_HOME \
	XDG_CACHE_HOME \
	XDG_DATA_HOME \
	XDG_STATE_HOME \
	XDG_DESKTOP_DIR \
	XDG_DOWNLOAD_DIR \
	XDG_TEMPLATES_DIR \
	XDG_PUBLICSHARE_DIR \
	XDG_DOCUMENTS_DIR \
	XDG_MUSIC_DIR \
	XDG_PICTURES_DIR \
	XDG_VIDEOS_DIR

# Make GTK applications use the XDG portal
export GTK_USE_PORTAL=1
