#!/usr/bin/env python3
import hashlib, json, pathlib, sys

if len(sys.argv) != 2:
    raise SystemExit("usage: promote-m4-candidate.py EVIDENCE.json")

root=pathlib.Path(__file__).resolve().parent.parent
evp=pathlib.Path(sys.argv[1])
if not evp.is_absolute(): evp=root/evp
ev=json.loads(evp.read_text(encoding="utf-8"))
if ev.get("schema") != 1 or ev.get("milestone") != "M4" or ev.get("status") != "CANDIDATE_PASS":
    raise SystemExit("evidence is not an M4 CANDIDATE_PASS")

item=ev.get("case") or {}
rel=item.get("path")
if not isinstance(rel,str) or not rel.startswith("qualification/cases/"):
    raise SystemExit("invalid evidence case path")
case_path=root/rel
case=json.loads(case_path.read_text(encoding="utf-8"))
if ev.get("id") != case.get("id"):
    raise SystemExit("evidence id does not match case")
digest=hashlib.sha256(case_path.read_bytes()).hexdigest()
if item.get("sha256") != digest:
    raise SystemExit("case changed since candidate qualification")
if item.get("compatibility") != case.get("compatibility") or item.get("profiles") != case.get("profiles"):
    raise SystemExit("evidence metadata does not match case")

name=case_path.name
cp=root/"qualification/m4-candidates.json"
mp=root/"qualification/milestones/m4.json"
c=json.loads(cp.read_text(encoding="utf-8"))
m=json.loads(mp.read_text(encoding="utf-8"))
if name not in c.get("cases",[]):
    raise SystemExit(f"{name} is not an M4 candidate")
if name in m.get("cases",[]):
    raise SystemExit(f"{name} is already locked")

c["cases"].remove(name)
m.setdefault("cases",[]).append(name)
cp.write_text(json.dumps(c,indent=2)+"\n",encoding="utf-8")
mp.write_text(json.dumps(m,indent=2)+"\n",encoding="utf-8")
print(f"promoted M4 candidate: {name}")
print("run: sh scripts/check-repo.sh")
