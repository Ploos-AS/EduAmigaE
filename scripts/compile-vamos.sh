#!/bin/sh
set -eu

src=${1:?usage: compile-vamos.sh SOURCE OUTPUT}
out=${2:?missing output}

: "${EVO_HOME:?Set EVO_HOME to imported E-VO 3.9.4}"
: "${VAMOS_CONFIG:?Set VAMOS_CONFIG to a qualified vamos configuration}"
: "${VAMOS_SYSTEM:?Set VAMOS_SYSTEM to the host directory mounted as system:}"

command -v vamos >/dev/null 2>&1 || { echo "vamos not found" >&2; exit 69; }
test -f "$src" || { echo "source not found: $src" >&2; exit 66; }
test -d "$EVO_HOME" || { echo "EVO_HOME not found: $EVO_HOME" >&2; exit 66; }
test -f "$VAMOS_CONFIG" || { echo "VAMOS_CONFIG not found: $VAMOS_CONFIG" >&2; exit 66; }
test -d "$VAMOS_SYSTEM" || { echo "VAMOS_SYSTEM not found: $VAMOS_SYSTEM" >&2; exit 66; }

guide="$EVO_HOME/E-VO.guide"
test -f "$guide" && grep -q 'Amiga E-VO v3\.9\.4' "$guide" || {
  echo "EVO_HOME is not pinned E-VO 3.9.4" >&2; exit 65;
}

if [ -n "${EDUAMIGAE_COMPILE_WORKDIR:-}" ]; then
  work=$EDUAMIGAE_COMPILE_WORKDIR
  mkdir -p "$work"
  cleanup_work=0
else
  work=$(mktemp -d)
  cleanup_work=1
fi
cleanup() {
  [ "$cleanup_work" -eq 0 ] || rm -rf "$work"
}
trap cleanup EXIT HUP INT TERM
cp "$src" "$work/input.e"

# Locate an executable supplied by an installed/release distribution.
evo=""
for p in "$EVO_HOME/EVO" "$EVO_HOME/Bin/EVO" "$EVO_HOME/bin/EVO"; do
  if [ -f "$p" ]; then evo="$p"; break; fi
done
test -n "$evo" || { echo "E-VO executable not found in EVO_HOME" >&2; exit 66; }
cp "$evo" "$work/EVO"

# Modules remain a separate volume so the compiler sees the imported,
# version-matched module tree without modifying it.
modules=""
for p in "$EVO_HOME/Modules" "$EVO_HOME/modules"; do
  if [ -d "$p" ]; then modules="$p"; break; fi
done
test -n "$modules" || { echo "E-VO Modules directory not found" >&2; exit 66; }

set +e
vamos -c "$VAMOS_CONFIG" -H disable -m 20000 \
  --cwd work: \
  -V "system:$VAMOS_SYSTEM" \
  -V "work:$work" \
  -V "emodules:$modules" \
  work:EVO work:input NOPROGRESS IGNORECACHE
rc=$?
set -e

if [ "$rc" -ne 0 ]; then
  echo "E-VO compile failed under vamos: rc=$rc" >&2
  exit "$rc"
fi

test -f "$work/input" || { echo "E-VO returned success but produced no executable" >&2; exit 1; }
mkdir -p "$(dirname "$out")"
cp "$work/input" "$out"
