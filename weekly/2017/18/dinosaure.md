#### Decompress

Prepare next 0.6 release.

#### BLAKE2B / Digestif

Prepare release 0.1.

#### Farfadet

Nothing to do.

#### TypeBeat

Nothing to do.

#### sirodepac / ocaml-git

It's DONE! I just finished to implement the git heuristic in `sirodepac` and the
result is:
 - we produce a PACK file with 1.3MB
 - git produces a PACK file with 1.2MB
 
So, yes ... now all is done. `sirodepac` is finished and, we can start the
integration in `ocaml-git`.

So I need to explain by step what I did:

 * Firstly, I functorize the *packer* by a zlib implementation module. Now, we
   can use `decompress` or `camlzip`. I did that because `decompress` is not the
   best to inflate (the diff is about some bytes) and to follow exactly what git
   does, I decide to functorize the implementation.
   
   The diff between a *packer* with `decompess` and `camlzip` is about 0.1MB.
   So, it's ok.
   
 * I reproduce exactly the same sort as git. This is the core of the PACK
   algorithm to find the best diff between 2 git objects.
   
 * I finish to implement the Rabin's fingerprint and the diff with that. I
   optimized the compute to avoid any allocation of `Cstruct.t`. The result is
   exactly the same as git.
   
 * I switch the window implementation of the *packer* to the `lru` project from
   David. So, I add a dependency but it's ok. It's to follow, again, what git
   does and when git find a good delta, it promotes this delta in the window.
   
 * I seperate the serialization from the compute of the delta-ification. A good
   point is to let a new optimization and thread the compute of the
   delta-ification. This is what git does but need lot of work. So, for the
   moment, the algorithm is sequential but we can improve independantly than the
   serializer.
   
 * Implement topological sort to ensure we don't miss any diff for all git
   object.
   
 * Handle a diff with an object outside the PACK file.
   
 * Clean all
