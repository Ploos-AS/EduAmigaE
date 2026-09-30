#!/bin/sh
set -eu

: "${EVO_HOME:?EVO_HOME must point to an imported E-VO 3.9.4 distribution}"
command -v amiga-runtime >/dev/null 2>&1 || {
  echo "amiga-runtime is required for M1 runtime qualification" >&2
  exit 69
}

eduamigae doctor
eduamigae qualify qualification/cases/hello-e33.json

mkdir -p build/qualification
python3 - <<'PY'
import hashlib, json, pathlib, subprocess
src=pathlib.Path("examples/00-hello/hello.e")
exe=pathlib.Path("build/qualification/hello")
out={
  "schema":1,
  "milestone":"M1",
  "case":"hello-e33",
  "source_sha256":hashlib.sha256(src.read_bytes()).hexdigest(),
  "executable_sha256":hashlib.sha256(exe.read_bytes()).hexdigest() if exe.exists() else None,
  "status":"PASS" if exe.exists() else "FAIL"
}
pathlib.Path("build/qualification/m1.json").write_text(json.dumps(out,indent=2)+"\n")
if out["status"] != "PASS":
    raise SystemExit(1)
PY

echo "M1 qualification evidence: build/qualification/m1.json"
