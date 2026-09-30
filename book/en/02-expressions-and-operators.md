# 02 — Expressions and operators

## Goal

Learn how values are combined into new values with arithmetic operators.

## Example

```e
PROC main()
  DEF a, b, sum, product
  a := 6
  b := 7
  sum := a + b
  product := a * b
  WriteF('sum=\d product=\d\n', sum, product)
ENDPROC
```

**Compatibility:** E33.

An expression computes a value. `a + b` and `a * b` are expressions; their results are stored in variables.

## Run and change it

```sh
eduamigae build examples/02-expressions/expressions.e
eduamigae run build/expressions
```

Try different values and the `+`, `-`, `*`, and integer-division operators. Use parentheses when you want evaluation order to be explicit.

## Think

Why is `a + b * 2` not necessarily the same as `(a + b) * 2`?

## Exercise

Calculate the perimeter of a rectangle from two variables.

## Challenge

Calculate both area and perimeter and print both results.

## Summary

Expressions transform data. The next chapter uses comparisons to choose which code runs.
