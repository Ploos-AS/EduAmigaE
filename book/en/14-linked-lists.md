# A simple linked list

## Goal

After this lesson you should be able to create a self-referential `OBJECT`, link dynamically allocated nodes, traverse the list, and release the nodes.

## A node that points to the next node

A singly linked list can be built from nodes containing both data and a pointer to the next node:

```text
OBJECT node
  value:LONG
  next:PTR TO node
ENDOBJECT
```

The `next` field has the same structural type as the object containing it. This is a self-referential data structure.

## Two nodes

The example in `examples/14-linked-list/linked-list.e` allocates `first` and `second`. It then sets:

```text
first.next := second
second.next := NIL
```

`NIL` marks the end of the list.

## Traversal

A separate pointer, `current`, starts at the first node. While it is not `NIL`, the node is used and the pointer advances:

```text
current := first
WHILE current <> NIL
  WriteF('node=\d\n', current.value)
  current := current.next
ENDWHILE
```

This pattern is fundamental to many dynamic data structures.

## Cleanup

The example knows in advance that there are at most two nodes, so it releases `second` and then `first`. Later we will generalize cleanup so a list of arbitrary length can be released by traversal.

The `linked-list-e33` qualification case expects two lines: `node=10` and `node=20`.

## Change it

Add a third node containing 30 and connect it between `second` and `NIL`.

## Think

Why does traversal use a separate `current` pointer instead of advancing `first` itself?

## Exercise

Build a three-node list and print every value by following `next`.

## Challenge

Sketch an algorithm that can release a list of unknown length without losing the address of the next node.

## Summary

A self-referential `OBJECT` can represent a node, `next` connects nodes, `NIL` ends the chain, and a separate pointer can traverse the list. Next comes general insertion and cleanup.
