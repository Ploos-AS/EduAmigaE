# 03 — Choosing with IF

## Goal

Learn to make a program choose between alternative actions.

## Example

```e
PROC main()
  DEF value
  value := 42
  IF value > 10
    WriteF('large\n')
  ELSE
    WriteF('small\n')
  ENDIF
ENDPROC
```

**Compatibility:** E33.

The comparison `value > 10` supplies the condition. When it is true the first branch runs; otherwise the `ELSE` branch runs.

## Run and change it

```sh
eduamigae build examples/03-control-flow/control-flow.e
eduamigae run build/control-flow
```

Try the values 10, 11, and -1. Then replace `>` with another comparison.

## Multiple choices with SELECT

When one value is compared with several concrete alternatives, `SELECT` can be clearer than a long chain of `IF` statements:

```e
PROC main()
  DEF value
  value := 2
  SELECT value
  CASE 1; WriteF('one\n')
  CASE 2; WriteF('two\n')
  CASE 3; WriteF('three\n')
  ENDSELECT
ENDPROC
```

Source: `examples/03-control-flow/select.e`. This pattern is also used by the E-VO 3.9.4 sources.

## Think

What happens exactly at the boundary value 10? Why are boundary values important when testing programs?

## Exercise

Write a program that prints `positive` when a number is greater than zero and `not positive` otherwise.

## Challenge

Extend it to three cases: negative, zero, and positive.

## Summary

Control flow lets data affect which instructions execute. The next step is repetition with loops.
