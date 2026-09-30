#!/bin/sh
set -eu

if [ "$#" -ne 4 ] || [ "$1" != run ]; then
  echo "usage: $0 run LANE EXECUTABLE STDOUT_FILE" >&2
  exit 2
fi

lane=$2
program=$3
stdout_file=$4

case "$lane" in
  evo-a500|e33-a500) profile=a500 ;;
  evo-a1200) profile=a1200-020 ;;
  *) echo "unsupported lane: $lane" >&2; exit 2 ;;
esac

: "${AMIGA_RUNTIME:=amiga-runtime}"
evidence=${AMIGA_RUNTIME_EVIDENCE:-build/amiga-runtime-evidence}
rm -rf "$evidence"
mkdir -p "$evidence" "$(dirname "$stdout_file")"

AMIGA_RUNTIME_EVIDENCE="$evidence" "$AMIGA_RUNTIME" test-hunk "$program" --profile "$profile"

result="$evidence/result.json"
test -s "$result" || { echo "missing amiga-runtime result.json" >&2; exit 1; }

guest_stdout=$(python3 - "$result" <<'PY'
import json, pathlib, sys
p=pathlib.Path(sys.argv[1])
d=json.loads(p.read_text())
if d.get("status") != "PASS":
    raise SystemExit("runtime evidence is not PASS")
rel=d.get("guest_output",{}).get("stdout")
if not rel:
    raise SystemExit("runtime evidence has no guest stdout")
q=(p.parent/rel).resolve()
root=p.parent.resolve()
if root not in q.parents and q != root:
    raise SystemExit("unsafe guest stdout path")
print(q)
PY
)

test -f "$guest_stdout" || { echo "missing guest stdout evidence: $guest_stdout" >&2; exit 1; }
cp "$guest_stdout" "$stdout_file"
