# amiga-runtime integration

EduAmigaE consumes the public Ploos-AS/amiga-runtime contract instead of implementing emulator control itself.

## Profile mapping

The E33 fundamentals currently qualify against two runtime profiles:

| EduAmigaE use | amiga-runtime profile |
|---|---|
| 68000 / OCS baseline | `amiga-ocs-68000-1m` |
| 68020 cross-check | `a1200-020` |

The runtime entry point used by the student CLI is:

```sh
amiga-runtime test-hunk PROGRAM --profile PROFILE
```

The declared profiles live in each qualification case. Milestones select cases; they do not silently replace the profiles declared by those cases.

## Evidence levels

EduAmigaE adopts the evidence model from amiga-runtime. A successful emulator launch alone is not proof that the expected E program ran.

Classic AmigaOS qualification may use separately provisioned legal Kickstart and AmigaOS assets where required. Those assets remain outside both repositories and redistributable student images.

## Machine-readable guest output

For `eduamigae test`, a runtime invocation receives a fresh evidence directory through `AMIGA_RUNTIME_EVIDENCE`. EduAmigaE requires `result.json` from that directory.

A successful result must expose captured guest stdout through:

```json
{
  "status": "PASS",
  "guest_output": {
    "stdout": "guest-console.txt"
  }
}
```

The stdout value is treated as a path relative to the evidence directory. `scripts/evidence-stdout.py` rejects absolute paths and traversal outside that directory, requires the referenced file to exist, and only accepts PASS evidence. The captured file is then compared with the case's exact expected stdout by `scripts/verify-case.py`.

This makes the qualification chain explicit:

```text
E-VO source
  -> compiled Amiga Hunk
  -> amiga-runtime test-hunk
  -> result.json PASS
  -> guest_output.stdout
  -> exact case-output verification
```

## Integration boundary

amiga-runtime owns emulator/runtime execution, machine profiles and runtime evidence generation. EduAmigaE owns course cases, expected output, milestone selection and validation of the evidence it consumes.

The two projects therefore remain independently testable: EduAmigaE does not need emulator-specific control code, and amiga-runtime does not need knowledge of EduAmigaE lessons.
