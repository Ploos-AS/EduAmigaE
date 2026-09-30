#!/usr/bin/env python3
import json, pathlib, sys

if len(sys.argv) != 3:
    raise SystemExit("usage: materialize-milestone.py MANIFEST DEST")

manifest=pathlib.Path(sys.argv[1])
dest=pathlib.Path(sys.argv[2])
d=json.loads(manifest.read_text(encoding="utf-8"))
if d.get("schema") != 1 or not isinstance(d.get("milestone"),str):
    raise SystemExit("invalid milestone manifest")
items=d.get("cases")
if not isinstance(items,list) or not items:
    raise SystemExit("milestone must contain cases")
if len(items) != len(set(items)):
    raise SystemExit("duplicate case in milestone manifest")
dest.mkdir(parents=True,exist_ok=True)
root=pathlib.Path("qualification/cases").resolve()
for name in items:
    if not isinstance(name,str) or pathlib.PurePosixPath(name).name != name or not name.endswith(".json"):
        raise SystemExit(f"invalid case filename: {name!r}")
    src=(root/name).resolve()
    try:
        src.relative_to(root)
    except ValueError:
        raise SystemExit(f"case escapes qualification directory: {name}")
    if not src.is_file():
        raise SystemExit(f"milestone case not found: {name}")
    target=dest/name
    target.write_bytes(src.read_bytes())
print(len(items))
