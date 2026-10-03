# Qualification runner

EduAmigaE runtime qualification is intentionally separated from ordinary repository CI.

## Required runner labels

The Qualification workflow requires a self-hosted GitHub Actions runner with all of these labels:

```text
self-hosted
eduamigae
amiga-runtime
```

## Required software

The runner must provide:

- E-VO 3.9.4 outside the repository
- `EVO_HOME` pointing at that imported distribution
- `amiga-runtime` on `PATH`
- Python 3 and the normal repository shell tools

The workflow verifies that `$EVO_HOME/E-VO.guide` exists. Qualification scripts additionally run `eduamigae doctor`.

No Kickstart, AmigaOS files, or E-VO distribution are committed to EduAmigaE.

## Preflight

Before enabling the runner for qualification, run the repository preflight:

```sh
sh scripts/qualification-preflight.sh
```

The script requires E-VO, `amiga-runtime`, repository checks and the student-environment doctor to pass. It also validates the first M4 candidate and its declared profiles.

The two runtime profiles used by the first candidate are:

```text
amiga-ocs-68000-1m
a1200-020
```

## First qualification run

Trigger the `Qualification` workflow manually.

The dependency chain is:

```text
M1 -> M2 -> M3 -> M4
```

This is deliberate. M4 evidence is meaningful only after the lower-level course gates have passed on the same workflow run.

At present the M4 manifest is intentionally empty. Therefore M4 must stop with:

```text
M4 has no locked qualification cases yet
```

until a candidate has first been independently exercised and approved for locking.

## First M4 candidate

The first candidate is:

```text
qualification/cases/open-timer-e33.json
```

It must compile with E-VO 3.9.4 and PASS both declared amiga-runtime profiles with exact stdout:

```text
timer.device opened
```

Only after that evidence exists should it be added to `qualification/milestones/m4.json`.

## Evidence rule

Ordinary GitHub Actions CI, source review, or successful JSON validation is not runtime qualification. Do not mark a milestone PASS or lock a candidate solely from those signals.
