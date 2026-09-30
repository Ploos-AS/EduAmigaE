#!/usr/bin/env python3
import json, pathlib, sys

if len(sys.argv) != 2:
    raise SystemExit("usage: case-info.py CASE")
p=pathlib.Path(sys.argv[1])
d=json.loads(p.read_text(encoding="utf-8"))
required=("id","source","output","compatibility","expected","profiles")
missing=[k for k in required if k not in d]
if missing:
    raise SystemExit("missing case fields: "+", ".join(missing))
if not isinstance(d["profiles"], list) or not d["profiles"]:
    raise SystemExit("profiles must be a non-empty list")
for value in (d["source"], d["output"]):
    q=pathlib.PurePosixPath(value)
    if q.is_absolute() or ".." in q.parts:
        raise SystemExit("unsafe case path")
print("ID="+d["id"])
print("SOURCE="+d["source"])
print("OUTPUT="+d["output"])
print("COMPATIBILITY="+d["compatibility"])
print("PROFILES="+",".join(d["profiles"]))
