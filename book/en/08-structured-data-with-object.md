# 08 — Structured data with OBJECT

## Goal

Learn to collect related values with different meanings into one named data structure.

## Example

```e
OBJECT point
  x, y
ENDOBJECT

PROC main()
  DEF p:point
  p.x := 10
  p.y := 20
  WriteF('point=\d,\d\n', p.x, p.y)
ENDPROC
```

**Compatibility:** E33.

E uses `OBJECT` both as the foundation of object-oriented programming and as a practical structure type. Here we use only the structure part. `point` describes the shape of the data, while `p` is a variable of that type.

Fields are accessed with a dot: `p.x` and `p.y`.

## Run and change it

```sh
eduamigae build examples/08-objects/objects.e
eduamigae run build/objects
```

Add a `z` field, assign it a value, and print all three coordinates.

## Think

An array collects many elements with the same role. An OBJECT can give each field its own name and meaning. When is each model a better fit?

## Exercise

Define `OBJECT rectangle` with `width` and `height` fields. Calculate the area of a variable of that type.

## Challenge

After the pointer chapter, return and write a procedure receiving a `PTR TO point`. For now, create two `point` variables and calculate the difference between their coordinates.

## Summary

`OBJECT` provides structured data. It is also the foundation of E's object model and many AmigaOS structures, but methods, inheritance, dynamic allocation, and pointers come later.
