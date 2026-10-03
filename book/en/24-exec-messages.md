# Sending and receiving Exec messages

## Goal

After this lesson you should be able to put a message on a message port, wait for the port, retrieve the message from the queue, and explain who controls the message memory while it is queued.

## The message header

`exec/ports` defines `OBJECT mn` with, among other fields:

```text
replyport
length
```

Many larger AmigaOS structures contain an `mn` as their message header. In this first exercise we use a plain `mn`.

## The smallest protocol

The Exec FD defines:

```text
PutMsg(port, message)
GetMsg(port)
WaitPort(port)
ReplyMsg(message)
```

This chapter uses the first three:

```text
PutMsg(port, message)
WaitPort(port)
received := GetMsg(port)
```

`PutMsg()` places the message in the port queue and signals the port's task. `WaitPort()` waits until the port has a message. `GetMsg()` removes one message from the queue and returns its pointer.

## In-flight ownership

The example allocates the message with `NEW message`. The program owns the memory, but after `PutMsg()` it must treat the message as **in flight**.

```text
NEW
 |
 v
owned by sender
 |
PutMsg
 |
 v
in flight / queued
 |
GetMsg
 |
 v
owned locally again
 |
END
```

The message memory must not be freed or reused while the message is still in the port queue.

In our small example the sender and receiver are the same program. We can therefore retrieve the same message and only then release it.

## No ReplyMsg yet

We set:

```text
message.replyport := NIL
```

This message therefore has no reply protocol. That is deliberate. In the next lesson the sender gets a reply port and we follow the complete request/reply lifetime with `ReplyMsg()`.

## Drain before deleting the port

The port is deleted only after the message has been removed with `GetMsg()`. Deleting a port while messages remain queued would leave ownership unresolved.

## Example

See `examples/24-exec-message/send-message.e`.

Expected success output:

```text
message received
```

The qualification case is locked only after actual E-VO 3.9.4 compilation and amiga-runtime execution.

## Summary

`PutMsg()` transfers a message into a port queue. `WaitPort()` waits for queue activity, and `GetMsg()` removes the message again. Between `PutMsg()` and `GetMsg()`, treat the message as in flight.
