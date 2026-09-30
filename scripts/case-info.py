#!/usr/bin/env python3
import json, pathlib, re, shlex, sys

if len(sys.argv) != 2:
    raise SystemExit("usage: case-info.py CASE")
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
for key,value in {
    "ID":d["id"],"SOURCE":d["source"],"OUTPUT":d["output"],
    "COMPATIBILITY":d["compatibility"],"PROFILES":",".join(d["profiles"])
}.items():
    print(key+"="+shlex.quote(value))
