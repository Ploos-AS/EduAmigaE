# Cancellation and safe device cleanup

## Goal

After this lesson you should be able to stop an asynchronous I/O request without releasing resources that the device may still be using.

## The problem

After `SendIO(request)`, the request may be in flight. The program therefore cannot close the device, delete the request, and delete the port while the operation may still reference them.

## Check, abort, wait

The robust pattern is:

```text
IF CheckIO(request) = NIL
  AbortIO(request)
ENDIF

WaitIO(request)
```

`CheckIO()` tells us whether the request has already completed. If it is still active, `AbortIO()` asks the device to stop it. But `AbortIO()` is not proof of completion: `WaitIO()` must still be used before the request can be destroyed.

E-VO 3.9.4's own `extra_examples/clock.e` uses `AbortIO(tr)` followed by `WaitIO(tr)` when exiting with an active timer request.

## The cleanup invariant

`CloseDevice(request)` is permitted only when the request is no longer in flight. For a request submitted with `SendIO()`, `WaitIO()` establishes this point.

We can then clean up in reverse order:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

## Why CheckIO first?

If the operation has already completed, there is no need to attempt cancellation:

```text
already complete -> WaitIO
still active     -> AbortIO -> WaitIO
```

Both paths join at the same safe completion point.

## Example

See `examples/29-device-cancel/cancel-timer.e`.

The example starts a long timer request so that the cancellation path will normally be used. Correctness does not depend on timing: if the request has already completed, we skip `AbortIO()` and still pass through `WaitIO()`.

Stable final line:

```text
timer request stopped
```

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Partial acquisition

M4 now applies the same cleanup principle at several levels:

```text
CreateMsgPort succeeds       -> DeleteMsgPort
CreateIORequest succeeds     -> DeleteIORequest
OpenDevice succeeds          -> CloseDevice
SendIO starts request        -> establish completion before cleanup
```

A cleanup operation is performed only for a resource that was actually acquired, and dependent resources end before the resources they depend on.

## Summary

`AbortIO()` requests cancellation. `WaitIO()` establishes completion. Only after completion may the device, request, and port be released safely.
