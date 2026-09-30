# M1 exit qualification

M1 is complete only when the first-program path is demonstrated from a clean, public student setup without private Ploos build dependencies.

Required evidence:

1. the open student environment passes `eduamigae doctor`;
2. an independently obtained official E-VO 3.9.4 distribution is imported/provisioned;
3. `examples/00-hello/hello.e` compiles through the pinned E-VO/vamos lane;
4. the generated Amiga Hunk is executed through amiga-runtime;
5. every profile declared by `hello-e33` passes;
6. guest stdout exactly matches the case expectation;
7. qualification evidence is retained.

The public CI remains independent of E-VO. Full M1 qualification runs only on an explicitly provisioned runner or equivalent local environment.

A missing E-VO prerequisite is SKIP, never PASS. A compile, runtime or assertion failure is FAIL.
