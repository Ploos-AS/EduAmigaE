#!/usr/bin/env python3
import hashlib, json, pathlib, shutil, subprocess, tempfile

ROOT=pathlib.Path(__file__).resolve().parent.parent
PROMOTE=ROOT/"scripts/promote-m4-candidate.py"
CASE="open-library-e33.json"

def writej(p,d): p.write_text(json.dumps(d,indent=2)+"\n",encoding="utf-8")
def run(root, evidence):
    script=root/"scripts/promote-m4-candidate.py"
    return subprocess.run(["python3",str(script),str(evidence)],cwd=root,text=True,capture_output=True)

with tempfile.TemporaryDirectory() as td:
    t=pathlib.Path(td)
    (t/"scripts").mkdir(); (t/"qualification/cases").mkdir(parents=True); (t/"qualification/milestones").mkdir()
    shutil.copy2(PROMOTE,t/"scripts/promote-m4-candidate.py")
    shutil.copy2(ROOT/"qualification/cases"/CASE,t/"qualification/cases"/CASE)
    writej(t/"qualification/m4-candidates.json",{"schema":1,"milestone":"M4","status":"CANDIDATES","cases":[CASE]})
    writej(t/"qualification/milestones/m4.json",{"schema":1,"milestone":"M4","cases":[]})
    cp=t/"qualification/cases"/CASE
    case=json.loads(cp.read_text())
    evidence={"schema":1,"milestone":"M4","status":"CANDIDATE_PASS","id":case["id"],
              "case":{"path":f"qualification/cases/{CASE}","sha256":hashlib.sha256(cp.read_bytes()).hexdigest(),
                      "compatibility":case["compatibility"],"profiles":case["profiles"]}}
    ep=t/"evidence.json"; writej(ep,evidence)

    r=run(t,ep); assert r.returncode==0,r.stderr
    assert CASE not in json.loads((t/"qualification/m4-candidates.json").read_text())["cases"]
    assert CASE in json.loads((t/"qualification/milestones/m4.json").read_text())["cases"]

    # reset and reject non-pass evidence
    writej(t/"qualification/m4-candidates.json",{"schema":1,"milestone":"M4","status":"CANDIDATES","cases":[CASE]})
    writej(t/"qualification/milestones/m4.json",{"schema":1,"milestone":"M4","cases":[]})
    bad=dict(evidence); bad["status"]="FAIL"; writej(ep,bad)
    assert run(t,ep).returncode != 0

    # reject stale evidence after case content changes
    writej(ep,evidence); cp.write_text(cp.read_text()+"\n",encoding="utf-8")
    assert run(t,ep).returncode != 0

print("M4 promotion structural tests: PASS")
