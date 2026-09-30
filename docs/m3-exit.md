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
