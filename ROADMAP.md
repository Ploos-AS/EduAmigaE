# EduAmigaE Roadmap

## M0 — Foundation

- [x] Define project purpose and audience
- [x] Establish bilingual policy: Norwegian primary, English parallel
- [x] Define course contract and learning model
- [x] Require public, reproducible student workflow
- [x] Establish CC BY 4.0 for original course material
- [x] Define web, EPUB, Kindle and PDF publication targets
- [x] Define student OCI as a project requirement
- [x] Complete toolchain and redistribution research
- [x] Establish repository skeleton and automated checks

M0 exit criterion: the project can move into implementation without changing its educational or distribution model.

## M1 — Student toolchain

Create and qualify the reproducible development environment.

- [x] select and pin the Amiga E toolchain
- [x] document licensing and redistribution constraints
- [x] create the student OCI/bootstrap workflow
- [x] provide a minimal hello-world source/build contract
- [x] document native/alternative execution lanes
- [x] provide manifest-driven build/runtime qualification tooling
- [x] provide a dedicated M1 qualification workflow and evidence artifact
- [ ] validate the student OCI from a clean environment
- [ ] record an end-to-end E-VO 3.9.4 hello-world compile PASS
- [ ] record amiga-runtime PASS for every hello-e33 profile

Exit: a student can obtain the public materials and build the first program without private Ploos infrastructure. See `docs/m1-exit.md` for the evidence contract.

## M2 — E fundamentals

Implement the beginner path through values, variables, expressions, control flow, procedures, strings, arrays, structured data, modules and debugging.

- [x] first-program workflow
- [x] values and variables
- [x] expressions and arithmetic operators
- [x] conditional control flow
- [x] loops and repetition
- [x] procedures, parameters and return values
- [x] strings
- [x] arrays and indexing
- [x] structured data with OBJECT
- [x] module imports and module-source model
- [x] systematic debugging and error categories
- [x] Norwegian and English chapter parity
- [x] runnable qualification cases for the executable fundamentals
- [ ] validate every M2 qualification case with E-VO 3.9.4
- [ ] record amiga-runtime PASS for every declared M2 profile
- [ ] retain a complete M2 exit report

Exit: the learner can write, structure and debug small E33-compatible programs without AmigaOS-specific programming. See `docs/m2-exit.md`.

## M3 — E beyond the basics

Cover lists, objects, pointers, addresses, memory, modules, larger program structure, E idioms and machine-aware programming.

- [x] addresses and typed pointers
- [x] dereferencing and mutation through pointers
- [x] dynamic allocation and release with NEW/END
- [x] dynamically allocated arrays
- [x] pointers to OBJECT structures
- [x] self-referential structures and linked-list traversal
- [x] ownership and general list cleanup
- [x] introduce own-module/API boundaries
- [x] Norwegian and English chapter parity for implemented M3 material
- [ ] qualify the own-module compile/install/import sequence with E-VO 3.9.4
- [ ] lock the own-module executable case after toolchain qualification
- [ ] validate every locked M3 qualification case with E-VO 3.9.4
- [ ] record amiga-runtime PASS for every declared M3 profile
- [ ] retain a complete M3 exit report

Exit: the learner can reason about addresses, ownership, dynamic structures and module boundaries before AmigaOS-specific resource management. See `docs/m3-exit.md`.

## M4 — AmigaOS programming

Cover Exec and DOS fundamentals, libraries, devices, files, processes, messages, ports, ownership and resource cleanup.

- [ ] establish the AmigaOS resource ownership model
- [ ] Exec fundamentals and library/resource lifetimes
- [ ] DOS fundamentals, files and CLI interaction
- [ ] processes/tasks and execution context
- [ ] message ports and messages
- [ ] devices and I/O requests
- [ ] cleanup paths for partial acquisition and errors
- [ ] Norwegian and English chapter parity
- [ ] executable M4 qualification cases
- [ ] retain a complete M4 exit report

Exit: the learner can acquire, validate, use and release core AmigaOS resources without leaking them or using invalid handles.

## M5 — Intuition, graphics and interaction

Cover windows, gadgets, event loops, screens, graphics, input and timing with progressively larger programs.

## M6 — Real applications

Build complete guided projects and introduce code-reading/maintenance exercises using representative Amiga E programs.

## M7 — Publication

Complete Norwegian and English editions and qualify all publication outputs:

- web
- EPUB
- Kindle
- PDF

## M8 — Course qualification

Run the complete course from a clean student environment and verify every example, exercise path and project.

Exit: a learner can independently design, implement, debug and explain a non-trivial native Amiga E application.
