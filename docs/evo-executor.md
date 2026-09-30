# E-VO executor contract

Canonical compiler: E-VO 3.9.4.

E-VO is an Amiga-native compiler. EduAmigaE therefore treats compilation as a guest operation rather than a Linux host command.

## Installation assumptions

A user-supplied E-VO installation exposes:

- the compiler through the Amiga command path
- its Modules directory as `EMODULES:`

The course does not commit the E-VO distribution.

## Canonical compile command

For AmigaOS 2.04+ the baseline invocation is conceptually:

```text
EVO source.e NOPROGRESS IGNORECACHE
```

The compiler writes an executable using the source basename.

For qualification we deliberately avoid optimisation initially. Optimised output is a separate later lane so that the first language tests exercise the simplest compiler path.

## Executor interface

```text
EVO_RUNNER compile EVO_HOME SOURCE OUTPUT
```

The runner must:

1. stage SOURCE into the guest-visible workspace;
2. expose the user-supplied E-VO installation;
3. add E-VO BIN to the guest command path;
4. assign EMODULES: to the matching Modules directory;
5. invoke E-VO 3.9.4;
6. preserve compiler stdout/stderr or console evidence;
7. verify that the expected executable was produced;
8. copy that executable to OUTPUT;
9. emit machine-readable evidence.

A compiler process returning success without the expected executable is FAIL.

## Version rule

The M1 canonical lane requires 3.9.4. Development builds and other releases require an explicit non-canonical lane and must not silently satisfy the 3.9.4 qualification.
