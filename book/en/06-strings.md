# 06 — Strings

## Goal

Learn to treat text as data and pass a string to `WriteF`.

## Example

```e
PROC main()
  DEF name
  name := 'Amiga'
  WriteF('Hello, \s!\n', name)
ENDPROC
```

**Compatibility:** E33.

The variable `name` refers to the text `'Amiga'`. In the format string, `\s` means that a string is inserted at that position.

## Run and change it

```sh
eduamigae build examples/06-strings/strings.e
eduamigae run build/strings
```

Change the name and add another text value. Print both in the same `WriteF` call.

## Think

A number and a string are both data, but why does `WriteF` need different formatting information for them?

## Exercise

Create `machine` and `language` variables and print a complete sentence containing both.

## Challenge

Create a procedure that accepts a string parameter and prints a simple welcome message.

## Summary

Strings let programs work with text as data. Later we will examine how strings are actually represented in memory.
