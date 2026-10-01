#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
MODULE_SOURCE="$ROOT/examples/16-own-module/modules/edumath.e"
MAIN_SOURCE="$ROOT/examples/16-own-module/main.e"
OUT=${1:-"$ROOT/build/qualification/own-module"}
COMPILE="$ROOT/scripts/compile-vamos.sh"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT HUP INT TERM

EDUAMIGAE_COMPILE_WORKDIR="$work" EDUAMIGAE_COMPILE_NAME=edumath \
  "$COMPILE" "$MODULE_SOURCE" "$work/edumath.m"

test -f "$work/edumath.m" || {
  echo "module compile did not produce edumath.m" >&2
  exit 1
}

EDUAMIGAE_COMPILE_WORKDIR="$work" EDUAMIGAE_COMPILE_NAME=main \
  "$COMPILE" "$MAIN_SOURCE" "$OUT"

test -f "$OUT" || {
  echo "client compile did not produce $OUT" >&2
  exit 1
}

printf '%s\n' "$OUT"
