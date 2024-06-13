function prepare_tmp() {
	mkdir --parents --mode 0700 "${TMPDIR:-/tmp}/aurutils-$UID" > /dev/null
	mktemp --directory --tmpdir "aurutils-$UID/$1.XXXXXX"
}

function filter_vcs() {
	awk -v 'mask=.*-(vcs|git|svn|hg|bzr|darcs)$' '$1 ~ mask { print $1 }' "$@"
}
