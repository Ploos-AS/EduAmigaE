#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"

fail() {
  echo "qualification preflight: FAIL: $*" >&2
  exit 1
}

: "${EVO_HOME:?EVO_HOME must point to E-VO 3.9.4}"
[ -f "$EVO_HOME/E-VO.guide" ] || fail "missing $EVO_HOME/E-VO.guide"

command -v python3 >/dev/null 2>&1 || fail "python3 not found"
command -v amiga-runtime >/dev/null 2>&1 || fail "amiga-runtime not found on PATH"

sh scripts/check-repo.sh
sh scripts/eduamigae doctor

casefile=qualification/cases/open-timer-e33.json
python3 scripts/case-info.py "$casefile" >/dev/null

profiles=$(python3 scripts/case-info.py "$casefile" --field profiles)
oldifs=$IFS
IFS=,
for profile in $profiles; do
  IFS=$oldifs
  case "$profile" in
    amiga-ocs-68000-1m|a1200-020) ;;
    *) fail "unexpected first-candidate profile: $profile" ;;
  esac
  IFS=,
done
IFS=$oldifs

echo "qualification preflight: PASS"
echo "first M4 candidate: $casefile"
echo "profiles: $profiles"
echo "next: sh scripts/eduamigae qualify $casefile"
