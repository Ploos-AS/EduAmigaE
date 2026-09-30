# 04 — Loops

## Goal

Learn to repeat code in a controlled way and understand the loop variable, starting value, and end condition.

## Example

```e
PROC main()
  DEF i
  FOR i := 1 TO 5
    WriteF('\d\n', i)
  ENDFOR
ENDPROC
```

**Compatibility:** E33.

`FOR` gives us a clear loop when the range is known in advance. Here `i` takes the values 1 through 5 and the body runs once for each value.

## Run and change it

```sh
eduamigae build examples/04-loops/loops.e
eduamigae run build/loops
```

Change the end value. Then use `i` in an expression inside the loop.

## Think

How many times does the body run from 1 through 5? What is the final value actually used?

## Exercise

Print the numbers 1 through 10 and the square of each number.

## Challenge

Use a variable as an accumulator and calculate the sum of the numbers 1 through 10.

## Summary

Loops make repetition explicit. Together with IF they describe much of the control flow in small programs. The next chapter moves reusable logic into procedures.
