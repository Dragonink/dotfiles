#!/usr/bin/env nu

# Remove old symlinks
rm --force --permanent *-completions.nu

# List available completions and intersect with programs in PATH
const SOURCE: path = '../nu_scripts/custom-completions'
let completions = ls $SOURCE
  | get name
  | path basename
  | filter {|cmd| which --all $cmd | filter {|row| $row.path | is-not-empty} | is-not-empty}
  | par-each {|comp| $SOURCE | path join $comp $"($comp)-completions.nu"}
ln --symbolic --relative ...$completions .
