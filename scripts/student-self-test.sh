#!/bin/sh
set -eu

command -v python3 >/dev/null
command -v vamos >/dev/null
test -f "${VAMOS_CONFIG:?VAMOS_CONFIG not set}"
test -d "${VAMOS_SYSTEM:?VAMOS_SYSTEM not set}"

python3 - <<'PY'
import amitools
print("amitools: PASS")
PY

python3 - <<'PY'
from amitools.vamos.main import main
print("vamos module: PASS")
PY

echo "student environment: PASS"

if [ -d "${EVO_HOME:-}" ] && [ -f "${EVO_HOME}/E-VO.guide" ]; then
  if grep -q 'Amiga E-VO v3\.9\.4' "${EVO_HOME}/E-VO.guide"; then
    echo "E-VO 3.9.4: PRESENT"
  else
    echo "E-VO: PRESENT but not pinned 3.9.4"
    exit 1
  fi
else
  echo "E-VO 3.9.4: NOT PROVISIONED (expected until user imports/mounts it)"
fi
