#!/bin/sh
set -eu
if [ "$#" -ne 4 ] || [ "$1" != run ]; then
  echo "usage: $0 run LANE EXECUTABLE STDOUT_FILE" >&2
  exit 2
fi
lane=$2; program=$3; stdout_file=$4
case "$lane" in
  evo-a500|e33-a500) profile=a500 ;;
  evo-a1200) profile=a1200-020 ;;
  *) echo "unsupported lane: $lane" >&2; exit 2 ;;
esac
: "${AMIGA_RUNTIME:=amiga-runtime}"
mkdir -p "$(dirname "$stdout_file")"
"$AMIGA_RUNTIME" test "$program" --profile "$profile"
if [ -n "${AMIGA_RUNTIME_STDOUT:-}" ] && [ -f "$AMIGA_RUNTIME_STDOUT" ]; then
  cp "$AMIGA_RUNTIME_STDOUT" "$stdout_file"
else
  echo "SKIP: no stable captured-output evidence path supplied" >&2
  exit 77
fi
