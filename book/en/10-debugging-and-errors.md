# 10 — Debugging and errors

## Goal

Learn to distinguish compile-time errors, runtime errors, and logical errors, and use a systematic workflow to find them.

## Three kinds of errors

**Compile-time errors** are detected before the program can run. Invalid syntax and names unknown to the compiler are examples.

**Runtime errors** occur while the program executes. Later in the course, invalid pointers, incorrect resource handling, and OS calls become important examples.

**Logical errors** mean the program runs but produces the wrong result. These are often hardest because the compiler cannot necessarily help.

## A simple method

1. Make the problem reproducible.
2. Reduce it to the smallest possible program.
3. Check assumptions with small diagnostic prints.
4. Test boundary values.
5. Change one thing at a time.
6. Run the same test again.
7. Keep a regression test after fixing the bug.

EduAmigaE qualification cases follow the same idea: known source, known expected output, and explicit runtime profiles.

## Practical exercise

Take the array example from chapter 07. Change one value so your own expected sum becomes wrong. Find the problem by printing the index and value inside the loop.

## Bug hunt

Deliberately create three copies of an earlier example:

- one that does not compile,
- one that compiles but calculates the wrong result,
- one that fails only at a particular boundary value.

Describe how you identified each kind of error.

## Summary

Debugging is not random experimentation. It is a controlled process in which hypotheses are tested against observable behaviour. This habit becomes essential when the course moves on to pointers, memory, and AmigaOS.
