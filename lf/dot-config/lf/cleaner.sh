#!/bin/bash
set -euo pipefail

kitty +kitten icat --clear > /dev/tty
exit $?
