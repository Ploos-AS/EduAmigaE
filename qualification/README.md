# EduAmigaE qualification

Qualification proves that course examples build and behave as documented.

## Principles

- source compatibility and runtime compatibility are separate claims
- no private Ploos service is required by the contract
- ROMs and proprietary AmigaOS files are never committed here
- compiler version, target profile, exit result and observable output form part of the evidence
- failures must remain visible rather than being silently skipped

## Initial lanes

| Lane | Compiler | Source class | Runtime target |
|---|---|---|---|
| e33-a500 | EC 3.3a compatible | E33 | A500-class / 68000 |
| evo-a500 | E-VO 3.9.4 | E33 + EVO as applicable | A500-class / 68000 |
| evo-a1200 | E-VO 3.9.4 | E33 + EVO as applicable | A1200 / 68020 |

The EC lane may initially be manual until its complete legal/toolchain bootstrap is qualified.

## Evidence

For each case record:

- case id
- source hash
- compiler identity/version
- compatibility class
- target CPU/profile
- compile result
- executable hash where practical
- runtime result
- captured/verified observable output
- timestamp/executor metadata

```text
PASS = required compile and runtime assertions succeeded
FAIL = an assertion was attempted and failed
SKIP = prerequisite unavailable; reason is mandatory
```

SKIP must never be reported as PASS.

## First case

`hello-e33` compiles `examples/00-hello/hello.e` and expects:

```text
Hello from EduAmigaE!
```

The source intentionally avoids E-VO extensions.
