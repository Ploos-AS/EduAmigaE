# Devices and the I/O request lifetime

## Goal

After this lesson you should be able to open an Amiga device with an I/O request and clean up the port, request, and device in the correct order.

## A device needs more than OpenDevice

Amiga devices use the message mechanism we have already learned. Before opening `timer.device`, we therefore create a message port and an I/O request.

E-VO 3.9.4's `devices/timer` defines `OBJECT timerequest`, containing an Exec `io` structure and timer data.

The upstream `extra_examples/clock.e` uses the same chain as the course example:

```text
CreateMsgPort()
CreateIORequest(port, SIZEOF timerequest)
OpenDevice(...)
```

## Three nested lifetimes

The resources depend on one another:

```text
message port
    |
    +-- I/O request
           |
           +-- opened device
```

Cleanup therefore happens in reverse order:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

The request must remain alive while the device is open, and the port must remain alive while the request may use it.

## OpenDevice return value

The upstream E-VO example tests:

```text
OpenDevice(...)=0
```

Zero means that the device opened successfully. Only then do we have a device lifetime that must end with `CloseDevice()`.

If `OpenDevice()` fails, the request must still be deleted and the port must still be deleted, but we must not call `CloseDevice()` for a device that never opened.

## Why timer.device?

`timer.device` is useful because it later lets us demonstrate both synchronous and asynchronous I/O without filesystem or GUI dependencies.

We use:

```text
TIMERNAME
UNIT_MICROHZ
```

from E-VO's `devices/timer` module.

## Example

See `examples/26-device-lifetime/open-timer.e`.

Expected success output:

```text
timer.device opened
```

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Next step

We now own the infrastructure for a device operation. The next lesson fills in the `timerequest` and submits a synchronous operation with `DoIO()`. After that we can move to `SendIO()`, `WaitIO()`, and cancellation.

## Summary

Device programming builds on Exec messages. Create the port, create the request, open the device; then close the device, delete the request, and delete the port in reverse order.
