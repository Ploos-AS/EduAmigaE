# Pointers to OBJECT

## Goal

After this lesson you should be able to combine `OBJECT`, `PTR TO`, `NEW`, and `END` into a dynamically allocated structure with named fields.

## From value to dynamic object

Previously we used a local `point` directly. Now we declare:

```text
DEF p:PTR TO point
```

`p` is not the point itself. It is a pointer that can refer to a `point` structure.

After `NEW p` and checking `p <> NIL`, fields can be accessed directly through the pointer:

```text
p.x := 10
p.y := 20
```

Finally, `END p` releases the allocation.

## Example

See `examples/13-object-pointers/object-pointer.e`. The qualification case is `object-pointer-e33` and expects `point=10,20`.

## Ownership

The example keeps the same simple ownership rule as the dynamic-memory lesson: the procedure allocates the object, uses it, and releases it before returning.

When structures later start pointing to other structures, this becomes more important: we must know who owns each allocation and in what order allocations are released.

## Change it

Add a third field named `z`, assign a value, and print all three fields.

## Think

What is the difference between a local `DEF p:point` and `DEF p:PTR TO point` followed by `NEW p`?

## Exercise

Create an `OBJECT measurement` with two fields. Allocate it through a typed pointer, fill its fields, print them, and release the object.

## Challenge

Draw the object and the pointer relationship. Clearly mark which part is the pointer value and which part is the dynamically allocated structure.

## Summary

A `PTR TO` an `OBJECT` lets us work with dynamic structures. This is the building block needed before structures begin linking to other structures.
