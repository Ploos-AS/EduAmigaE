# Waiting for Exec signals

## Goal

After this lesson you should be able to send a signal mask to a task, wait for signals, and test which bits actually woke the task.

## Signal and Wait

E-VO 3.9.4's Exec FD defines:

```text
Wait(signalSet)
Signal(task, signalSet)
```

`Signal()` receives a task pointer and a **signal mask**. `Wait()` also receives a mask and returns the signal bits that caused the wait to finish.

This is why chapter 21 distinguished the signal number from the signal mask.

## A deterministic teaching example

A real event system normally has another producer: a device, message port, Intuition, or another task. Before introducing those resources, we use a smaller example.

The program:

1. obtains the current task with `FindTask(NIL)`
2. allocates a signal number
3. builds the signal mask
4. sets the signal on the current task with `Signal()`
5. calls `Wait(mask)`
6. checks the returned mask
7. releases the signal number

The signal is set **before** `Wait()`. The bit is therefore already pending when the task waits, so the example does not need another task merely to demonstrate the signalling mechanism.

## Check the returned mask

We test:

```text
IF received AND signalMask
```

This is more important than assuming that any return from `Wait()` represents our event. Later, one event loop will often wait for several bits at once.

```text
received := Wait(portMask OR timerMask OR breakMask)
```

Each relevant bit must then be tested separately.

## Cleanup

The signal number remains the owned resource. It is released after the signal has been consumed.

The example also has a defensive setup-failure path: if the task pointer were unexpectedly invalid after the signal was allocated, the signal is released before the program exits.

## Example

See `examples/22-exec-wait/self-signal.e`.

Expected success output:

```text
signal received
```

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Summary

`Signal()` sets signal bits for a task. `Wait()` waits on a mask and returns which requested bits were received. This is the core mechanism we need before message ports and event loops.
