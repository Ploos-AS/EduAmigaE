# Asynchronous I/O with SendIO

## Goal

After this lesson you should be able to start a device operation without blocking, check whether the request is still active, and wait for completion before cleanup.

## SendIO returns early

`DoIO()` waited until the operation completed. `SendIO()` instead starts the request and returns control to the program.

```text
SendIO(request)
      |
      +--> device works
      |
      +--> program continues
```

From this point the request is **in flight**.

## CheckIO

The Exec FD defines `CheckIO(ioRequest)`. It lets the program check whether an asynchronous request has already completed without waiting.

The example uses:

```text
completed := CheckIO(request)
IF completed = NIL
  WriteF('timer request in flight\n')
ENDIF
```

The timer is short, so it may in principle already have completed before the check. Only the final completion line is therefore suitable as mandatory deterministic qualification output; the `in flight` text must be treated as timing-dependent.

## WaitIO establishes completion

Whether the request has already completed or is still running, we call:

```text
WaitIO(request)
```

After `WaitIO()` returns, the request is complete and can again be treated as a local resource.

```text
SendIO
   |
   v
IN FLIGHT
   |
 CheckIO   optional observation
   |
 WaitIO
   |
   v
COMPLETE
```

## No cleanup while active

We must not do this after `SendIO()` and before completion:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

The device may still be using the request and its reply port.

Cleanup can continue only after `WaitIO()`.

## Example

See `examples/28-device-async/timer-async.e`.

The stable final line is:

```text
timer request complete
```

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution. Timing-dependent `CheckIO()` text must not be used as the sole expected stdout.

## Cancellation

What if the program must exit before the request completes? `DeleteIORequest()` is not the answer.

The correct pattern is:

```text
AbortIO(request)
WaitIO(request)
```

The upstream E-VO 3.9.4 `extra_examples/clock.e` uses exactly this sequence when exiting with an active timer request. This is the next lesson.

## Summary

`SendIO()` makes the request in flight. `CheckIO()` can observe completion without blocking. `WaitIO()` establishes that the operation has truly completed before the request, device, and port are cleaned up.
