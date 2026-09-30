# EduAmigaE Course Contract

## Audience

EduAmigaE is for learners who may know nothing about Amiga E and only limited programming. It should also remain useful to experienced Amiga programmers who want a structured path into E.

## Learning model

Each lesson should normally follow this rhythm:

1. **Goal** — what the student will be able to do
2. **Concept** — the minimum theory needed
3. **Example** — a small complete program
4. **Run it** — exact reproducible steps
5. **Change it** — guided modification
6. **Think** — questions about why it works
7. **Exercise** — independent task
8. **Challenge** — optional deeper task
9. **Summary** — concepts and vocabulary

## Curriculum requirements

The complete course must cover at least:

- installation and development workflow
- compiler/toolchain concepts
- syntax and lexical structure
- primitive values and variables
- operators and expressions
- control flow
- procedures and arguments
- arrays, strings and lists
- records/objects and E idioms
- pointers, addresses and memory
- modules and reusable components
- files and CLI applications
- AmigaOS process/task concepts at an introductory level
- Exec, DOS and Intuition concepts
- opening/closing libraries correctly
- resources and cleanup discipline
- screens, windows, gadgets and events
- graphics fundamentals
- device and input concepts
- error handling and debugging
- performance and optimization
- reading existing Amiga E code
- interfacing with Amiga APIs and foreign code where practical
- packaging and distributing small programs

## Project ladder

The course should build toward progressively larger artifacts rather than disconnected snippets. Candidate projects include:

- text utility
- file inspector
- CLI information tool
- small requester/window application
- graphics demo
- event-driven utility
- final application chosen by the student

## Reproducibility

Every executable example must state the expected environment and commands. The preferred student path is a self-contained OCI-based environment plus documented native alternatives where possible.

The course must not require access to private Ploos services, repositories, runners or credentials.

## Language editions

Norwegian is the primary authoring language. English is maintained as a parallel edition with equivalent technical content rather than a shortened summary.

## Publishing

Source material should remain suitable for the Ploos publishing pipeline and eventual output as:

- HTML/web
- EPUB
- Kindle-compatible ebook
- PDF

## Licensing

Original course prose and educational material: CC BY 4.0.

Example source code should be explicitly licensed when introduced. Third-party tools, compiler components, headers, modules and example-derived material must preserve upstream licensing and redistribution constraints.
