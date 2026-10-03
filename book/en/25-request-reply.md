# Request/reply with Exec messages

## Goal

After this lesson you should be able to track ownership of a message through the complete request/reply protocol and explain why the sender must wait for the reply before reusing or freeing the message memory.

## Two ports, two directions

A request/reply exchange needs somewhere to send the request and somewhere to return the completed message.

The example therefore creates:

```text
requestPort
replyPort
```

The message header points back to the sender's reply port:

```text
message.replyport := replyPort
```

## The complete lifetime

The protocol is:

```text
sender owns message
        |
        v
PutMsg(requestPort, message)
        |
        v
request in flight
        |
        v
receiver: GetMsg(requestPort)
        |
        v
ReplyMsg(message)
        |
        v
reply in flight
        |
        v
sender: GetMsg(replyPort)
        |
        v
sender owns message again
```

Only after the final `GetMsg()` may the sender safely reuse or free the message memory.

## ReplyMsg uses replyport

The receiver does not need separate knowledge of the sender's port. `ReplyMsg()` uses the reply port already stored in the message header.

This is an important AmigaOS pattern: the request carries the information needed to return it to its owner.

## Same task, real protocol

The teaching example executes both roles sequentially in the same task. This makes execution deterministic, while the message lifetime remains the same as when sender and receiver are different tasks or when the receiver is an OS service.

## Cleanup

Both ports must remain alive while the message can be in flight. They are therefore deleted only after the reply message has been retrieved.

The message is likewise released only after the reply is back with the sender.

This gives a general rule:

> Resources referenced by an in-flight operation must live at least as long as that operation.

## Example

See `examples/25-exec-reply/request-reply.e`.

Expected success output:

```text
message replied
```

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Where this leads

The request/reply model applies directly to Amiga devices. An I/O request contains a message header and asynchronous completion uses the same kind of port and signal mechanism.

## Summary

`PutMsg()` sends ownership into the protocol. `ReplyMsg()` returns the message through `replyport`. The sender regains control of the message memory only after retrieving the reply from the reply port.
