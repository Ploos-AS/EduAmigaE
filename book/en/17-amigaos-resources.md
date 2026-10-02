# Resources in AmigaOS

## Goal

After this lesson you should be able to explain the basic lifetime of an AmigaOS resource and plan cleanup before using concrete Exec and DOS APIs.

## From memory to operating-system resources

In M3 we used `NEW` and `END` and made ownership explicit. AmigaOS programming extends the same idea, but the resource may now be a file, library, port, message, device, or I/O request.

The central model is:

```text
acquire -> check -> use -> release
```

A successful acquire gives the program a resource or handle that must later be released with the API operation belonging to that resource.

## Check before use

An acquire operation can fail. The program must therefore check its result before using the resource. A failed acquire does not give the program a valid resource to use or release.

## Release in reverse order

When resources depend on each other, a useful general rule is to release them in the reverse order in which they were acquired:

```text
acquire A
  acquire B
    acquire C
    release C
  release B
release A
```

This becomes especially important when only part of startup succeeds.

## One responsibility per resource

For every resource, you should be able to answer four questions:

1. Who acquires it?
2. How do we know acquisition succeeded?
3. Who owns it while it is in use?
4. Which operation ends its lifetime?

If one answer is unclear, the cleanup model is unclear too.

## Why no qualification case yet?

This chapter establishes the contract before binding the course to concrete Exec and DOS functions. The next chapters use real E-VO 3.9.4 modules and AmigaOS APIs, and executable cases are locked only after syntax and runtime assumptions have been checked.

## Summary

M3 taught ownership of memory and data structures. M4 extends the same discipline to operating-system resources: acquire, check, use, and release.
