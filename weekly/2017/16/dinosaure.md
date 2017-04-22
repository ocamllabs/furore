#### Decompress

Nothing to do.

#### BLAKE2B / Digestif

Used in `sirodepac` with no bug. Update the interface (and add the `type t`) but not very much more work.

#### Farfadet

Nothing to do.

#### TypeBeat

Nothing to do.

#### sirodepac / ocaml-git 

2 good news. I finish to implement the serialization of the PACK file and use my
patience diff to try to compress the PACK file. Now, the result is: we produce a
PACK file of 13MB and before, the length was ~21MB. So we reduce the length by 2
times! But it's not the best, [git] produced a PACK file with length: 2MB. I
will try to find why we are wrong and I think, it's about the patience diff. But
we are in the good way and now, we just need to improve and optimize the
serialization.

In other side, I optimized the deserialization. Now, when you want a Git object
from a PACK file, you just need to allocate 4 buffers (2 to inflate and 2 to
undelta-ified the git object).

This result is possible because:

* we have a non blocking interface so we can start at any position of the PACK
  without a complexe description of a context (the state)

* we compute the PACK file as the way than [git]. Indeed, [git] does not open
  the PACK file but some part of the file. We do the same to avoid the OCaml
  limitation about the native integer (and compute a huge PACK file firstly) and
  limit the allocation of what is needed to get the object. So, we avoid an
  attack by allocation.
  
* we externalize all big allocation from the decoder state. The state is pure
  and don't have any internal buffer inside. The user need to specify 2 buffers
  (to inflate the git object) and can decide the length of these buffers. Then,
  the decoder handles these buffers without any problem but the purpose of the
  state is: it stores only some integers! So, obvisouly, it is located in the
  minor heap (like Decompress), I just follow some advises from Jeremy Yallop
  about that.
  
* The 2 other buffers is about the undelta-ification of a PACK object to a git
  object. We can know the length needed to store a git object. So we just try to
  find the max length needed to undelta-ified a PACK object firstly.
  
  Undelta-ified means take a git object, a hunk (which it's list containing a
  data or an offset and a length to copy from the base git object to the new git
  object) and try to apply the hunk with the base git object to produce a new
  git object.
  
  Obviously, we can have a delta of a delta of ... a delta of a git object. So
  we need to follow the chain and get the max length of all base git object
  needed to undelta-ified the git object requested.
  
  Then, we just need to use 2 buffers and flip one to other for each
  undelta-ification. At the end, one of these buffers contains the git object
  requested.
  
So, it's a good optimization.

Finally, my last work is a functorization of the hash function (like ocaml-git)
and an application with `Digestif`. I write a documentation too about the
decoder firstly but I think is useless.

The next job is to try to optimize the serialization and understand how git can
produce a small PACK file. But I think, I have an idea about that.
