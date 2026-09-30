# 01 — Values and variables

Programs become useful when they can work with data that can change.

## Goal

After this chapter you should be able to distinguish a fixed value from a variable, declare a simple variable, and use it in output.

## Example

```e
PROC main()
  DEF year
  year := 2026
  WriteF('EduAmigaE year: \d\n', year)
ENDPROC
```

**Compatibility:** E33.

`DEF year` gives the procedure a variable. The assignment `year := 2026` stores the value. `\d` in `WriteF` is the position where the numeric value is printed.

## Run it

```sh
eduamigae build examples/01-values/values.e
eduamigae run build/values
```

## Change it

Change the year. Then add another variable and print both values.

## Think

What is the difference between the number `2026` in the source code and the variable `year` after the program has started?

## Exercise

Create variables `a` and `b`, assign two different integer values, and print each on its own line.

## Challenge

Add a third variable whose value is `a+b`, and print the result.

## Summary

A value is data. A variable gives the program a name for a place where data can be stored and later used. The next step is expressions and operators.
