#!/bin/sh
set -eu

src=${1:?usage: import-evo.sh SOURCE_DIR DEST_DIR}
dst=${2:-.toolchain/evo/3.9.4}

test -d "$src" || { echo "source directory not found: $src" >&2; exit 2; }
test -f "$src/E-VO.guide" || { echo "E-VO.guide missing" >&2; exit 2; }
grep -q 'Amiga E-VO v3\.9\.4' "$src/E-VO.guide" || {
  echo "source is not the pinned E-VO 3.9.4 distribution" >&2
  exit 2
}

# Accept installed distributions (BIN/Modules) and upstream source/release
# layouts. The executor performs the final required-file check.
if [ ! -d "$src/Modules" ] && [ ! -d "$src/modules" ]; then
  echo "warning: no Modules/modules directory found" >&2
fi

rm -rf "$dst"
mkdir -p "$(dirname "$dst")"
cp -a "$src" "$dst"
printf 'E-VO 3.9.4 imported to %s\n' "$dst"
