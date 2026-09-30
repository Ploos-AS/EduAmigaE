# Student environment

EduAmigaE separates the public course environment from licensed Amiga assets and compiler distributions.

## What the course provides

The repository provides:

- source material
- examples and exercises
- qualification manifests
- host-side validation/orchestration
- version pins
- adapter contracts for compiler and runtime execution

A future student OCI image will package these redistributable host-side components.

## What the student may need to provide

Depending on the selected execution path:

- E-VO 3.9.4
- a legal AmigaOS environment
- a legal Kickstart ROM
- an emulator, real Amiga, or compatible runtime executor

The repository does not treat public availability as permission to redistribute third-party software.

## Adapter model

Two small interfaces keep course content independent of a specific emulator.

### Compiler adapter

```text
EVO_RUNNER compile EVO_HOME SOURCE OUTPUT
```


It executes the Amiga-native E-VO compiler in the selected environment.

### Runtime adapter

```text
AMIGA_RUNNER run LANE EXECUTABLE STDOUT_FILE
```


It starts the generated executable in the requested qualification profile and captures observable text output.

`amiga-runtime` can implement these interfaces later, but it is not required by the course specification.

## Why this split matters

The same lesson can therefore run through:

- Ploos qualification infrastructure
- a local emulator
- another compatible emulator
- real Amiga hardware

without rewriting the lesson or pretending that proprietary assets belong to EduAmigaE.
