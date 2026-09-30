#!/usr/bin/env python3
import json, pathlib, sys

if len(sys.argv) != 3:
    raise SystemExit("usage: evidence-stdout.py RESULT_JSON EVIDENCE_DIR")

result=pathlib.Path(sys.argv[1])
root=pathlib.Path(sys.argv[2]).resolve()
d=json.loads(result.read_text(encoding="utf-8"))
if d.get("status") != "PASS":
    raise SystemExit("runtime qualification did not PASS")
rel=d.get("guest_output",{}).get("stdout")
if not isinstance(rel,str) or not rel:
    raise SystemExit("runtime result has no guest stdout evidence")
p=pathlib.PurePosixPath(rel)
if p.is_absolute() or ".." in p.parts:
    raise SystemExit("unsafe guest stdout path")
target=(root / pathlib.Path(*p.parts)).resolve()
try:
    target.relative_to(root)
except ValueError:
    raise SystemExit("guest stdout escapes evidence directory")
if not target.is_file():
    raise SystemExit("guest stdout evidence file is missing")
print(target)
