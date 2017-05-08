  - Worked out how to do asynchronous syscalls by dynamically
    adjusting concurrency level with SCHED_IDLE threads. Should get us
    something like Haskell's safe foreign calls, but with much lower
    overhead.

  - Helped out with a pretty panicked TFP submission on the design of
    our effectful I/O (blocking syscalls, asynchronous effects, and
    the likes)
