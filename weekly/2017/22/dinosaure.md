#### ocaml-git / sirodepac

Previously, I found a bug in my implementation. Now all is ok we can serialize
all git object with a fixed size memory consumption. It's done by a
deserialization with a fixed size memory consumption. So I played with some
buffer between the serialization and the deserialization and all is fine. The
produced PACK file work and we keep the integrity of the data.

I asked to Gemma to have an access to a machine to run some huge tests about the
compression.

Then, I finish to write the documentation for ALL modules. All modules are
explained and some tricks and implementation specified are described inside the
ML file. I hope all is clear and someone can read and understand the code.

I started to integrate all in ocaml-git. So, I did some big change.

- I replaced the LRU module from Simon Cruanes by the implementation provided by
  David as the `lru` package in OPAM. A good point about this library is to
  control precisely the memory consumption of your object (and no how many
  object you can store). This point is good to keep the precise control about
  memory consumption because when we store some git object inside the cache, may
  be one took 1 Go and one other took 100 Ko. So, instead to keep these 2
  objects, we keep one of them if we limit the memory consumption by 5 Go for
  example.

- I cleaned the interface of the CRC-32 checksum and provide a new type `t`
  which one is a `private int32`. So we keep the abstraction about the CRC-32
  (and don't do a mistake with the `int32`) and optimize the the computation
  when we want to serialize to an `int32` (by the sub-typing: `v :> int32`).

I go to take my car to Sieam Reap sorry ...
