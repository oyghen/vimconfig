SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
SRC="$SCRIPT_DIR/vimrc"
DST="$HOME/.vimrc"

rm -f -- "$DST"
ln -s -- "$SRC" "$DST"

echo "Created symbolic link '$DST' pointing to '$SRC'."
