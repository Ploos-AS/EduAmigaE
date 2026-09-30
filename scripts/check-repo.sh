#!/bin/sh
set -eu

python3 -m py_compile scripts/verify-case.py scripts/case-info.py

for f in qualification/*.json qualification/cases/*.json qualification/jobs/*.json amiga-runtime.json book/book.json; do
  [ -f "$f" ] || continue
  python3 -m json.tool "$f" >/dev/null
done

for f in scripts/*.sh scripts/eduamigae; do
  sh -n "$f"
done

help=$(sh scripts/eduamigae help)
for cmd in doctor import-evo build run test qualify qualify-all; do
  printf '%s\n' "$help" | grep -q "eduamigae $cmd"
done

caseinfo=$(python3 scripts/case-info.py qualification/cases/hello-e33.json)
printf '%s\n' "$caseinfo" | grep -q '^ID=hello-e33$'
printf '%s\n' "$caseinfo" | grep -q '^OUTPUT=hello$'

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

printf 'Hello from EduAmigaE!\n' >"$tmp/pass.txt"
python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/pass.txt"

printf 'wrong output\n' >"$tmp/fail.txt"
if python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/fail.txt" >/dev/null 2>&1; then
  echo "negative verify-case fixture unexpectedly passed" >&2
  exit 1
fi

cat >"$tmp/unsafe.json" <<'EOF'
{"id":"x;echo BAD","source":"examples/00-hello/hello.e","output":"hello","compatibility":"E33","expected":{"stdout":"","exit":"success"},"profiles":["amiga-ocs-68000-1m"]}
EOF
if python3 scripts/case-info.py "$tmp/unsafe.json" >/dev/null 2>&1; then
  echo "unsafe case id unexpectedly accepted" >&2
  exit 1
fi

echo "repository checks: PASS"
