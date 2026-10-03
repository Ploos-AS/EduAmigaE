# Exec message ports

## Goal

After this lesson you should be able to create an Exec message port, obtain the port's signal mask, and end the port lifetime without separately releasing its internal resources.

## A port combines a queue and a signal

A message port is more than a signal. It combines a message queue with the mechanism that notifies a task when work is available.

E-VO 3.9.4 defines `OBJECT mp` in `exec/ports`. The structure includes:

```text
sigbit
sigtask
msglist
```

These show the two central aspects of a port: who is notified and the queue containing messages.

## Acquire and release

The Exec FD defines:

```text
CreateMsgPort()
DeleteMsgPort(port)
```

This is the resource pair we use. If `CreateMsgPort()` succeeds, the program owns the port and must later call `DeleteMsgPort()`.

## The port's signal bit

The port already has a `sigbit`. E-VO 3.9.4's own `extra_examples/clock.e` constructs the signal mask like this:

```text
timer_sig := Shl(1, msg.sigbit)
```

The course example does the equivalent:

```text
portMask := Shl(1, port.sigbit)
```

This does **not** mean that the program should call `FreeSignal(port.sigbit)`. The signal setup is part of the resource created by `CreateMsgPort()` and ended by `DeleteMsgPort()`.

This is composite ownership: one higher-level resource may own several internal resources.

## Example

See `examples/23-message-port/create-port.e`.

On the success path we expect:

```text
message port ready
```

We do not print the signal bit number because it may vary between executions.

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Where this leads

We now have a port that can notify the task. The next step is the message protocol itself: the message structure, `PutMsg()`, `WaitPort()`, `GetMsg()`, and `ReplyMsg()`.

## Summary

`CreateMsgPort()` creates a port with queue and signal integration. Use `mp.sigbit` to construct a wait mask, but let `DeleteMsgPort()` release the port's internal resources.
