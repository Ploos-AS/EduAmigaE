# Exec signals

## Goal

After this lesson you should be able to distinguish a signal number from a signal mask and explain how signals fit into Exec's waiting model.

## Signal number and signal mask

Exec uses signal bits to notify tasks about events. Two values must be kept distinct:

- a **signal number** identifies which bit is used
- a **signal mask** is the bit value passed to operations such as `Wait()` and `Signal()`

E-VO 3.9.4's Exec FD defines, among others:

```text
Wait(signalSet)
Signal(task, signalSet)
AllocSignal(signalNum)
FreeSignal(signalNum)
```

An upstream E-VO example constructs masks from signal bits like this:

```text
mask := Shl(1, sigbit)
```

Signal bit 5 and the mask for signal bit 5 are therefore not the same number: the bit number is 5, while the mask has bit 5 set.

## From polling to waiting

Earlier examples have executed sequentially. With `Wait(mask)`, a task can instead wait until one of the selected signal bits is set.

This becomes the basis of later event loops:

```text
event source -> signal bit -> Wait(mask) -> handle event
```

## Ownership

`AllocSignal()` and `FreeSignal()` form a resource pair when a program reserves a signal bit itself. A signal-bit field already owned by another OS resource, such as a message port, must instead follow that resource's ownership rules.

We do not create an `AllocSignal()` qualification example yet. The FD verifies the function signatures, but before teaching a concrete failure test, the return contract must be explicitly verified against authoritative API documentation or a qualified toolchain/runtime result.

## Upstream example

E-VO 3.9.4's `extra_examples/clock.e` includes:

```text
intui_sig := Shl(1, win.userport.sigbit)
timer_sig := Shl(1, msg.sigbit)
```

This is exactly the distinction we need before message ports and event loops.

## Summary

The signal number selects a bit. The signal mask represents that bit in a set. Keep the two concepts separate before using `Wait()`, `Signal()`, or message ports.
