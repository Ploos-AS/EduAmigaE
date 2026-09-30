# amiga-runtime integration

EduAmigaE consumes the public Ploos-AS/amiga-runtime contract instead of implementing emulator control itself.

## Profile mapping

| EduAmigaE lane | amiga-runtime profile |
|---|---|
| e33-a500 | a500 |
| evo-a500 | a500 |
| evo-a1200 | a1200-020 |

The runtime entry point is `amiga-runtime test PROGRAM --profile PROFILE`.

## Evidence levels

EduAmigaE adopts Q0 through Q5 from amiga-runtime. In particular, AROS Q2/Q3 evidence must never be relabelled as classic AmigaOS Q4 evidence.

Classic Q4 may use separately provisioned legal Kickstart and AmigaOS assets. Those assets remain outside both repositories and redistributable images.

## Current boundary

amiga-runtime already defines the input/evidence mounts, runtime command and machine profiles. The EduAmigaE adapter therefore binds to those interfaces now.

Until a stable captured-output evidence path is exposed to the consumer, the adapter returns SKIP unless `AMIGA_RUNTIME_STDOUT` points to verified guest output. A successful emulator launch alone is not proof that the expected E program ran.

The next integration task is to consume a stable machine-readable guest-output/evidence field from amiga-runtime.
