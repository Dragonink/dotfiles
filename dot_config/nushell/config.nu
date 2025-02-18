# Disable the welcome banner
$env.config.show_banner = false
# Make rm trash files by default
$env.config.rm.always_trash = true
# Enable kitty protocol
if $env.KITTY_WINDOW_ID? != null {
  $env.config.use_kitty_protocol = true
}

# Convert environment variables to Nushell
export-env {
  let PATH_LIST_ESEP = {
    from_string: {|s| $s | split row (char esep) | path expand --no-symlink}
    to_string: {|v| $v | path expand --no-symlink | str join (char esep)}
  }
  let LIST_SPACE = {
    from_string: {|s| $s | split row (char space)}
    to_string: {|v| $v | str join (char space)}
  }

  $env.ENV_CONVERSIONS = $env.ENV_CONVERSIONS | merge {
    "AQ_DRM_DEVICES": $PATH_LIST_ESEP,
    "XDG_CONFIG_DIRS": $PATH_LIST_ESEP,
    "XDG_DATA_DIRS": $PATH_LIST_ESEP,
    "UWSM_FINALIZE_VARNAMES": $LIST_SPACE,
    "UWSM_WAIT_VARNAMES": $LIST_SPACE,
  }
}


# Prepare the vendor autoload directory
const VENDOR_AUTOLOAD = $nu.data-dir | path join "vendor" "autoload"
mkdir $VENDOR_AUTOLOAD

# Activate Starship
const STARSHIP = $VENDOR_AUTOLOAD | path join "starship.nu"
if (which starship | length) > 0 {
  ^starship init nu | save --force $STARSHIP
} else {
  rm --force --permanent $STARSHIP
}
