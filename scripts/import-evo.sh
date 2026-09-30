#!/bin/sh
set -eu

src=${1:?usage: import-evo.sh SOURCE DEST_DIR}
dst=${2:-.toolchain/evo/3.9.4}
expected_sha=a7ebb0b8de6261d63e9416f9a385ee1973a67a84228a1370b4ad6dcd4fe21230
expected_size=703734

tmp=""
cleanup() { [ -z "$tmp" ] || rm -rf "$tmp"; }
trap cleanup EXIT HUP INT TERM

if [ -f "$src" ]; then
  actual_size=$(wc -c <"$src" | tr -d ' ')
  actual_sha=$(sha256sum "$src" | awk '{print $1}')
  [ "$actual_size" = "$expected_size" ] || { echo "E-VO archive size mismatch" >&2; exit 2; }
  [ "$actual_sha" = "$expected_sha" ] || { echo "E-VO archive SHA-256 mismatch" >&2; exit 2; }
  command -v lha >/dev/null 2>&1 || { echo "lha is required to import evo394.lha" >&2; exit 69; }
  tmp=$(mktemp -d)
  (cd "$tmp" && lha x "$OLDPWD/$src" >/dev/null)
  src="$tmp"
fi

test -d "$src" || { echo "source not found: $src" >&2; exit 2; }

guide=$(find "$src" -type f -name 'E-VO.guide' -print -quit)
test -n "$guide" || { echo "E-VO.guide missing" >&2; exit 2; }
grep -q 'Amiga E-VO v3\.9\.4' "$guide" || {
  echo "source is not the pinned E-VO 3.9.4 distribution" >&2
  exit 2
}

root=$(dirname "$guide")
rm -rf "$dst"
mkdir -p "$(dirname "$dst")"
cp -a "$root" "$dst"
printf 'E-VO 3.9.4 imported to %s\n' "$dst"
