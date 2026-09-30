# Addresses and pointers

## Goal

After this lesson you should be able to explain the difference between a value and its address, declare a typed pointer with `PTR TO`, obtain an address, and read a value through a pointer.

## Concept

An ordinary variable contains a value. A pointer contains the address of data elsewhere in memory. In Amiga E, `PTR TO LONG` can express that a pointer is used with a `LONG`.

The example uses `{value}` to obtain the address of `value`. The expression `^p` reads the value pointed to by `p`.

## Example

See `examples/11-pointers/pointers.e`.

The program creates a `LONG` containing 42, points `p` at it, and reads the same value through the pointer.

## Run it

Build and test the example through the EduAmigaE tools. The qualification case is `pointers-e33`.

## Change it

Change the initial value from 42 to another value. Predict both numbers in the output before running the program.

## Think

Why is it useful for the pointer type to describe what exists at the address?

## Exercise

Create two `LONG` variables and one `PTR TO LONG`. Point it at the first variable and then the second, printing the value after each change.

## Challenge

Explore the distinction between the pointer value itself, the address it contains, and the data read through the pointer. Do not use dynamic allocation yet.

## Summary

`PTR TO` describes a typed pointer, `{value}` can obtain a value's address, and `^p` can dereference the pointer. Next comes mutation through pointers, followed by explicit allocation and release.
