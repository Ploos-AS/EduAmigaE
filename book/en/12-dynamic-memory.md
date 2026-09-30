# Dynamic memory with NEW and END

## Goal

After this lesson you should be able to allocate memory with `NEW`, check whether allocation succeeded, use the memory through a pointer, and release it with `END`.

## Concept

So far our pointers have referred to variables that already existed. Sometimes a program must request storage while it runs. Amiga E provides `NEW` for this.

For a `PTR TO LONG`, the pattern can be:

```text
NEW p
IF p <> NIL
  ^p := 12345
  ...
  END p
ENDIF
```

Here, `NIL` means that we did not obtain a usable pointer. The program must therefore check the result before dereferencing it.

`END p` releases the allocation. After release, the program must not continue using that memory through `p`.

## Example

See `examples/12-dynamic-memory/new-end.e`. The qualification case is `new-end-e33`.

The example has one clear owner: the same procedure that performs `NEW p` is responsible for `END p`.

## Ownership and lifetime

For every dynamically allocated region, you should be able to answer three questions:

1. Who owns the allocation?
2. How long is it valid?
3. Where is it released?

A useful introductory rule is: **one successful `NEW` should have one clearly corresponding `END`**. Later we will encounter control flow and system resources that require more advanced cleanup.

## Dynamic arrays

`NEW` can also allocate multiple elements. The example `examples/12-dynamic-memory/dynamic-array.e` uses:

```text
NEW arr[5]
...
END arr[5]
```

Between those points, `arr` can be indexed as `arr[0]` through `arr[4]`. The size is part of both allocation and release, so this introductory example keeps the count visible and identical in both places.

The `dynamic-array-e33` qualification case expects the values 0, 10, 20, 30 and 40.

## Run it

Build and test the example. Normal output is `allocated=12345`.

## Change it

Change the value written through `^p`. Follow the pointer from declaration through allocation and use to release.

## Think

What could happen if the program used `^p` without first checking that `p <> NIL`?

## Exercise

Create another `PTR TO LONG`, allocate it, store a value, print it, and release the allocation.

## Challenge

Draw the allocation lifetime as a line from successful `NEW` to `END`. Mark every point where the pointer is used.

## Summary

`NEW` creates dynamic storage, its result must be checked, and `END` ends the lifetime. These ideas form the basis for ownership and later AmigaOS resources.
