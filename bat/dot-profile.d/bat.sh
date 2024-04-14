# Make lesspipe use bat
export LESSCOLORIZER='bat --style=plain'

# Make man use bat
export MANPAGER="sh -c 'col --no-backspaces --spaces | env LESS=\"$LESS -Pm$MANLESS$ -PM$MANLESS$\" bat --paging=always --style=plain --theme=default --language=man'"
