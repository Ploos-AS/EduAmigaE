# Your own modules and program boundaries

## Goal

After this lesson you should be able to explain why a larger program is split into modules, distinguish a public API from internal implementation, and read a simple Amiga E program that imports its own module.

## Module source

The example `examples/16-own-module/modules/edumath.e` begins with:

```text
OPT MODULE
```

This marks the source file as a module. The procedure intended to be public is exported explicitly:

```text
EXPORT PROC doubleValue(value) IS value * 2
```

This is the module's small API.

## The client

`main.e` imports the module:

```text
MODULE 'edumath'
```

The rest of the program only needs to know the exported operation. The module can change how its implementation is organized without making the client own that code.

## Why this boundary matters

As programs grow, we do not want one enormous source file. A good module boundary makes responsibilities explicit, reduces coupling, and makes code easier to test and reuse.

This becomes especially important in M4 when system code begins managing Exec, DOS, and other AmigaOS resources.

## Build and qualification

This is a multi-file example. The source forms `OPT MODULE`, `EXPORT PROC`, and `MODULE` have been checked against E-VO 3.9.4, but we do not lock an executable qualification case until the module's actual compile/install/import sequence has been run and verified with the pinned E-VO toolchain.

This keeps syntax/provenance separate from actual toolchain qualification.

## Change it

Add an exported procedure that triples a number and call it from `main.e`.

## Think

What should be public in a module, and what should remain an implementation detail?

## Exercise

Sketch a module with two public operations and at least one internal helper operation.

## Challenge

Split the list code from the previous lesson into a public list API and a client. Decide which details the client actually needs to know.

## Summary

`OPT MODULE` creates the module boundary, `EXPORT` describes the public API, and `MODULE` imports that API for the client. We can now organize larger programs without mixing every responsibility into one file.
