# vamos compile lane

E-VO upstream uses vamos in its own Linux CI to build the compiler, compile its unit tests and execute them.

EduAmigaE therefore distinguishes two useful mechanisms:

1. **vamos compile lane** — fast compiler/source qualification on a Linux host or student OCI;
2. **amiga-runtime lane** — runtime qualification using an Amiga-family guest/emulator profile.

The vamos lane does not replace runtime qualification. It proves that E-VO can process course source and produce the expected m68k artifact in the configured environment.

## Policy

- E-VO remains user-supplied/imported unless redistribution is deliberately approved.
- The canonical compiler version remains 3.9.4.
- The course should not depend on upstream private CI images.
- A Ploos student OCI may install redistributable vamos tooling independently and mount/import E-VO.
- Actual generated programs are subsequently passed to amiga-runtime for Q2/Q3 and, where available, Q4/Q5 qualification.

This split keeps edit/compile cycles fast while retaining genuine Amiga runtime evidence.
