#!/bin/sh
# Minimal local qualification orchestrator.

set -eu

case_id=${1:-hello-e33}
lane=${2:-evo-a500}

case "$case_id" in
  hello-e33)
    src=examples/00-hello/hello.e
    expected=qualification/cases/hello-e33.json
    ;;
  *)
    echo "unknown case: $case_id" >&2
    exit 2
    ;;
esac

case "$lane" in
  evo-a500|evo-a1200) compiler=evo ;;
  e33-a500) compiler=e33 ;;
  *)
    echo "unknown lane: $lane" >&2
    exit 2
    ;;
esac

mkdir -p build/qualification/"$case_id"/"$lane"
base=build/qualification/"$case_id"/"$lane"
exe="$base/program"
stdout="$base/stdout.txt"

if [ "$compiler" = evo ]; then
    scripts/compile-evo.sh "$src" "$exe"
else
    echo "SKIP $case_id/$lane: EC 3.3a adapter not yet qualified"
    exit 77
fi

: "${AMIGA_RUNNER:?Set AMIGA_RUNNER to the runtime adapter}"

# Contract:
#   AMIGA_RUNNER run LANE EXECUTABLE STDOUT_FILE
"$AMIGA_RUNNER" run "$lane" "$exe" "$stdout"
python3 scripts/verify-case.py "$expected" "$stdout"

echo "PASS $case_id/$lane"
