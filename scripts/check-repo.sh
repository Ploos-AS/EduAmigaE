#!/bin/sh
set -eu

python3 -m py_compile scripts/verify-case.py scripts/case-info.py

for f in qualification/*.json qualification/cases/*.json qualification/jobs/*.json amiga-runtime.json; do
  [ -f "$f" ] || continue
  python3 -m json.tool "$f" >/dev/null
done

for f in scripts/*.sh scripts/eduamigae; do
  sh -n "$f"
done

help=$(sh scripts/eduamigae help)
printf '%s\n' "$help" | grep -q 'eduamigae doctor'
printf '%s\n' "$help" | grep -q 'eduamigae import-evo'
printf '%s\n' "$help" | grep -q 'eduamigae build'
printf '%s\n' "$help" | grep -q 'eduamigae run'
printf '%s\n' "$help" | grep -q 'eduamigae test'
printf '%s\n' "$help" | grep -q 'eduamigae qualify'

caseinfo=$(python3 scripts/case-info.py qualification/cases/hello-e33.json)
printf '%s\n' "$caseinfo" | grep -q '^ID=hello-e33

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
printf 'Hello from EduAmigaE!\n' >"$tmp/pass.txt"
python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/pass.txt"

printf 'wrong output\n' >"$tmp/fail.txt"
if python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/fail.txt" >/dev/null 2>&1; then
  echo "negative verify-case fixture unexpectedly passed" >&2
  exit 1
fi

echo "repository checks: PASS"

printf '%s\n' "$caseinfo" | grep -q '^OUTPUT=hello

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
printf 'Hello from EduAmigaE!\n' >"$tmp/pass.txt"
python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/pass.txt"

printf 'wrong output\n' >"$tmp/fail.txt"
if python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/fail.txt" >/dev/null 2>&1; then
  echo "negative verify-case fixture unexpectedly passed" >&2
  exit 1
fi

echo "repository checks: PASS"


tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
printf 'Hello from EduAmigaE!\n' >"$tmp/pass.txt"
python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/pass.txt"

printf 'wrong output\n' >"$tmp/fail.txt"
if python3 scripts/verify-case.py qualification/cases/hello-e33.json "$tmp/fail.txt" >/dev/null 2>&1; then
  echo "negative verify-case fixture unexpectedly passed" >&2
  exit 1
fi

echo "repository checks: PASS"
