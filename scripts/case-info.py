#!/usr/bin/env python3
import json, pathlib, re, sys

if len(sys.argv) not in {2,4} or (len(sys.argv) == 4 and sys.argv[2] != "--field"):
    raise SystemExit("usage: case-info.py CASE [--field FIELD]")
p=pathlib.Path(sys.argv[1])
d=json.loads(p.read_text(encoding="utf-8"))
required=("id","source","output","compatibility","expected","profiles")
missing=[k for k in required if k not in d]
if missing:
    raise SystemExit("missing case fields: "+", ".join(missing))
if d["compatibility"] not in {"E33","EVO","ECX"}:
    raise SystemExit("unsupported compatibility")
safe_name=re.compile(r"^[A-Za-z0-9._-]+$")
if not isinstance(d["id"],str) or not safe_name.fullmatch(d["id"]):
    raise SystemExit("unsafe case id")
if not isinstance(d["output"],str) or not safe_name.fullmatch(d["output"]):
    raise SystemExit("unsafe output name")
if not isinstance(d["profiles"], list) or not d["profiles"]:
    raise SystemExit("profiles must be a non-empty list")
if any(not isinstance(x,str) or not safe_name.fullmatch(x) for x in d["profiles"]):
    raise SystemExit("unsafe profile name")
q=pathlib.PurePosixPath(d["source"])
if q.is_absolute() or ".." in q.parts:
    raise SystemExit("unsafe source path")
build=d.get("build","")
if build:
    if not isinstance(build,str):
        raise SystemExit("build must be a string")
    b=pathlib.PurePosixPath(build)
    if b.is_absolute() or ".." in b.parts or not build.startswith("scripts/"):
        raise SystemExit("unsafe build helper path")
fields={
    "id":d["id"], "source":d["source"], "output":d["output"],
    "compatibility":d["compatibility"], "profiles":",".join(d["profiles"]),
    "build":build
}
if len(sys.argv) == 4:
    key=sys.argv[3]
    if key not in fields:
        raise SystemExit("unknown field")
    print(fields[key])
else:
    print(json.dumps(fields,separators=(",",":")))
