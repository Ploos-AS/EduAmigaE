# Ownership and general list cleanup

## Goal

After this lesson you should be able to build a list through a procedure, modify a pointer through a pointer-to-pointer, and release a list of arbitrary length without losing the remainder of the chain.

## Changing the list head

If a procedure receives only the value of `head`, it can work with the node, but it needs the address of the pointer variable itself to replace the list head. The example therefore uses:

```text
PROC pushFront(head:PTR TO PTR TO node, value)
```

The caller passes `{head}`. Inside the procedure, `head[]` is the original pointer value.

A new node is inserted at the front by pointing it at the old head and then replacing the head:

```text
n.next := head[]
head[] := n
```

## Cleanup without losing the next node

Release is the critical moment. After `END current`, fields in that node can no longer be relied upon. The next address must therefore be saved first:

```text
next := current.next
END current
current := next
```

`freeList()` repeats this until `current = NIL`. The algorithm does not know the number of nodes in advance.

## Ownership

In this example, the list owns every node inserted by `pushFront()`. `freeList()` ends the lifetime of the complete chain.

This gives a simple contract: whoever receives the completed list head must ensure that `freeList()` is called exactly once when the list is no longer needed.

## Example

See `examples/15-list-ownership/list-ownership.e`. Three calls to `pushFront()` build the list 10 → 20 → 30. The `list-ownership-e33` qualification case checks traversal.

## Change it

Insert a fourth value. Predict the order before running the program.

## Think

Why does `freeList()` save `current.next` before `END current`, rather than afterwards?

## Exercise

Write a procedure that counts nodes without changing the list head.

## Challenge

Sketch how a procedure that removes the first node could transfer ownership correctly while also updating `head`.

## Summary

A pointer-to-pointer makes it possible to change a caller's pointer. During cleanup, the next address must be preserved before the current node is released. This gives us a general ownership model for dynamic chains.
