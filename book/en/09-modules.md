# 09 — Modules

## Goal

Understand why E uses modules, how a program imports one, and how module source separates a public interface from implementation.

## Importing a module

```e
MODULE 'exec/types'

PROC main()
  WriteF('module import ok\n')
ENDPROC
```

**Compatibility:** E33.

`MODULE` makes declarations from a module available to the source file. The module name is not a private Ploos dependency; this example uses a standard module from the Amiga E/E-VO environment.

```sh
eduamigae build examples/09-modules/modules.e
eduamigae run build/modules
```

## What module source looks like

Classic Amiga E module sources use this form:

```e
OPT MODULE
OPT EXPORT

/* declarations and code exported by the module */
```

A module can also use `MODULE '...'` for its own dependencies. Larger E programs can therefore be divided into layers rather than putting all code in one file.

Building custom `.m` modules is covered later with the toolchain and larger project structure. We do not pretend that ordinary program compilation and module generation are the same operation.

## Think

What is the difference between copying the same declaration into ten source files and importing one module?

## Exercise

Find three standard modules in the E-VO distribution's `Modules` tree and note what their names tell you about the subsystem they belong to.

## Challenge

Sketch a program with three responsibilities and propose how they could be divided into modules. No code is required yet.

## Summary

Modules are E's mechanism for reuse and organization across source files. We will rely on them heavily when entering the AmigaOS APIs.
