#### ocaml-git / sirodepac

So I most done my last task about `sirodepac` and control the memory
consumption. But I found a bug and it's about the serialization of a hunk. I
created a mini hunks decoder to help to find the bug. And now, I know precisely
where is it. So I will fix this and continue to test some others PACK files with
an implementation of `zlib` and `decompress`.

I hope, I finish this week this bug, it's a very deep bug but it's ok, in same
time, I put some useful comments to help me to understand my code and check my
implementation.

#### Conferences

So, I created a new talk for the Functional Conference in India and my talk was
accepted! Then, Mark Li asked me to do a CUFP tutorial about Git in OCaml. I
think about this and OCaml labs was agreed to do this. So, I prepare in my mind
what I will do and ship an abstract before the deadline.
