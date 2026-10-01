# M3 exit qualification

M3 is the bridge from Amiga E fundamentals to machine-aware and system programming.

## Learning contract

M3 covers:

1. addresses and pointer types
2. dereferencing and mutation through pointers
3. explicit allocation and release
4. ownership, lifetime and cleanup
5. linked/list-oriented data structures
6. larger OBJECT-based structures and E idioms
7. module boundaries in larger programs
8. machine-aware reasoning without depending on AmigaOS APIs

AmigaOS Exec/DOS resource APIs belong to M4. M3 teaches the language and ownership concepts needed before those APIs are introduced.

## Qualification contract

Executable M3 examples are added to a locked milestone manifest only after their syntax has been checked against the pinned E-VO 3.9.4 language/toolchain.

M3 PASS requires every locked M3 case to compile with E-VO 3.9.4, PASS every declared amiga-runtime profile, match expected guest stdout exactly, and leave zero FAIL or SKIP results.

Static syntax/provenance review is not runtime qualification.


## Evidence

The self-hosted qualification workflow runs M3 only after M1 and M2 have passed. `scripts/qualify-m3.sh` materializes the locked M3 manifest, requires every case to PASS with zero SKIP, and writes `build/qualification/m3.json`.

The evidence records hashes of the milestone manifest, aggregate report, and each locked case. Cases with a custom build helper record both the helper path and its SHA-256 in the evidence metadata, so changing the build recipe changes the evidence identity.

The own-module example and `own-module-e33.json` exist, but that case remains outside the locked M3 manifest until its E-VO 3.9.4 multi-file build has actually been qualified. Repository CI success alone does not satisfy this gate.
