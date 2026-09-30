#!/bin/sh
# EduAmigaE E-VO environment contract.
# Source this file or set EVO_HOME before invoking compile-evo.sh.

set -eu

: "${EVO_HOME:?Set EVO_HOME to your legally obtained E-VO installation}"

if [ ! -d "$EVO_HOME" ]; then
    echo "EVO_HOME is not a directory: $EVO_HOME" >&2
    return 2 2>/dev/null || exit 2
fi

export EVO_HOME
