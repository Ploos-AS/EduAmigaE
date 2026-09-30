#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"
CLI="$ROOT/scripts/eduamigae"

: "${EVO_HOME:?EVO_HOME must point to an imported E-VO 3.9.4 distribution}"
command -v amiga-runtime >/dev/null 2>&1 || {
  echo "amiga-runtime is required for M2 runtime qualification" >&2
  exit 69
}

"$CLI" doctor
mkdir -p build/qualification
report=build/qualification/m2-cases.json

set +e
"$CLI" qualify-all qualification/cases "$report"
rc=$?
set -e
[ "$rc" -eq 0 ] || {
  echo "M2 qualification cases did not produce a complete PASS (rc=$rc)" >&2
  exit "$rc"
}

python3 - "$report" <<'PY'
import hashlib, json, pathlib, sys

report_path=pathlib.Path(sys.argv[1])
report=json.loads(report_path.read_text(encoding="utf-8"))
if report.get("fail") != 0 or report.get("skip") != 0:
    raise SystemExit("M2 requires zero FAIL and zero SKIP")
if report.get("pass") != report.get("total") or not report.get("total"):
    raise SystemExit("M2 requires every discovered case to PASS")

cases=[]
for p in sorted(pathlib.Path("qualification/cases").glob("*.json")):
    d=json.loads(p.read_text(encoding="utf-8"))
    cases.append({
        "id": d["id"],
        "path": p.as_posix(),
        "sha256": hashlib.sha256(p.read_bytes()).hexdigest(),
        "compatibility": d["compatibility"],
        "profiles": d["profiles"],
    })

out={
    "schema":1,
    "milestone":"M2",
    "status":"PASS",
    "case_count":len(cases),
    "report_sha256":hashlib.sha256(report_path.read_bytes()).hexdigest(),
    "cases":cases,
}
pathlib.Path("build/qualification/m2.json").write_text(
    json.dumps(out,indent=2)+"\n", encoding="utf-8"
)
print(f'M2 PASS: {len(cases)} qualification cases')
PY

echo "M2 qualification evidence: build/qualification/m2.json"
