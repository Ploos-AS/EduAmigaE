# EduAmigaE toolchain strategy

Status: M0 research decision.

## Pinned baseline

For M1 qualification, the canonical stable compiler is **E-VO 3.9.4**.

Development/nightly builds are not course baselines. A newer stable release may be adopted deliberately after qualification, but examples must not silently depend on it.

The original **Amiga E 3.3a / EC** remains the language-compatibility reference for E33-labelled examples.

## Goals

The teaching toolchain should:

- teach recognisable Amiga E rather than a substantially different descendant language
- produce native classic-Amiga programs
- retain 68000 as an important compatibility target
- be reproducible for students
- avoid dependence on private Ploos infrastructure
- separate freely redistributable components from components students must supply themselves
- allow examples to be qualified automatically where practical

## Primary compiler: E-VO

E-VO is the preferred compiler for the course. It is derived from the original Amiga E compiler, remains actively maintained, adds bug fixes and extensions, and retains the classic Amiga/m68k focus.

The course teaches portable/core Amiga E first. E-VO-specific extensions must be identified explicitly rather than silently becoming prerequisites for beginner examples.

## Reference compiler: original EC

The original Amiga E compiler remains the semantic and historical reference. EduAmigaE preserves an E 3.3a compatibility lane where practical so that historical source remains useful to students.

The original compiler is described by its author as open source/GPL. Historical archives, modules, examples and support files are nevertheless audited component-by-component before redistribution.

## Secondary compiler: ECX

ECX is useful as an advanced compatibility target but is not the beginner baseline. Its CPU requirements and redistribution terms make it unsuitable for defining the core environment.

## Experimental validation: ecomp

The modern ecomp implementation targets E 3.3a semantics and is validated against the historical compiler. It may become an additional validation path for differential tests, browser exercises and CI, but is not the canonical course compiler.

## Redistribution policy

Do not assume that "source available", "open source", "public domain" and "freely redistributable in a Ploos image" are equivalent.

E-VO's published terms permit broad use but include a restriction against selling E-VO or related support programs for profit. Until the exact student-image distribution model has been reviewed against those terms, the OCI must not simply embed the complete E-VO distribution.

Preferred design:

1. the public OCI contains Ploos-owned and clearly redistributable host tooling;
2. a bootstrap/import step obtains or accepts the Amiga E toolchain separately where required;
3. hashes and expected versions make the resulting environment reproducible;
4. Kickstart and Workbench are always user-supplied unless an explicitly redistributable alternative is selected.

This separation also keeps the course usable on real Amiga hardware.

## Compatibility policy

Examples are classified explicitly:

- **E33** — intended to remain compatible with original Amiga E 3.3a
- **EVO** — intentionally uses E-VO functionality
- **ECX** — ECX-specific or portability exercise

Beginner material defaults to E33-compatible source unless there is a clear educational reason to use an E-VO extension.

## CPU baseline

Core lessons prefer code that can run on a 68000-class Amiga where the compiler/runtime permits it.

CPU-specific optimization is taught later and must be labelled.

## M1 qualification matrix

| Component | Baseline | Role | Bundle now? |
|---|---|---|---|
| E-VO | 3.9.4 | canonical compiler | No, pending redistribution review |
| EC | 3.3a | compatibility reference | Pending component audit |
| ecomp | current qualified revision | optional differential/CI compiler | Pending integration review |
| ECX | optional | advanced compatibility | No |
| Kickstart | user-owned | runtime ROM | Never bundle by assumption |
| Workbench/AmigaOS | user-owned | runtime environment | Never bundle by assumption |
| Ploos student tooling | pinned by repo | orchestration | Yes |

## First smoke program

The first qualification source intentionally uses only core E syntax:

```e
PROC main()
  WriteF('Hello from EduAmigaE!\n')
ENDPROC
```

It is classified **E33** and becomes the first compile/run test for both the historical compatibility lane and E-VO.

## Next qualification work

1. inventory E-VO 3.9.4 compiler/modules/support files
2. record provenance and redistribution status for each required component
3. add the E33 hello-world source to the repository
4. define expected compiler/run evidence
5. qualify it under E-VO 3.9.4
6. qualify the E33 lane
7. connect qualification to amiga-runtime where appropriate
8. build the public student OCI/bootstrap path
9. verify the complete workflow from a clean machine
