#!/bin/sh
set -eu

python3 -m py_compile scripts/verify-case.py scripts/case-info.py scripts/evidence-stdout.py scripts/materialize-milestone.py

for f in qualification/*.json qualification/cases/*.json qualification/jobs/*.json qualification/milestones/*.json amiga-runtime.json book/book.json; do
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
printf '%s\n' "$caseinfo" | python3 -c 'import json,sys; d=json.load(sys.stdin); assert d["id"]=="hello-e33"; assert d["output"]=="hello"'
[ "$(python3 scripts/case-info.py qualification/cases/hello-e33.json --field id)" = "hello-e33" ]
[ "$(python3 scripts/case-info.py qualification/cases/hello-e33.json --field output)" = "hello" ]
! grep -q 'eval ' scripts/eduamigae

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

mkdir -p "$tmp/evidence"
printf 'ok\n' >"$tmp/evidence/stdout.txt"
printf '{"status":"PASS","guest_output":{"stdout":"stdout.txt"}}\n' >"$tmp/evidence/result.json"
python3 scripts/evidence-stdout.py "$tmp/evidence/result.json" "$tmp/evidence" >/dev/null
printf '{"status":"PASS","guest_output":{"stdout":"../escape.txt"}}\n' >"$tmp/evidence/bad.json"
if python3 scripts/evidence-stdout.py "$tmp/evidence/bad.json" "$tmp/evidence" >/dev/null 2>&1; then
  echo "unsafe evidence path unexpectedly accepted" >&2
  exit 1
fi

mkdir -p "$tmp/cases"
cp qualification/cases/hello-e33.json "$tmp/cases/hello.json"
cp "$tmp/unsafe.json" "$tmp/cases/unsafe.json"
set +e
EVO_HOME="$tmp/no-evo" sh scripts/eduamigae qualify-all "$tmp/cases" "$tmp/aggregate.json" >/dev/null
aggregate_rc=$?
set -e
[ "$aggregate_rc" -eq 1 ] || { echo "mixed invalid/SKIP aggregate must exit 1" >&2; exit 1; }
python3 - "$tmp/aggregate.json" <<'PY'
import json,sys
d=json.load(open(sys.argv[1],encoding="utf-8"))
assert d["total"] == 2, d
assert d["fail"] == 1, d
assert d["skip"] == 1, d
assert d["pass"] == 0, d
PY

for milestone in qualification/milestones/*.json; do
  [ -f "$milestone" ] || continue
  name=$(basename "$milestone" .json)
  dest="$tmp/milestone-$name"
  python3 scripts/materialize-milestone.py "$milestone" "$dest" >/dev/null
  for casefile in "$dest"/*.json; do
    python3 scripts/case-info.py "$casefile" >/dev/null
  done
done

cat >"$tmp/bad-milestone.json" <<'EOF'
{"schema":1,"milestone":"BAD","cases":["../hello-e33.json"]}
EOF
if python3 scripts/materialize-milestone.py "$tmp/bad-milestone.json" "$tmp/bad-materialized" >/dev/null 2>&1; then
  echo "unsafe milestone case path unexpectedly accepted" >&2
  exit 1
fi

echo "repository checks: PASS"
