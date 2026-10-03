#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"
CLI="$ROOT/scripts/eduamigae"

casearg=${1:?usage: qualify-m4-candidate.sh CASE.json}
case "$casearg" in
  */*|*..*) echo "candidate must be a filename from qualification/cases" >&2; exit 64 ;;
esac
casefile="qualification/cases/$casearg"
[ -f "$casefile" ] || { echo "candidate not found: $casefile" >&2; exit 66; }

python3 - "$casearg" <<'PY'
import json, pathlib, sys
name=sys.argv[1]
p=pathlib.Path("qualification/m4-candidates.json")
d=json.loads(p.read_text(encoding="utf-8"))
if d.get("schema") != 1 or d.get("milestone") != "M4" or d.get("status") != "CANDIDATES":
    raise SystemExit("invalid M4 candidate manifest")
if name not in d.get("cases", []):
    raise SystemExit(f"not an approved M4 candidate: {name}")
PY

: "${EVO_HOME:?EVO_HOME must point to an imported E-VO 3.9.4 distribution}"
command -v amiga-runtime >/dev/null 2>&1 || { echo "amiga-runtime is required" >&2; exit 69; }

id=$(python3 scripts/case-info.py "$casefile" --field id)
profiles=$(python3 scripts/case-info.py "$casefile" --field profiles)
[ "$profiles" = "amiga-ocs-68000-1m,a1200-020" ] || {
  echo "M4 candidate must declare the two qualification profiles" >&2; exit 65;
}

python3 - "$casearg" <<'PY'
import json, pathlib, sys
name=sys.argv[1]
m=json.loads(pathlib.Path("qualification/milestones/m4.json").read_text())
if name in m.get("cases", []):
    raise SystemExit(f"{name} is already locked in M4; use qualify-m4.sh")
PY

"$CLI" doctor
"$CLI" qualify "$casefile"

mkdir -p build/qualification
python3 - "$casefile" "$id" <<'PY'
import hashlib,json,pathlib,sys
p=pathlib.Path(sys.argv[1]); d=json.loads(p.read_text())
out={"schema":1,"milestone":"M4","status":"CANDIDATE_PASS","id":sys.argv[2],
     "case":{"path":p.as_posix(),"sha256":hashlib.sha256(p.read_bytes()).hexdigest(),
             "compatibility":d["compatibility"],"profiles":d["profiles"]}}
dst=pathlib.Path("build/qualification")/f"m4-candidate-{sys.argv[2]}.json"
dst.write_text(json.dumps(out,indent=2)+"\n")
print(f"M4 CANDIDATE_PASS: {sys.argv[2]}")
print(f"evidence: {dst}")
PY
