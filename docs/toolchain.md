# EduAmigaE toolchain strategy

Status: M0 research decision.

## Goals

The teaching toolchain should:

- teach recognisable Amiga E rather than a substantially different descendant language
- produce native classic-Amiga programs
- retain 68000 as an important compatibility target
- be reproducible for students
- avoid dependence on private Ploos infrastructure
- separate freely redistributable components from components students must supply themselves
- allow examples to be qualified automatically where practical

## Primary candidate: E-VO

E-VO is the preferred compiler candidate for the course.

Reasons:

- it is derived from the original Amiga E compiler
- it remains actively maintained
- it adds bug fixes and useful extensions
- it retains classic Amiga/m68k focus
- 68000 remains a supported target
- source is available

The course should teach the portable/core Amiga E language first. E-VO-specific extensions must be identified explicitly rather than silently becoming prerequisites for beginner examples.

## Reference compiler: original EC

The original Amiga E compiler remains the semantic and historical reference.

EduAmigaE should preserve a compatibility lane for original E 3.3a where practical. This gives the course a stable baseline and makes old source code materially useful to students.

We should not assume that every component of the historical Amiga E distribution has identical redistribution terms. Compiler, modules, examples and support files must be audited separately before packaging.

## Secondary compiler: ECX

ECX is useful as an advanced compatibility target but is not proposed as the beginner baseline.

Important differences include:

- classic 68k target requires 68020+FPU
- it also targets newer Amiga-family systems
- its redistribution terms include restrictions that require careful treatment

ECX therefore belongs in a later portability/compiler-comparison section rather than defining the core course environment.

## Experimental validation: ecomp

The modern browser-oriented ecomp implementation is interesting as an additional validation path because it targets E 3.3a semantics and can generate classic Amiga executables.

It is not currently the canonical compiler for EduAmigaE. It may later be useful for:

- differential tests
- browser exercises
- CI validation
- checking core-language compatibility

## Student environment

The student environment should have two layers.

### Host layer

A reproducible public OCI image contains tools that are legally redistributable and useful on the student's modern host.

Its responsibilities may include:

- course helper scripts
- archive handling
- source validation
- test orchestration
- emulator integration
- publishing/exercise utilities

### Amiga layer

The actual classic-Amiga compiler environment runs in an emulator/runtime or on real hardware.

Proprietary Kickstart ROMs and Workbench material must never be bundled merely for convenience. Students provide legally obtained copies when required.

## Compatibility policy

Examples are classified explicitly:

- **E33** — intended to remain compatible with original Amiga E 3.3a
- **EVO** — intentionally uses E-VO functionality
- **ECX** — ECX-specific or portability exercise

Beginner material should default to E33-compatible source unless there is a clear educational reason to use an E-VO extension.

## CPU baseline

Core lessons should prefer code that can run on a 68000-class Amiga where the compiler/runtime permits it.

CPU-specific optimization is taught later and must be labelled.

This keeps the relationship between E and the original Amiga hardware visible and prevents an accidental 68020+FPU requirement from entering the beginner course.

## Next qualification work

Before M1 is declared complete:

1. pin an E-VO release
2. inventory every required module/support file
3. record the license and redistribution status of each component
4. build a minimal E33-compatible program
5. run it on the course runtime
6. repeat with E-VO
7. define expected compiler output and test evidence
8. build the public student OCI/bootstrap path
9. verify the complete workflow from a clean machine
