#!/bin/sh
set -eu
if [ "$#" -ne 4 ] || [ "$1" != compile ]; then
  echo "usage: $0 compile EVO_HOME SOURCE OUTPUT" >&2
  exit 2
fi
evo_home=$2; source_file=$3; output=$4
: "${AMIGA_RUNTIME:=amiga-runtime}"
test -d "$evo_home" || { echo "EVO_HOME not found" >&2; exit 2; }
test -f "$source_file" || { echo "source not found" >&2; exit 2; }
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
cp -a "$evo_home" "$tmp/EVO"
cp "$source_file" "$tmp/hello.e"
evidence=${AMIGA_RUNTIME_EVIDENCE:-build/evo-compile-evidence}
rm -rf "$evidence"; mkdir -p "$evidence" "$(dirname "$output")"
AMIGA_RUNTIME_EVIDENCE="$evidence" "$AMIGA_RUNTIME" guest-job qualification/jobs/evo-hello-e33.json --profile a1200-020 --workspace "$tmp"
artifact="$evidence/job-work/hello"
test -f "$artifact" || { echo "compiled artifact missing" >&2; exit 1; }
cp "$artifact" "$output"
