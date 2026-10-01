#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"
CLI="$ROOT/scripts/eduamigae"

: "${EVO_HOME:?EVO_HOME must point to an imported E-VO 3.9.4 distribution}"
command -v amiga-runtime >/dev/null 2>&1 || {
  echo "amiga-runtime is required for M3 runtime qualification" >&2
  exit 69
}

"$CLI" doctor
mkdir -p build/qualification
report=build/qualification/m3-cases.json
manifest=qualification/milestones/m3.json
cases_tmp=$(mktemp -d)
trap 'rm -rf "$cases_tmp"' EXIT HUP INT TERM
python3 scripts/materialize-milestone.py "$manifest" "$cases_tmp" >/dev/null

set +e
"$CLI" qualify-all "$cases_tmp" "$report"
rc=$?
set -e
[ "$rc" -eq 0 ] || {
  echo "M3 qualification cases did not produce a complete PASS (rc=$rc)" >&2
  exit "$rc"
}

python3 - "$report" <<'PY'
import hashlib, json, pathlib, sys

report_path=pathlib.Path(sys.argv[1])
report=json.loads(report_path.read_text(encoding="utf-8"))
if report.get("fail") != 0 or report.get("skip") != 0:
    raise SystemExit("M3 requires zero FAIL and zero SKIP")
if report.get("pass") != report.get("total") or not report.get("total"):
    raise SystemExit("M3 requires every locked case to PASS")

manifest_path=pathlib.Path("qualification/milestones/m3.json")
manifest=json.loads(manifest_path.read_text(encoding="utf-8"))
cases=[]
for name in manifest["cases"]:
    p=pathlib.Path("qualification/cases") / name
    d=json.loads(p.read_text(encoding="utf-8"))
    cases.append({
        "id": d["id"],
        "path": p.as_posix(),
        "sha256": hashlib.sha256(p.read_bytes()).hexdigest(),
        "compatibility": d["compatibility"],
        "profiles": d["profiles"],
        "build": d.get("build"),
    })

out={
    "schema":1,
    "milestone":"M3",
    "status":"PASS",
    "case_count":len(cases),
    "manifest_sha256":hashlib.sha256(manifest_path.read_bytes()).hexdigest(),
    "report_sha256":hashlib.sha256(report_path.read_bytes()).hexdigest(),
    "cases":cases,
}
pathlib.Path("build/qualification/m3.json").write_text(
    json.dumps(out,indent=2)+"\n", encoding="utf-8"
)
print(f'M3 PASS: {len(cases)} qualification cases')
PY

echo "M3 qualification evidence: build/qualification/m3.json"
