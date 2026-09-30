#!/bin/sh
# Compile one EduAmigaE source file with a user-supplied E-VO installation.
# The exact compiler invocation is intentionally isolated in this adapter.

set -eu

if [ "$#" -lt 2 ]; then
    echo "usage: $0 SOURCE OUTPUT" >&2
    exit 2
fi

src=$1
out=$2

: "${EVO_HOME:?Set EVO_HOME to your E-VO installation}"

# E-VO is an Amiga-native toolchain. The executor supplies EVO_RUNNER,
# allowing real hardware, an emulator, or amiga-runtime to implement the
# actual Amiga command execution without changing course cases.
: "${EVO_RUNNER:?Set EVO_RUNNER to an executable Amiga command adapter}"

if [ ! -f "$src" ]; then
    echo "source not found: $src" >&2
    exit 2
fi

mkdir -p "$(dirname "$out")"

# Contract with the runner:
#   EVO_RUNNER compile EVO_HOME SOURCE OUTPUT
exec "$EVO_RUNNER" compile "$EVO_HOME" "$src" "$out"
