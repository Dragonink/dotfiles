# Use bat as the default pager
export BAT_PAGER="$PAGER"
export PAGER='bat --paging=always'

# Alias cat to bat
alias cat='bat --paging=never --style=plain'

# Make man use bat
export MANPAGER=$'sh -c \'col --no-backspaces --spaces | env LESS=\"$LESS -Pm$MANLESS$ -PM$MANLESS$\" bat --paging=always --style=plain --theme=default --language=man\''

# Make lesspipe use bat
export LESSCOLORIZER='bat'
