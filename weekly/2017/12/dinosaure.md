#### Decompress

Nothing  to do.  @engil  found a  bug  in Canopy  but I  think,  it's not  about
Decompress. Indeed, I  use Decompress in `sirodepac`  and all is ok.  But I will
inspect what is wrong - because, may be it's `ocaml-git`.

#### BLAKE2B / Digestif

I  continue to  polish this  package. I  try to  provide an  interface with  the
`Bytes.t` modules and break the *hard*  dependency with `cstruct`. But, in fact,
the end-user can  use `cstruct` if he  wants (`cstruct` is a  `bigstring` and by
default, the  API provide a `bigstring`  compute). Another point is  to separate
the pure implementation of the hash  function in OCaml (in Digestif library) and
a C implementation with an OCaml  interface (in Rakia library). So, Digestif can
be used in Mirage, JavaScript and OCaml - but I need to work a long time in this
project.

I just finish to create a generic test suite between `bigstring` and `bytes` and
I need to  fix the problem with the  `bytes` in the Rakia library.  Then, I will
re-implement the hash function in pure OCaml.

#### sirodepac / ocaml-git

I finished the serialization  of the IDX file. I talked  with @samoth about that
and all works fine. To test, I  deserialize an IDX file, serialize the IDX file,
and deserialize the output  and compare the result. I use a  radix tree to store
the IDX file and I have a lazy implemenation (like `ocaml-git`).

I try to  implement the patience diff (without `core_kernel`  package) to try to
serialize  the PACK  file. Indeed,  inside  the PACK  file, all  git object  was
compressed by  Decompress and by a  diff function. So,  I already have a  PoC in
`sirodepac`. I don't know  if I need to create a new package  for this thing but
the good thing is that we have  no dependencies. When I check my implementation,
I will implementation the core of the serialization of the PACK file.

#### Farfadet

Nothing to do.

#### Mr. MIME

Nothing to do.
