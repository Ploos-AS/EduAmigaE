# DOS files and handles

## Goal

After this lesson you should be able to open a file through DOS, validate the file handle, write data, and close the file at the correct point.

## DOS as a resource API

An open file is a resource with a clear lifetime. E-VO 3.9.4's DOS definitions include:

```text
Open(name, accessMode)
Write(file, buffer, length)
Close(file)
```

The `dos/dos` module defines `MODE_NEWFILE`, among other constants.

## Acquire and check

The example opens `T:eduamigae-m4.txt`:

```text
file := Open('T:eduamigae-m4.txt', MODE_NEWFILE)
```

Only when `file` is valid does the program continue to `Write()`. `T:` is used because this is temporary data rather than a file the course should leave behind permanently.

## Use and release

The program measures the text with `StrLen()`, writes exactly that number of bytes, and stores the result from `Write()`. It then closes the handle with `Close(file)`.

It is important not to postpone `Close()` merely because we also want to inspect the write result. Once writing has finished, the open handle is no longer needed.

## Partial failure

Two failure paths are interesting:

- `Open()` fails: no file resource was acquired, so `Close()` must not be called.
- `Write()` does not write the expected number of bytes: we still own the open file and must close it.

This is the M4 model in practice: cleanup is determined by what was actually acquired, not by whether the rest of the operation succeeded.

## Example

See `examples/18-dos-files/write-file.e`. On the success path the program prints `file write ok`.

The qualification case is locked only after compilation with E-VO 3.9.4 and execution through the declared amiga-runtime profiles.

## Summary

DOS file handles are owned resources. Check the result of `Open()`, use the handle only when valid, and call `Close()` on every path that actually owns the file.
