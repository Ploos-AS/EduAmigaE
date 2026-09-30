#!/usr/bin/env python3
"""Verify captured stdout for an EduAmigaE qualification case."""

import argparse
import json
from pathlib import Path

p = argparse.ArgumentParser()
p.add_argument("case")
p.add_argument("stdout")
args = p.parse_args()

case = json.loads(Path(args.case).read_text(encoding="utf-8"))
actual = Path(args.stdout).read_text(encoding="utf-8")
expected = case["expected"]["stdout"]

if actual != expected:
    raise SystemExit(
        "FAIL %s: stdout mismatch\nexpected=%r\nactual=%r"
        % (case["id"], expected, actual)
    )

print("PASS %s" % case["id"])
