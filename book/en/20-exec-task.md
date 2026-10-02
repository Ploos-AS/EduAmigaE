# Exec and the current task

## Goal

After this lesson you should be able to explain what an Exec task represents, obtain a pointer to the current task, and distinguish observing an existing OS structure from owning a resource that must be released.

## Execution context

Exec schedules work as tasks. Our program is already running in an execution context when `main()` begins, so we do not need to create another task merely to inspect the one in which we are already running.

E-VO 3.9.4's Exec definition contains:

```text
FindTask(name)
```

and the upstream `extra_examples/tasklist.e` example uses:

```text
task := FindTask(NIL)
```

to obtain the current task.

## The task structure

The `exec/tasks` module defines `OBJECT tc`. It includes node information, state, and the signal fields `sigalloc`, `sigwait`, `sigrecvd`, and `sigexcept`.

The course example uses a typed pointer:

```text
DEF task:PTR TO tc
```

This connects the pointer knowledge from M3 directly to a real operating-system structure.

## Borrowed pointer, not owned resource

The pointer returned by `FindTask(NIL)` describes a task already managed by Exec. The example did not allocate that task and must therefore not attempt to release it.

This gives us an important new ownership category:

```text
owned resource   -> release it
borrowed pointer -> do not release it
```

Having a pointer does not automatically mean that the program owns the object to which it points.

## Example

See `examples/20-exec-task/current-task.e`. The program validates the pointer and prints a deterministic status line rather than a task name or address, because those details may vary between runtime profiles.

The qualification case is locked only after E-VO 3.9.4 compilation and amiga-runtime execution.

## Summary

`FindTask(NIL)` lets us observe the current Exec task. The pointer is borrowed from the operating system, not a resource for us to release.
