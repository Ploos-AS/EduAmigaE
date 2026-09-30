# 05 — Procedures and parameters

## Goal

Learn to divide a program into named parts, pass data in as parameters, and return a result.

## Example

```e
PROC square(value)
  RETURN value * value
ENDPROC

PROC main()
  DEF result
  result := square(7)
  WriteF('square=\d\n', result)
ENDPROC
```

**Compatibility:** E33.

`square` describes one task. The `value` parameter receives the argument from the call. `RETURN` sends the result back to the expression that called the procedure.

## Run and change it

```sh
eduamigae build examples/05-procedures/procedures.e
eduamigae run build/procedures
```

Try other arguments. Then create a `double(value)` procedure.

## Think

Why is `square(7)` more useful than writing `7*7` everywhere in a larger program?

## Exercise

Create `add(a,b)` that returns the sum of two parameters.

## Challenge

Create small procedures for the area and perimeter of a rectangle and call both from `main`.

## Summary

Procedures give code names, boundaries, and reuse. Parameters move data in; return values move results out. Next come collections of data: strings and arrays.
