#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"
CLI="$ROOT/scripts/eduamigae"

: "${EVO_HOME:?EVO_HOME must point to an imported E-VO 3.9.4 distribution}"
command -v amiga-runtime >/dev/null 2>&1 || {
  echo "amiga-runtime is required for M4 runtime qualification" >&2
  exit 69
}

manifest=qualification/milestones/m4.json

python3 - "$manifest" <<'PY'
import json, pathlib, sys
p=pathlib.Path(sys.argv[1])
d=json.loads(p.read_text(encoding="utf-8"))
if d.get("schema") != 1 or d.get("milestone") != "M4":
    raise SystemExit("invalid M4 milestone manifest")
if not d.get("cases"):
    raise SystemExit("M4 has no locked qualification cases yet")
PY

"$CLI" doctor
mkdir -p build/qualification
report=build/qualification/m4-cases.json
cases_tmp=$(mktemp -d)
trap 'rm -rf "$cases_tmp"' EXIT HUP INT TERM
python3 scripts/materialize-milestone.py "$manifest" "$cases_tmp" >/dev/null

set +e
"$CLI" qualify-all "$cases_tmp" "$report"
rc=$?
set -e
[ "$rc" -eq 0 ] || {
  echo "M4 qualification cases did not produce a complete PASS (rc=$rc)" >&2
  exit "$rc"
}

python3 - "$report" <<'PY'
import hashlib, json, pathlib, sys
report_path=pathlib.Path(sys.argv[1])
report=json.loads(report_path.read_text(encoding="utf-8"))
if report.get("fail") != 0 or report.get("skip") != 0:
    raise SystemExit("M4 requires zero FAIL and zero SKIP")
if report.get("pass") != report.get("total") or not report.get("total"):
    raise SystemExit("M4 requires every locked case to PASS")

manifest_path=pathlib.Path("qualification/milestones/m4.json")
manifest=json.loads(manifest_path.read_text(encoding="utf-8"))
cases=[]
for name in manifest["cases"]:
    p=pathlib.Path("qualification/cases") / name
    d=json.loads(p.read_text(encoding="utf-8"))
    cases.append({
        "id":d["id"],
        "path":p.as_posix(),
        "sha256":hashlib.sha256(p.read_bytes()).hexdigest(),
        "compatibility":d["compatibility"],
        "profiles":d["profiles"],
    })
out={
    "schema":1,
    "milestone":"M4",
    "status":"PASS",
    "case_count":len(cases),
    "manifest_sha256":hashlib.sha256(manifest_path.read_bytes()).hexdigest(),
    "report_sha256":hashlib.sha256(report_path.read_bytes()).hexdigest(),
    "cases":cases,
}
pathlib.Path("build/qualification/m4.json").write_text(json.dumps(out,indent=2)+"\n",encoding="utf-8")
print(f'M4 PASS: {len(cases)} qualification cases')
PY

echo "M4 qualification evidence: build/qualification/m4.json"
