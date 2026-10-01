#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
EXAMPLE_DIR="$ROOT/examples/16-own-module"
MODULE_SOURCE="$EXAMPLE_DIR/edumath.e"
MODULE_OUTPUT="$EXAMPLE_DIR/edumath.m"
MAIN_SOURCE="$EXAMPLE_DIR/main.e"
MAIN_OUTPUT="$EXAMPLE_DIR/main"

if [ -z "${EVO_RUNNER:-}" ]; then
  echo "EVO_RUNNER is required" >&2
  exit 2
fi

rm -f "$MODULE_OUTPUT" "$MAIN_OUTPUT"

"$EVO_RUNNER" compile "${EVO_HOME:-}" "$MODULE_SOURCE" "$MODULE_OUTPUT"
if [ ! -f "$MODULE_OUTPUT" ]; then
  echo "module compile did not produce $MODULE_OUTPUT" >&2
  exit 1
fi

"$EVO_RUNNER" compile "${EVO_HOME:-}" "$MAIN_SOURCE" "$MAIN_OUTPUT"
if [ ! -f "$MAIN_OUTPUT" ]; then
  echo "client compile did not produce $MAIN_OUTPUT" >&2
  exit 1
fi

printf '%s\n' "$MAIN_OUTPUT"
