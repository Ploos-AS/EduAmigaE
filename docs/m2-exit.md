# M2 exit qualification

M2 is the Amiga E fundamentals milestone.

It is complete only when the beginner course content exists **and** the executable fundamentals have been qualified with the pinned toolchain and runtime.

## Content contract

The Norwegian and English editions must cover the same learning path:

1. first program and build/run cycle
2. values and variables
3. expressions and operators
4. conditional control flow
5. loops
6. procedures, parameters and return values
7. strings
8. arrays and indexing
9. structured data with `OBJECT`
10. modules
11. debugging and error categories

Examples intended as executable course baselines are marked `E33`.

## Qualification contract

M2 PASS requires:

1. E-VO 3.9.4 is independently provisioned.
2. Every JSON case in `qualification/cases/` parses successfully.
3. Every M2 source compiles through the pinned E-VO/vamos path.
4. Every declared runtime profile returns PASS through `amiga-runtime`.
5. Guest stdout matches the case exactly.
6. The aggregate qualification report contains zero FAIL and zero SKIP.
7. The report is retained as milestone evidence.

A missing external E-VO installation is **SKIP**, never PASS.

A compiler failure, runtime failure, output mismatch, malformed case, or failed declared profile is **FAIL**.

## Educational exit

After M2, a learner should be able to write a small E33-compatible command-line program using variables, expressions, decisions, repetition, procedures, strings, arrays, structured data and imported modules, and use a systematic process to diagnose errors.

AmigaOS-specific APIs, pointers and explicit memory management are not required for M2. Those belong to later milestones.
