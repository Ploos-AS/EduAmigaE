# 00 — Getting started

The goal is to go from source code to a runnable Amiga program and understand the three parts of the first program.

## First program

```e
PROC main()
  WriteF('Hello from EduAmigaE!\n')
ENDPROC
```

**Compatibility:** E33 — the example should be expressible without E-VO-specific language extensions.

`PROC main()` starts the program's main procedure. `WriteF()` writes text. `ENDPROC` ends the procedure.

## Run it

With the student environment and E-VO 3.9.4 provisioned:

```sh
eduamigae build examples/00-hello/hello.e
eduamigae run build/hello
```

## Change it

Replace the text with your own message, rebuild, and observe that the program flow stays the same while the data changes.

## Think

Why is the text data, while `PROC`, `WriteF`, and `ENDPROC` describe program structure and action?

## Exercise

Create a program that prints two lines. First use two `WriteF()` calls. Then try one string containing a newline.

## Challenge

Print your name, machine type, and one goal for the course on three separate lines.

## Summary

You have seen source code, a procedure, a function call, a string, and the build/run cycle. The next chapter moves from fixed text to values and variables.
