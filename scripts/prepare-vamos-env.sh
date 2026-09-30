#!/bin/sh
set -eu
root=${1:-build/vamos-env}
rm -rf "$root"
mkdir -p "$root/system"
cp qualification/vamos/.vamosrc "$root/.vamosrc"
echo "VAMOS_CONFIG=$root/.vamosrc"
echo "VAMOS_SYSTEM=$root/system"
