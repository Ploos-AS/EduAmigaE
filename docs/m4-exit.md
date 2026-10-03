# M4 exit qualification

M4 introduces AmigaOS programming through Exec and DOS resource lifetimes.

## Learning contract

M4 covers:

1. the AmigaOS acquire/check/use/release ownership model
2. Exec library and borrowed-resource lifetimes
3. DOS file handles and deterministic file I/O
4. current-task and signal fundamentals
5. message ports, messages, request/reply and in-flight ownership
6. device and I/O request lifetimes
7. synchronous device I/O with DoIO()
8. asynchronous device I/O with SendIO(), CheckIO() and WaitIO()
9. cancellation with AbortIO() followed by WaitIO()
10. cleanup after partial acquisition and error paths

## Qualification contract

M4 qualification candidates may exist before they are locked.

A case is added to `qualification/milestones/m4.json` only after it has been compiled with the pinned E-VO 3.9.4 toolchain and exercised through the intended amiga-runtime profiles. Repository CI or source review alone is not qualification.

M4 PASS requires every locked M4 case to compile, PASS every declared profile, match deterministic expected stdout exactly, and leave zero FAIL or SKIP results.

## Current gate

The initial M4 device cases are qualification candidates, not locked cases:

- `open-timer-e33.json`
- `timer-doio-e33.json`
- `cancel-timer-e33.json`

The asynchronous CheckIO demonstration is intentionally not a locked exact-stdout candidate yet because its intermediate "in flight" observation is timing-dependent.

The M4 manifest remains empty until actual E-VO 3.9.4 and amiga-runtime qualification establishes the first locked case.

## Evidence

Once cases are locked, `scripts/qualify-m4.sh` materializes only the manifest, requires zero FAIL and zero SKIP, and writes `build/qualification/m4.json` containing hashes of the manifest, aggregate report, and locked cases.

M4 must not be reported as PASS while its locked manifest is empty.
