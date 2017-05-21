#### Digestif

So I push a new PR to follow my change in digestif. We have two implementation
now, a C and an OCaml implementation and they share the same interface. So you
just need to link to the implementation you want.

I will look the go digest interface to do the same. But I think, we close to a
good API. I asked to Andres Hauptmann to talk about cryptohash. Indeed, it's
another project to provide some hashes functions and I ask to integrate this
work inside Digestif. So, he agreed with me and when I have the time, I will
integrate this work.

#### Decompress

I found a bug about one information available in Decompress, so I fixed it in a
new PR. This change does not impact the API. So, I will wait the next release of
Decompress to merge this PR.

#### TypeBeat / Farfadet

Nothing to do.

#### Angstrom

I just try to optimize Angstrom from @seliopou just for my curiosity and try to
use the `[@@unboxed]` tag to the representation of a parser. But it seems to not
be good. When I launch the benchmark, I noticed regression about performance. I
don't know why but I noticed @seliopou about that in Slack.

#### ocaml-git / sirodepac

I tried to control the memory consumption of `sirodepac` to try to compute a
huge PACK file (like the PACK file from datakit). So, I try to limit the
allocation of the deserialization and the serialization.

The problem is simply. Sometimes, `git` computes a huge git object. The problem
is: we can't store all of this git object in memory (like if this huge object
has 1 Go, we may be catch a `Out_of_memory`). This situation appear when we
compute the PACK file in a *stop the world* context. We loaded all the git
object inside the memory, then we compute the git object.

My idea and for the context of datakit is to continue to follow the non-blocking
implementation and avoid any *stop the world* computes in the serialization and
deserialization.

For the deserialization, it's already done. You can write directly step by step
a huge git object with a fixed size buffer (and avoid to load all the git object
inside memory). The API is very close to the non-blocking API from Mr. Mime,
Decompress or dbuenzli's library. The state/context needed to deserialize a git
object does not allocate any buffer. You need to notice which buffer the state
can use (so we let the user to allocate the buffer needed to deserialize any git
object). So, obviously, it's not easy-to-use (like the API of Decompress)
because we let the user to control the memory fingerprint of this specific
compute.

It's what git does. It prefers to use the file system instead the memory because
it know than it's possible to have a huge git object. So it uses a lot of the
`mmap` syscall. `sirodepac` do the same.

About the serialization, it's complex but not impossible. Firstly, I separate
the compute of the delta-ification from the deserialization. The bad point is,
the delta-ification is a *stop-the-world* algorithm (the Rabin's fingerprint is
a *stop-the-world* algorithm specifically). So, the point is continue to let the
user to control the memory fingerprint of this compute and it's possible by the
`lru` library from David. Indeed, with this library we can control how many
bytes you allow for this cache.

The point is, with the `git` algorithm, we need a cache/window to try to
delta-ify the current git object with a previous git object. So the cache/window
can be huge (because, it contains, by default, 10 git object, and these git
objects can be huge). Then, we update this cache/window but we allocate a lot
just to store the previous git object.

So, I decide to separate this compute from the serialization for two reasons:

* Firstly, because it's a *stop-the-world* algorithm, we can't consume step by
  step a git object and need to store all of some git objects.
* Secondly, to let a optimization without any dependence with the serialization
  (like try to paralyze this compute, like `git`).

So, we can change the serialization to be a non-blocking implementation and use
a fixed size buffer to contain an huge git object step by step. The idea, then,
is use the characteristic of the non-blocking axiom of the deserialization
inside the non-blocking axiom of the serialization. That means:

When you try to serialize a PACK file, we need to serialize all git object
inside this PACK file. One way (the previous way) is load all git objects inside
memory and serialize all of these inside the PACK file but the memory
consumption is too huge.

The new implementation asks the user which git object it wants to serialize.
Then, we have a fixed size buffer to store a part of this specific git object.
So step by step, we fill this buffer, we let the serializer to compute this
buffer, we flush the buffer and continue to fill it while we are not finish to
compute all data from this git object.

One point is, a git object is commonly come from another PACK file. So we
deserialize in a fixed size buffer what the serializer wants and at the same
time, we serialize this fixed size buffer and continue to the end of this git
object. So, it's very complex because inside the serialization, we have a
deserialization ... And we need to synchronize contexts used for serialization
and the deserialization together to not lost any data. it's complex to deal with
it but it's possible and it's what I did this week - I did a part, not all.

Then, we have a technical point about a git object provided by the
deserialization delta-ified. In this context, you need to load the source git
object inside the memory to construct the git object requested ... But you can
limit the memory assumption to `max_int32 + 0x10000` because the Rabin's
fingerprint is done only on this area. So, we continue to control precisely the
memory consumption.

Voilà voilà :D !

