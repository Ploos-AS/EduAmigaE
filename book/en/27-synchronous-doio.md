# Synchronous I/O with DoIO

## Goal

After this lesson you should be able to fill in a timer request, submit it synchronously with `DoIO()`, and explain what synchronous execution means for the request lifetime.

## From an open device to an operation

The previous lesson created the infrastructure:

```text
message port -> I/O request -> open timer.device
```

Now we use the request for an actual operation.

E-VO 3.9.4's `devices/timer` defines:

```text
TR_ADDREQUEST
timerequest.io
timerequest.time.secs
timerequest.time.micro
```

The upstream `extra_examples/clock.e` uses the same fields for timer requests.

## The request

The example sets:

```text
request.io.command := TR_ADDREQUEST
request.time.secs := 0
request.time.micro := 10000
```

This describes a short timer request of 10,000 microseconds.

## DoIO blocks

We then call:

```text
result := DoIO(request)
```

`DoIO()` is the synchronous form. The call returns only when the operation has completed.

Ownership is therefore simple:

```text
prepare request
      |
      v
DoIO(request)
      |
      | task waits
      v
operation complete
      |
      v
request may be reused
```

When `DoIO()` returns, the request is no longer in flight.

## Return value

The example tests the return value and treats zero as success:

```text
IF result = 0
```

We print only deterministic result text, not timing measurements. Scheduler and emulator timing therefore do not affect expected stdout.

## Cleanup

After `DoIO()` completes we can use the same cleanup sequence as before:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

Doing this while an asynchronous request remained active would be incorrect. That distinction is the subject of the next lesson.

## Example

See `examples/27-device-doio/timer-doio.e`.

Expected success output:

```text
timer request complete
```

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Next step

The next lesson replaces `DoIO()` with `SendIO()`. Control then returns before the operation is complete, so the program must explicitly handle completion with `WaitIO()` and safe cancellation with `AbortIO()`.

## Summary

`DoIO()` submits a device request and waits for it to complete. After return the request is available to the program again, making synchronous I/O the simplest device model.
