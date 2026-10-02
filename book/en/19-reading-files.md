# Reading files and completing the lifetime

## Goal

After this lesson you should be able to use DOS file handles in separate phases and understand that every successful `Open()` creates a new ownership lifetime.

## Two different resources

The example `examples/19-dos-read/read-file.e` first creates a file with `MODE_NEWFILE`, writes known text, and closes the handle. It then opens the same file name with `MODE_OLDFILE`.

This is not one long ownership lifetime. It is two:

```text
Open for write -> Write -> Close
Open for read  -> Read  -> Close
```

After the first `Close()`, the first handle's lifetime has ended. The second `Open()` must succeed before there is a new handle from which to read.

## Check the byte count

E-VO 3.9.4's DOS definition is `Read(file, buffer, length)`. Upstream examples check that its return value equals the number of bytes they expected to read.

The course example does the same. Only after `Read()` returns the complete length do we add a zero terminator and print the text with `WriteF()`.

## Buffer boundary

The buffer contains 32 bytes while the example reads a short, known string. The position at `buffer[length]` is reserved for the zero terminator after the read.

In later code where file sizes come from external input, buffer capacity and read bounds must be treated as explicit safety requirements.

## Cleanup on failure

Notice that every successful `Open()` has its own `Close()`, even if the following `Write()` or `Read()` does not return the expected result.

This is the resource model from chapter 17 applied twice in sequence.

## Qualification

The example is expected to print:

```text
read=EduAmigaE
```

The case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Summary

A file name is not the same thing as an open file handle. Every successful `Open()` begins a new resource lifetime that ends with its own `Close()`.
