# Open vamos environment

EduAmigaE does not depend on the private filesystem hidden inside the upstream E-VO CI image.

The compile adapter requires three explicit inputs:

- `EVO_HOME` — imported E-VO 3.9.4 distribution
- `VAMOS_CONFIG` — qualified vamos configuration
- `VAMOS_SYSTEM` — redistributable Amiga-compatible system tree mounted as `system:`

The source workspace and E-VO modules are mounted independently as `work:` and `emodules:`.

This mirrors the important property of upstream CI — E-VO executes through vamos — while making every dependency visible and replaceable.

## Qualification boundary

The adapter is implemented, but the Ploos-provided `VAMOS_CONFIG` and `VAMOS_SYSTEM` are not yet qualified. Until they are, this lane is infrastructure-complete but must not be reported as a compiler PASS.

The next task is to construct the smallest redistributable system tree needed by E-VO 3.9.4 and prove the hello-world compile.
