#### ocaml-git / sirodepac

I still in the integration of the sirodepac code-base inside the ocaml-git
project. About all read operation, all is good, I found a bug in the beginning
of this week but I fixed this quickly. Then, I continue to try to integrate the
serialization.

So, previously, I said I used the couple Angstrom/Faraday from Seliopou.
Angstrom is perfect but Faraday is specialized to serialize and write directly
to an output (by iovec). However, by the API, I'm not free to decide how to write a Git object.

Firstly because iovec is not available with lwt (and we have a strong dependency
with lwt) and because the way to serialize with Faraday is to up two process.
One to write inside the Faraday encoder and the second to write to the output.
In the ocaml-git context, it's better to let the user to do this choice.

But sometime, internally, I need to serialize a Git object to obtain a digest
for example - but we have some other use-case when the serializer does not
interact directly with the output (and the PACK file serializer is another good
example).

So, I decide to provide at the same time a little encoder (minienc) to serialize
a Git object correctly in a fixed size buffer (I use a ring-buffer and a queue
in a limited context). The good point is, to digest (or serialize in the PACK),
we continue to control the memory consumption strictly. So this encoder is done.
However, it's may be better to provide an interface « à la Farfadet » or « à la
Printf-like » for this encoder and improve the re-usability of the code. But I
want to move fast, so not yet.

#### Digestif

I implemented the MD5 hash function in OCaml and rename the library. So if you
want to use the C implementation of the hash, you just need to link with
`digestif.c`. Otherwise, for the OCaml implementation, you can link with
`digestif.ocaml`.

#### Radix/Patricia tree

When I worked on sirodepac, I re-used a code from BeSport about the
implementation of a tree to store some object binding with a key. @g2p seems to
want the same but with a remove operation.

So, may be I will start a benchmark to compare my implementation with standard
implementation of Map in OCaml - I already did a benchmark between my
implementation and the implementation of the Thomas and I'm more fast (but use a
lot of memory).
